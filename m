Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 25 Sep 2010 21:20:50 +0200 (CEST)
Received: from mail-iw0-f177.google.com ([209.85.214.177]:53892 "EHLO
        mail-iw0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491754Ab0IYTU0 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 25 Sep 2010 21:20:26 +0200
Received: by mail-iw0-f177.google.com with SMTP id 36so4052135iwn.36
        for <multiple recipients>; Sat, 25 Sep 2010 12:20:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:from:date
         :message-id:subject:to:content-type;
        bh=CasjPLKHNM4aBvIKKMAy9zCFE5fE1mF9t+/3ebz+F4M=;
        b=Pq3q27l6W3r8mLCZzO6eWG0hj+1GhLfE4DMAUPpUMw47iaym8LNZNDKISMA296FYUo
         SZQYNFNoE7gFYaz6DdFvupfyZB47SFhxlI7O6L4idx9DXhtiSgd+JWUIiYC0uehd1BE1
         mXhlK9tXXQoDl7ST1pbYMWQeS3ITjDpgqTk8M=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:from:date:message-id:subject:to:content-type;
        b=vejG9YQPdMTjtQuzWhEAA8EVu2Xz+eUVeULCmrzS5kSXy9Yi2GFWE9FcVxYlN6KLdI
         IHuG7DBxvPmyhsDf7XwACmEAeext9dQKQRYR9mUc5MtS4phVsoD/R+BQwQxpJxG5hLWU
         Jitqbf6orEDUm292eqr7XgGG+5WCnsaIaBzPk=
Received: by 10.231.157.11 with SMTP id z11mr6008882ibw.147.1285442425756;
 Sat, 25 Sep 2010 12:20:25 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.231.140.6 with HTTP; Sat, 25 Sep 2010 12:20:05 -0700 (PDT)
From:   Dragos Tatulea <dragos.tatulea@gmail.com>
Date:   Sat, 25 Sep 2010 21:20:05 +0200
Message-ID: <AANLkTi=F2aRd1Edq0+QgwF5+J9So-RVYeUB5qcK5WzRd@mail.gmail.com>
Subject: [PATCH] Fix oprofile -Werror compile failure encountered while doing
 a MIPS Malta build.
To:     linux-mips@linux-mips.org, ralf@linux-mips.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
X-archive-position: 27828
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dragos.tatulea@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 20304

Signed-off-by: Dragos Tatulea <dragos.tatulea@gmail.com>
---
 drivers/oprofile/buffer_sync.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/oprofile/buffer_sync.c b/drivers/oprofile/buffer_sync.c
index b7e755f..a832644 100644
--- a/drivers/oprofile/buffer_sync.c
+++ b/drivers/oprofile/buffer_sync.c
@@ -500,7 +500,7 @@ void sync_buffer(int cpu)
 {
        struct mm_struct *mm = NULL;
        struct mm_struct *oldmm;
-       unsigned long val;
+       unsigned long uninitialized_var(val);
        struct task_struct *new;
        unsigned long cookie = 0;
        int in_kernel = 1;
-- 
1.7.2.3
