Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 01 Dec 2010 17:28:32 +0100 (CET)
Received: from mail-gy0-f177.google.com ([209.85.160.177]:59099 "EHLO
        mail-gy0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1493021Ab0LAQ23 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 1 Dec 2010 17:28:29 +0100
Received: by gyg4 with SMTP id 4so3796439gyg.36
        for <multiple recipients>; Wed, 01 Dec 2010 08:28:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:to:content-type
         :date:message-id:mime-version:x-mailer:content-transfer-encoding;
        bh=yJr4s0+/AzPVHLmHb0byZkHv+o2Gf9+2kB8Q5kKviYA=;
        b=n3z+y7A6q2IaiPEWUuPXtYnr7H6wu8B0uUFx13czNG84atP3nB59JxBu5nVRKF65Ro
         p6zUqfGqJfCqbmtN5CnSIoo7b40k3ACkBrXjIBFKMrR8Xw5GZNFA/LKxJ8JpCYjtQDEk
         DXzyhUO5LGHAAgV1C41OAqS/a20/W2POHasLc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:to:content-type:date:message-id:mime-version:x-mailer
         :content-transfer-encoding;
        b=wXFJOg0dS24S3ZAZCgGNKY7lWDd+UlJbuKh4rTvMFyHH1krQto6OuaWFKqPVuDolal
         ZDs//j5Q1RjMFJr9wuc0lBh/jPfqkpMccUb+q60VXPZIuCEubVBMnsSPNW+K7Yr/qXdp
         WX+4RoiOe/A2OuIKPrUNQiz5rhYUo09EejaQI=
Received: by 10.223.109.200 with SMTP id k8mr8523487fap.136.1291220903161;
        Wed, 01 Dec 2010 08:28:23 -0800 (PST)
Received: from [172.16.48.51] ([59.160.135.215])
        by mx.google.com with ESMTPS id n7sm75010fam.11.2010.12.01.08.28.20
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 01 Dec 2010 08:28:22 -0800 (PST)
Subject: [PATCH] ifdef gic_present variable that is used only by malta
From:   Anoop P A <anoop.pa@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Date:   Wed, 01 Dec 2010 22:01:15 +0530
Message-ID: <1291221075.31413.24.camel@paanoop1-desktop>
Mime-Version: 1.0
X-Mailer: Evolution 2.28.3 
Content-Transfer-Encoding: 7bit
Return-Path: <anoop.pa@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28588
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anoop.pa@gmail.com
Precedence: bulk
X-list: linux-mips

gic_present variable will be used only in malta platforms.Other
platforms with VSMP support will throw link error.
 

Signed-off-by: Anoop P A <anoop.pa@gmail.com>
---
 arch/mips/kernel/smp-mt.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/mips/kernel/smp-mt.c b/arch/mips/kernel/smp-mt.c
index 43e7cdc..5b91c1a 100644
--- a/arch/mips/kernel/smp-mt.c
+++ b/arch/mips/kernel/smp-mt.c
@@ -151,6 +151,7 @@ static void vsmp_send_ipi_mask(const struct cpumask
*mask, unsigned int action)
 
 static void __cpuinit vsmp_init_secondary(void)
 {
+#ifdef CONFIG_MIPS_MALTA
 	extern int gic_present;
 
 	/* This is Malta specific: IPI,performance and timer inetrrupts */
@@ -158,6 +159,7 @@ static void __cpuinit vsmp_init_secondary(void)
 		change_c0_status(ST0_IM, STATUSF_IP3 | STATUSF_IP4 |
 					 STATUSF_IP6 | STATUSF_IP7);
 	else
+#endif /* CONFIG_MIPS_MALTA */
 		change_c0_status(ST0_IM, STATUSF_IP0 | STATUSF_IP1 |
 					 STATUSF_IP6 | STATUSF_IP7);
 }
-- 
1.7.0.4
