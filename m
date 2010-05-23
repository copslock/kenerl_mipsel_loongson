Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 23 May 2010 21:55:48 +0200 (CEST)
Received: from fg-out-1718.google.com ([72.14.220.156]:16339 "EHLO
        fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491961Ab0EWTw3 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 23 May 2010 21:52:29 +0200
Received: by fg-out-1718.google.com with SMTP id 22so1361831fge.6
        for <multiple recipients>; Sun, 23 May 2010 12:52:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references;
        bh=6rQ1quS8j318E14XiL0TcYL93q6xNlVs0SA5f96LcJ8=;
        b=nHzMZcOJdUhr3CPyjfNmAJ3cjP3WQQouWc2u5vNi8514E8ojYP1c2Yge4vyrarbCKq
         vKXEW4lWTaap88unU78lsQPhwCeqXNL+e6ze0ozowC2oRM5JOBTSFohbseuhDd769xKc
         3nVQcre7IwL1yMkSx5AryvqwM9nSEn7lKf4k4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        b=r5QiGBHE5AGdU2M4+MXLbJkdEDYn3+hORnvU/oEchRDkSbHTUO4TsDg4VFRDZFAamd
         YYAqceyGEJgAzqOHQPM4JXm75yvqdcdaaG1hIoKSmcSdwiyOsUUTGALM32/bmjyzj3if
         XfFeevs30A19s3T4VZ4GOZqov6d+1blvmbiNg=
Received: by 10.87.47.17 with SMTP id z17mr7179236fgj.39.1274644349038;
        Sun, 23 May 2010 12:52:29 -0700 (PDT)
Received: from localhost.localdomain (net-93-145-200-9.t2.dsl.vodafone.it [93.145.200.9])
        by mx.google.com with ESMTPS id d6sm6081796fga.3.2010.05.23.12.52.27
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 23 May 2010 12:52:28 -0700 (PDT)
From:   Andrea Gelmini <andrea.gelmini@gelma.net>
To:     andrea.gelmini@gelma.net
Cc:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: [PATCH 169/199] arch/mips/math-emu/sp_tlong.c: Checkpatch cleanup
Date:   Sun, 23 May 2010 21:52:10 +0200
Message-Id: <1274644332-23964-9-git-send-email-andrea.gelmini@gelma.net>
X-Mailer: git-send-email 1.7.1.251.gf80a2
In-Reply-To: <1274644332-23964-1-git-send-email-andrea.gelmini@gelma.net>
References: <1274644332-23964-1-git-send-email-andrea.gelmini@gelma.net>
Return-Path: <andrea.gelmini@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26815
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: andrea.gelmini@gelma.net
Precedence: bulk
X-list: linux-mips

arch/mips/math-emu/sp_tlong.c:75: ERROR: else should follow close brace '}'

Signed-off-by: Andrea Gelmini <andrea.gelmini@gelma.net>
---
 arch/mips/math-emu/sp_tlong.c |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/arch/mips/math-emu/sp_tlong.c b/arch/mips/math-emu/sp_tlong.c
index 4be21aa..92cd9c5 100644
--- a/arch/mips/math-emu/sp_tlong.c
+++ b/arch/mips/math-emu/sp_tlong.c
@@ -71,8 +71,7 @@ s64 ieee754sp_tlong(ieee754sp x)
 			round = 0;
 			sticky = residue != 0;
 			xm = 0;
-		}
-		else {
+		} else {
 			residue = xm << (32 - SP_MBITS + xe);
 			round = (residue >> 31) != 0;
 			sticky = (residue << 1) != 0;
-- 
1.7.1.251.gf80a2
