Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 25 Mar 2015 16:32:41 +0100 (CET)
Received: from mail-wi0-f180.google.com ([209.85.212.180]:33367 "EHLO
        mail-wi0-f180.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27009770AbbCYPcj4TJSW (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 25 Mar 2015 16:32:39 +0100
Received: by wixw10 with SMTP id w10so77312890wix.0
        for <linux-mips@linux-mips.org>; Wed, 25 Mar 2015 08:32:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ZyJD+soNJomXssnZt0JcmR/Qr0pBO0l4oZSju921zGk=;
        b=NyXNsyu6XcYIvPteweaBzMAMaeZgSHVckqZX+mxwT4miPaTSFBtpeJ2bByvYThHVsv
         WKZ/It2nt43DqZl8KDWDrgsxLzHuII1a7Vn8ee0Sn+RTV7MKd0jtuOk06Zouw8Rh7z76
         YNqjeVVAlvhTFbfpedWaOeuXE+FZORHIhIUm0fLN5vLQ3M+PMrVskVWF81UnFGR0jGaw
         6d/Ie1qd1E0u2gQtbig8FrLSZX4RxmXGkkNcKJoyHNv0Ze8u8EdwXBsrBbQORC537BQI
         eCmzBCWpyawkaIX4UuumEszuRmXQMZyau/84guOwTDeHEyaCIh9XGJ9SDYLgo16+Axmx
         lKcA==
X-Gm-Message-State: ALoCoQmiHduWZUYgE6DzpywWxVCPoGRFM08svO+Eh7stYOzUcEgpgmW8eyH4xFktsSEvDRPPQVBj
X-Received: by 10.180.38.15 with SMTP id c15mr39317783wik.74.1427297555448;
        Wed, 25 Mar 2015 08:32:35 -0700 (PDT)
Received: from archischi.lse.epita.fr (lse.epita.fr. [163.5.55.17])
        by mx.google.com with ESMTPSA id ge8sm4197483wjc.32.2015.03.25.08.32.34
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 25 Mar 2015 08:32:34 -0700 (PDT)
From:   Adrien Schildknecht <adrien+dev@schischi.me>
To:     m@bues.ch, zajec5@gmail.com, ralf@linux-mips.org
Cc:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        Adrien Schildknecht <adrien+dev@schischi.me>
Subject: [PATCH] ssb: fix Kconfig dependencies
Date:   Wed, 25 Mar 2015 16:31:42 +0100
Message-Id: <1427297502-369-1-git-send-email-adrien+dev@schischi.me>
X-Mailer: git-send-email 2.3.2
Return-Path: <adrien+dev@schischi.me>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46521
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: adrien+dev@schischi.me
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

The commit 21400f252a97 ("MIPS: BCM47XX: Make ssb init NVRAM instead of
bcm47xx polling it") introduces a dependency to SSB_SFLASH but did not
add it to the Kconfig.

drivers/ssb/driver_mipscore.c:216:36: error: 'struct ssb_mipscore' has no
member named 'sflash'
  struct ssb_sflash *sflash = &mcore->sflash;
                                    ^
drivers/ssb/driver_mipscore.c:249:12: error: dereferencing pointer to
incomplete type
  if (sflash->present) {
            ^

Signed-off-by: Adrien Schildknecht <adrien+dev@schischi.me>
---
 drivers/ssb/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/ssb/Kconfig b/drivers/ssb/Kconfig
index 75b3603..f0d22cd 100644
--- a/drivers/ssb/Kconfig
+++ b/drivers/ssb/Kconfig
@@ -130,6 +130,7 @@ config SSB_DRIVER_MIPS
 	bool "SSB Broadcom MIPS core driver"
 	depends on SSB && MIPS
 	select SSB_SERIAL
+	select SSB_SFLASH
 	help
 	  Driver for the Sonics Silicon Backplane attached
 	  Broadcom MIPS core.
-- 
2.3.2
