Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 06 Dec 2010 09:19:41 +0100 (CET)
Received: from mail-gw0-f41.google.com ([74.125.83.41]:56271 "EHLO
        mail-gw0-f41.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491054Ab0LFITi (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 6 Dec 2010 09:19:38 +0100
Received: by gwj22 with SMTP id 22so4107178gwj.28
        for <multiple recipients>; Mon, 06 Dec 2010 00:19:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:to:content-type
         :date:message-id:mime-version:x-mailer:content-transfer-encoding;
        bh=+fxkZXi+Cg7DJfBTXhmoccm/xp1O000fFa/LX7Cp2sM=;
        b=DvBElsQbisrC3onhIsHAM/P8aDnTjTfk0h97O+wzEokIbegn+sPYe2XVZ/mtEpXmqT
         3HOkCR5/1byEJ0qFVLoz0KQDaMAMdJ1XzSy7qnFEj8HV0f6/MCMXcKoZt8o67ZL4sb1g
         q+IjYgOI7ZxxwFf58spV86NlhibeP136Th6Ck=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:to:content-type:date:message-id:mime-version:x-mailer
         :content-transfer-encoding;
        b=KGRFXhriWcgZMo890kF8En6sC6Capuh8KMFHOkYlN4x/8TET1n21vuRqhMQSVjiBx1
         mkstEL7ffxvy7dcXP/bX+FWLATBbDK/Vg+NaLG+pXF17vyOc7cEaLPxi2zqqL4iBqNFZ
         BKiXtOKt8A6ynxVcygYieZiL40XEIHizk3Scc=
Received: by 10.91.189.16 with SMTP id r16mr7363619agp.73.1291623571505;
        Mon, 06 Dec 2010 00:19:31 -0800 (PST)
Received: from [172.16.48.51] ([59.160.135.215])
        by mx.google.com with ESMTPS id c24sm5215896ana.10.2010.12.06.00.19.28
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 06 Dec 2010 00:19:30 -0800 (PST)
Subject: [PATCH] Introduce mips_late_time_init
From:   Anoop P A <anoop.pa@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Date:   Mon, 06 Dec 2010 13:53:32 +0530
Message-ID: <1291623812.31822.6.camel@paanoop1-desktop>
Mime-Version: 1.0
X-Mailer: Evolution 2.28.3 
Content-Transfer-Encoding: 7bit
Return-Path: <anoop.pa@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28610
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anoop.pa@gmail.com
Precedence: bulk
X-list: linux-mips

This patch moves plat_time_init and clocksoure init funtion calls to
late_time_init. 

Signed-off-by: Anoop P A <anoop.pa@gmail.com>
---
diff --git a/arch/mips/kernel/time.c b/arch/mips/kernel/time.c
index fb74974..dbd1ac5 100644
--- a/arch/mips/kernel/time.c
+++ b/arch/mips/kernel/time.c
@@ -117,10 +117,16 @@ static __init int cpu_has_mfc0_count_bug(void)
 	return 0;
 }
 
-void __init time_init(void)
+void __init mips_late_time_init(void)
 {
 	plat_time_init();
 
 	if (!mips_clockevent_init() || !cpu_has_mfc0_count_bug())
 		init_mips_clocksource();
 }
+
+
+void __init time_init(void)
+{
+	late_time_init = mips_late_time_init;
+}
