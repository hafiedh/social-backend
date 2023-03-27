CREATE SCHEMA "social";

CREATE IF NOT EXISTS TABLE "social"."users" (
  "id" uuid PRIMARY KEY,
  "email" varchar UNIQUE NOT NULL,
  "password" varchar NOT NULL,
  "profile_name" varchar NULL,
  "signup_date" timestamp
);

CREATE IF NOT EXISTS TABLE "social"."refresh_tokens" (
  "id" uuid PRIMARY KEY,
  "user_id" uuid,
  "token" text UNIQUE,
  "expirate_at" timestamp
);

CREATE IF NOT EXISTS TABLE "social"."revoked_tokens" (
  "id" uuid PRIMARY KEY,
  "refresh_token_id" uuid,
  "token" text UNIQUE,
  "type" enum,
  "revoked_at" timestamp
);

CREATE IF NOT EXISTS TABLE "social"."profiles" (
  "id" uuid PRIMARY KEY,
  "user_id" uuid,
  "gender" varchar,
  "bio" longtext,
  "profile_pictures" longtext NULL,
  "created_at" timestamp,
  "updated_at" timestamp
);

CREATE IF NOT EXISTS TABLE "social"."posts" (
  "id" uuid PRIMARY KEY,
  "user_id" uuid,
  "content" longtext,
  "created_at" timestamp,
  "updated_at" timestamp
);

CREATE IF NOT EXISTS TABLE "social"."follows" (
  "id" uuid PRIMARY KEY,
  "user_id" uuid,
  "follower_id" uuid,
  "created_at" timestamp
);

CREATE IF NOT EXISTS TABLE "social"."comments" (
  "id" uuid PRIMARY KEY,
  "user_id" uuid,
  "post_id" uuid,
  "parent_comment_id" uuid,
  "content" longtext,
  "created_at" timestamp,
  "updated_at" timestamp,
  "deleteed_at" timestamp
);

CREATE IF NOT EXISTS TABLE "social"."likes_for_posts" (
  "user_id" uuid,
  "post_id" uuid,
  "created_at" timestamp,
  "deleteed_at" timestamp
);

CREATE IF NOT EXISTS TABLE "social"."likes_for_comments" (
  "user_id" uuid,
  "comment_id" uuid,
  "created_at" timestamp,
  "deleteed_at" timestamp
);

CREATE IF NOT EXISTS TABLE "social"."likes_for_subcomments" (
  "user_id" uuid,
  "sub_comment_id" uuid,
  "created_at" timestamp,
  "deleteed_at" timestamp
);

CREATE IF NOT EXISTS TABLE "social"."activities" (
  "id" uuid PRIMARY KEY,
  "user_id" uuid,
  "post_id" uuid,
  "activity_type" enum,
  "activity_date" timestamp,
  "comment_id" uuid
);

CREATE IF NOT EXISTS TABLE "social"."feeds" (
  "id" uuid PRIMARY KEY,
  "user_id" uuid,
  "post_id" uuid,
  "author_id" uuid,
  "created_at" timestamp
);

-- ADD INDEXES FOR ALL FOREIGN KEYS WITH BTREE
CREATE INDEX "social"."refresh_tokens_user_id_idx" ON "social"."refresh_tokens" ("user_id") USING BTREE;
CREATE INDEX "social"."revoked_tokens_refresh_token_id_idx" ON "social"."revoked_tokens" ("refresh_token_id") USING BTREE;
CREATE INDEX "social"."profiles_user_id_idx" ON "social"."profiles" ("user_id") USING BTREE;
CREATE INDEX "social"."posts_user_id_idx" ON "social"."posts" ("user_id") USING BTREE;
CREATE INDEX "social"."follows_user_id_idx" ON "social"."follows" ("user_id") USING BTREE;
CREATE INDEX "social"."follows_follower_id_idx" ON "social"."follows" ("follower_id") USING BTREE;
CREATE INDEX "social"."comments_user_id_idx" ON "social"."comments" ("user_id") USING BTREE;
CREATE INDEX "social"."comments_post_id_idx" ON "social"."comments" ("post_id") USING BTREE;
CREATE INDEX "social"."comments_parent_comment_id_idx" ON "social"."comments" ("parent_comment_id") USING BTREE;
CREATE INDEX "social"."likes_for_posts_user_id_idx" ON "social"."likes_for_posts" ("user_id") USING BTREE;
CREATE INDEX "social"."likes_for_posts_post_id_idx" ON "social"."likes_for_posts" ("post_id") USING BTREE;
CREATE INDEX "social"."likes_for_comments_user_id_idx" ON "social"."likes_for_comments" ("user_id") USING BTREE;
CREATE INDEX "social"."likes_for_comments_comment_id_idx" ON "social"."likes_for_comments" ("comment_id") USING BTREE;
CREATE INDEX "social"."likes_for_subcomments_user_id_idx" ON "social"."likes_for_subcomments" ("user_id") USING BTREE;
CREATE INDEX "social"."likes_for_subcomments_sub_comment_id_idx" ON "social"."likes_for_subcomments" ("sub_comment_id") USING BTREE;
CREATE INDEX "social"."activities_user_id_idx" ON "social"."activities" ("user_id") USING BTREE;
CREATE INDEX "social"."activities_post_id_idx" ON "social"."activities" ("post_id") USING BTREE;
CREATE INDEX "social"."activities_comment_id_idx" ON "social"."activities" ("comment_id") USING BTREE;


-- ADD FOREIGN KEYS

ALTER TABLE "social"."posts" ADD FOREIGN KEY ("user_id") REFERENCES "social"."users" ("id");

ALTER TABLE "social"."refresh_tokens" ADD FOREIGN KEY ("user_id") REFERENCES "social"."users" ("id");

ALTER TABLE "social"."feeds" ADD FOREIGN KEY ("user_id") REFERENCES "social"."users" ("id");

ALTER TABLE "social"."comments" ADD FOREIGN KEY ("user_id") REFERENCES "social"."users" ("id");

ALTER TABLE "social"."profiles" ADD FOREIGN KEY ("user_id") REFERENCES "social"."users" ("id");

ALTER TABLE "social"."follows" ADD FOREIGN KEY ("user_id") REFERENCES "social"."users" ("id");

ALTER TABLE "social"."likes_for_comments" ADD FOREIGN KEY ("user_id") REFERENCES "social"."users" ("id");

ALTER TABLE "social"."activities" ADD FOREIGN KEY ("user_id") REFERENCES "social"."users" ("id");

ALTER TABLE "social"."likes_for_subcomments" ADD FOREIGN KEY ("user_id") REFERENCES "social"."users" ("id");

ALTER TABLE "social"."likes_for_posts" ADD FOREIGN KEY ("user_id") REFERENCES "social"."users" ("id");

ALTER TABLE "social"."comments" ADD FOREIGN KEY ("post_id") REFERENCES "social"."posts" ("id");

ALTER TABLE "social"."feeds" ADD FOREIGN KEY ("post_id") REFERENCES "social"."posts" ("id");

ALTER TABLE "social"."activities" ADD FOREIGN KEY ("post_id") REFERENCES "social"."posts" ("id");

ALTER TABLE "social"."likes_for_posts" ADD FOREIGN KEY ("post_id") REFERENCES "social"."posts" ("id");

ALTER TABLE "social"."likes_for_comments" ADD FOREIGN KEY ("comment_id") REFERENCES "social"."comments" ("id");

ALTER TABLE "social"."activities" ADD FOREIGN KEY ("comment_id") REFERENCES "social"."comments" ("id");

ALTER TABLE "social"."likes_for_subcomments" ADD FOREIGN KEY ("sub_comment_id") REFERENCES "social"."comments" ("id");
