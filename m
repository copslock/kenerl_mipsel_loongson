Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 23 May 2010 21:54:37 +0200 (CEST)
Received: from fg-out-1718.google.com ([72.14.220.154]:14987 "EHLO
        fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491955Ab0EWTwZ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 23 May 2010 21:52:25 +0200
Received: by fg-out-1718.google.com with SMTP id 16so812543fgg.6
        for <multiple recipients>; Sun, 23 May 2010 12:52:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references;
        bh=afGbNVU9VXhDhbDg2YTLG2OLlZwp10RSn/ZHMukrqJo=;
        b=JLRg+HZoE41DcwZSGiCk7tICjGb3FRdlp4DOYR8cp3ytNrqTfbGhYB5oxxKJzXVvHt
         Q4uj4Xiv5BQ+q9VYFf61daFPHnhJcZfCmtTXZ+XrV89cfAtUI8DFxGqoiaRdJaRQPmmn
         7bldXZ8jeav/slA0KnnQGH3NhpKpesnxELYYo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        b=VAgnqIalxNL2msAeIBfZG5BOWRjTzI1ja9GC0fgndG6SQy8sMLeoW4/GBAzzKpfi42
         mY01GKNKzswV84TYOxtW66/e6GdjP4+teElRFlttOe07LJcNCRLzliYuNclZp2a/MxnU
         /UzJ3vR439zkwIhwLuqbqMzGfDjjneCh9kDyQ=
Received: by 10.86.6.39 with SMTP id 39mr7287123fgf.4.1274644345512;
        Sun, 23 May 2010 12:52:25 -0700 (PDT)
Received: from localhost.localdomain (net-93-145-200-9.t2.dsl.vodafone.it [93.145.200.9])
        by mx.google.com with ESMTPS id d6sm6081796fga.3.2010.05.23.12.52.24
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 23 May 2010 12:52:25 -0700 (PDT)
From:   Andrea Gelmini <andrea.gelmini@gelma.net>
To:     andrea.gelmini@gelma.net
Cc:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: [PATCH 167/199] arch/mips/math-emu/sp_modf.c: Checkpatch cleanup
Date:   Sun, 23 May 2010 21:52:08 +0200
Message-Id: <1274644332-23964-7-git-send-email-andrea.gelmini@gelma.net>
X-Mailer: git-send-email 1.7.1.251.gf80a2
In-Reply-To: <1274644332-23964-1-git-send-email-andrea.gelmini@gelma.net>
References: <1274644332-23964-1-git-send-email-andrea.gelmini@gelma.net>
Return-Path: <andrea.gelmini@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26812
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: andrea.gelmini@gelma.net
Precedence: bulk
X-list: linux-mips

arch/mips/math-emu/sp_modf.c:32: ERROR: "foo * bar" should be "foo *bar"

Signed-off-by: Andrea Gelmini <andrea.gelmini@gelma.net>
---
 arch/mips/math-emu/sp_modf.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/mips/math-emu/sp_modf.c b/arch/mips/math-emu/sp_modf.c
index 4b1dbac..7656894 100644
--- a/arch/mips/math-emu/sp_modf.c
+++ b/arch/mips/math-emu/sp_modf.c
@@ -29,7 +29,7 @@
 
 /* modf function is always exact for a finite number
 */
-ieee754sp ieee754sp_modf(ieee754sp x, ieee754sp * ip)
+ieee754sp ieee754sp_modf(ieee754sp x, ieee754sp *ip)
 {
 	COMPXSP;
 
-- 
1.7.1.251.gf80a2
