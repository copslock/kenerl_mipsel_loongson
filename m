Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 23 May 2010 21:55:01 +0200 (CEST)
Received: from mail-fx0-f49.google.com ([209.85.161.49]:38392 "EHLO
        mail-fx0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491957Ab0EWTw0 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 23 May 2010 21:52:26 +0200
Received: by fxm15 with SMTP id 15so2106674fxm.36
        for <multiple recipients>; Sun, 23 May 2010 12:52:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references;
        bh=gwvDTBskkWZJXFAg/gp1KCPnZsMjF7oVkGaHoeS5x2c=;
        b=RMT3HZKhHX8Pfj5z7YF4JRzD7KnbQDpAlSaO52sp4uwS1oGJ3fihck7vBFj6zhzwrt
         PHBWxyxGKdUvvDmyioMPBWehQc+E1ShK0F/GBugwCHEJQW+Hopo+pjX+p0gpiidUylyJ
         7Q31L3M3LWZ3/YB5CLuv9jGcQKYBdLNttN96w=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        b=YNu84FB968expBgBxM878Cs2ZuU+tEDdsXhJdTOt6uPG+XcBkzME26hy3haC5YNHZG
         nWk0lI+Zp+h/VUlOiGJPaJxbjpDpXRlDWoDGZPPc9Sh74377VxpKPGVsQigUFKEzzFps
         C/zSTQe6EogXZjf+ZFIiaDBmfYm2y35bz8NNQ=
Received: by 10.87.47.17 with SMTP id z17mr7179081fgj.39.1274644340717;
        Sun, 23 May 2010 12:52:20 -0700 (PDT)
Received: from localhost.localdomain (net-93-145-200-9.t2.dsl.vodafone.it [93.145.200.9])
        by mx.google.com with ESMTPS id d6sm6081796fga.3.2010.05.23.12.52.19
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 23 May 2010 12:52:20 -0700 (PDT)
From:   Andrea Gelmini <andrea.gelmini@gelma.net>
To:     andrea.gelmini@gelma.net
Cc:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: [PATCH 164/199] arch/mips/math-emu/dp_modf.c: Checkpatch cleanup
Date:   Sun, 23 May 2010 21:52:05 +0200
Message-Id: <1274644332-23964-4-git-send-email-andrea.gelmini@gelma.net>
X-Mailer: git-send-email 1.7.1.251.gf80a2
In-Reply-To: <1274644332-23964-1-git-send-email-andrea.gelmini@gelma.net>
References: <1274644332-23964-1-git-send-email-andrea.gelmini@gelma.net>
Return-Path: <andrea.gelmini@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26813
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: andrea.gelmini@gelma.net
Precedence: bulk
X-list: linux-mips

arch/mips/math-emu/dp_modf.c:32: ERROR: "foo * bar" should be "foo *bar"

Signed-off-by: Andrea Gelmini <andrea.gelmini@gelma.net>
---
 arch/mips/math-emu/dp_modf.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/mips/math-emu/dp_modf.c b/arch/mips/math-emu/dp_modf.c
index 25861a4..a8570e5 100644
--- a/arch/mips/math-emu/dp_modf.c
+++ b/arch/mips/math-emu/dp_modf.c
@@ -29,7 +29,7 @@
 
 /* modf function is always exact for a finite number
 */
-ieee754dp ieee754dp_modf(ieee754dp x, ieee754dp * ip)
+ieee754dp ieee754dp_modf(ieee754dp x, ieee754dp *ip)
 {
 	COMPXDP;
 
-- 
1.7.1.251.gf80a2
