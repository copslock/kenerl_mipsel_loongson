Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 23 May 2010 21:54:10 +0200 (CEST)
Received: from fg-out-1718.google.com ([72.14.220.156]:16339 "EHLO
        fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491953Ab0EWTwY (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 23 May 2010 21:52:24 +0200
Received: by fg-out-1718.google.com with SMTP id 22so1361831fge.6
        for <multiple recipients>; Sun, 23 May 2010 12:52:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references;
        bh=ny9Kux6n7E477V4U4BcE+ktxwnMEgalrHRCgUXpWKFY=;
        b=naMfkMuRZiacxZdRVcqTxmJcuVuEjNftkGKCPIISjKwx5qVrhf9TRR5WSG8HjDA8C5
         QG1LwLIKsCL11QORjdkMCZRPNuHARgaya4RGNgOo2Sh/4EA+fsD/BQWaK3sNN75eL4dY
         UgG9inXDWgB008G1eBphnO9+++/C+rMg0ncaA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        b=DiLTaE41jKTbxz6h8TPyCTRRPPOrm3bHWMu09F93TaE7TkhOoHvre6pVy7Kc+2LSAT
         5iy+jp3kbRTcAeam0erEKOqxs+sD/JWQ9ewWJ1MvH9iLektk2GMlY7MMusvST3a+fhQz
         hdww2Q6Rv/EyN3WME6VISekQmN3DM+Nm9lrf4=
Received: by 10.87.70.21 with SMTP id x21mr7162304fgk.62.1274644343969;
        Sun, 23 May 2010 12:52:23 -0700 (PDT)
Received: from localhost.localdomain (net-93-145-200-9.t2.dsl.vodafone.it [93.145.200.9])
        by mx.google.com with ESMTPS id d6sm6081796fga.3.2010.05.23.12.52.22
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 23 May 2010 12:52:23 -0700 (PDT)
From:   Andrea Gelmini <andrea.gelmini@gelma.net>
To:     andrea.gelmini@gelma.net
Cc:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: [PATCH 166/199] arch/mips/math-emu/dp_tlong.c: Checkpatch cleanup
Date:   Sun, 23 May 2010 21:52:07 +0200
Message-Id: <1274644332-23964-6-git-send-email-andrea.gelmini@gelma.net>
X-Mailer: git-send-email 1.7.1.251.gf80a2
In-Reply-To: <1274644332-23964-1-git-send-email-andrea.gelmini@gelma.net>
References: <1274644332-23964-1-git-send-email-andrea.gelmini@gelma.net>
Return-Path: <andrea.gelmini@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26811
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: andrea.gelmini@gelma.net
Precedence: bulk
X-list: linux-mips

arch/mips/math-emu/dp_tlong.c:75: ERROR: else should follow close brace '}'

Signed-off-by: Andrea Gelmini <andrea.gelmini@gelma.net>
---
 arch/mips/math-emu/dp_tlong.c |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/arch/mips/math-emu/dp_tlong.c b/arch/mips/math-emu/dp_tlong.c
index d71113e..0f07ec2 100644
--- a/arch/mips/math-emu/dp_tlong.c
+++ b/arch/mips/math-emu/dp_tlong.c
@@ -71,8 +71,7 @@ s64 ieee754dp_tlong(ieee754dp x)
 			round = 0;
 			sticky = residue != 0;
 			xm = 0;
-		}
-		else {
+		} else {
 			/* Shifting a u64 64 times does not work,
 			* so we do it in two steps. Be aware that xe
 			* may be -1 */
-- 
1.7.1.251.gf80a2
