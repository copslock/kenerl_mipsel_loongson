Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 19 Apr 2014 12:50:05 +0200 (CEST)
Received: from mail-ee0-f47.google.com ([74.125.83.47]:45133 "EHLO
        mail-ee0-f47.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6816199AbaDSKuDIzKrN (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 19 Apr 2014 12:50:03 +0200
Received: by mail-ee0-f47.google.com with SMTP id b15so2294668eek.34
        for <multiple recipients>; Sat, 19 Apr 2014 03:49:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:mime-version:content-type
         :content-transfer-encoding;
        bh=ZOtZ9cWdBXmswao3W+/zNwuhYAv6rc/B2hLnOrWUAlo=;
        b=HhA7iKYuYsunKPF/6qu8ufUyc5NLWi3mLVeEmfiQu/3683UIOF9bg530D8hfqbUh2P
         8ly3E3rHKtxSxnBr1IL0o47ofEGkJf1vtox+0UvNgSZF0f7qy2mywCCnarqYtuL6AzTM
         CGiCA4cAAFhHWFERM8FhpMVZFAgUPBpYtIZP307xIi+5f9rdNB3i6LfASjqdLfMEPwls
         j/AxNdN4v4WATQ0oKTUWfiHXfwN61ScL8OcNgWrPgMlfz9bFYJtmiQ2UbF4UoH6lAQ/v
         +D1Vy/6O8lMmjfI4KzGKy0/SPzAGyaIGVSgn7W4w4zAGEQhmFhSlK+sz980GPLPFrVGF
         Ey7w==
X-Received: by 10.15.43.132 with SMTP id x4mr29725041eev.59.1397904597657;
        Sat, 19 Apr 2014 03:49:57 -0700 (PDT)
Received: from linux-tdhb.lan (ip-194-187-74-233.konfederacka.maverick.com.pl. [194.187.74.233])
        by mx.google.com with ESMTPSA id m8sm84655583eeg.11.2014.04.19.03.49.56
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 19 Apr 2014 03:49:56 -0700 (PDT)
From:   =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
To:     linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>
Cc:     Hauke Mehrtens <hauke@hauke-m.de>,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
Subject: [PATCH][next: 3.16] MIPS: BCM47XX: Slightly clean memory detection
Date:   Sat, 19 Apr 2014 12:49:46 +0200
Message-Id: <1397904586-9773-1-git-send-email-zajec5@gmail.com>
X-Mailer: git-send-email 1.8.4.5
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-Path: <zajec5@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39864
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: zajec5@gmail.com
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

Patch was tested on devices with 64 MiB and 256 MiB of RAM.
It documents every part nicely and drops this hacky part of code:
max = off | ((128 << 20) - 1);

Signed-off-by: Rafał Miłecki <zajec5@gmail.com>
---
 arch/mips/bcm47xx/prom.c | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/arch/mips/bcm47xx/prom.c b/arch/mips/bcm47xx/prom.c
index 0af808d..1a03a2f 100644
--- a/arch/mips/bcm47xx/prom.c
+++ b/arch/mips/bcm47xx/prom.c
@@ -69,15 +69,18 @@ static __init void prom_init_mem(void)
 	 * BCM47XX uses 128MB for addressing the ram, if the system contains
 	 * less that that amount of ram it remaps the ram more often into the
 	 * available space.
-	 * Accessing memory after 128MB will cause an exception.
-	 * max contains the biggest possible address supported by the platform.
-	 * If the method wants to try something above we assume 128MB ram.
 	 */
-	off = (unsigned long)prom_init;
-	max = off | ((128 << 20) - 1);
-	for (mem = (1 << 20); mem < (128 << 20); mem += (1 << 20)) {
-		if ((off + mem) > max) {
-			mem = (128 << 20);
+
+	/* Physical address, without mapping to any kernel segment */
+	off = CPHYSADDR((unsigned long)prom_init);
+
+	/* Accessing memory after 128 MiB will cause an exception */
+	max = 128 << 20;
+
+	for (mem = 1 << 20; mem < max; mem += 1 << 20) {
+		/* Loop condition may be not enough, off may be over 1 MiB */
+		if (off + mem >= max) {
+			mem = max;
 			printk(KERN_DEBUG "assume 128MB RAM\n");
 			break;
 		}
-- 
1.8.4.5
