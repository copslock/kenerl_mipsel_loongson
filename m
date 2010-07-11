Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 11 Jul 2010 17:41:09 +0200 (CEST)
Received: from mail-px0-f177.google.com ([209.85.212.177]:59773 "EHLO
        mail-px0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491890Ab0GKPku (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 11 Jul 2010 17:40:50 +0200
Received: by pxi13 with SMTP id 13so1749268pxi.36
        for <multiple recipients>; Sun, 11 Jul 2010 08:40:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:subject:to:from:cc:date
         :message-id:in-reply-to:references:user-agent:mime-version
         :content-type:content-transfer-encoding;
        bh=63HqvPUXp11T8uBoZm8EFxXdUXoNXSIXnbTNUHyLuKw=;
        b=mKJgNMw7WwUVakE6orD63Veallnd9AHcRbIreD+lVkOEkhATa42Vj2MXYS56YyuHOn
         NeK2CXMBFqU5pAhLFxF1EFBDo69PsFQViqa+kgQ1urfsuYAZGkDTv9gPIFUaR5PmWk4j
         9LHVlDu9nn+ypHDxhjLy93IvrpTgM2fvTS1+Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=subject:to:from:cc:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-type:content-transfer-encoding;
        b=lYEQ7onxft/sXo9kx4SIdLCvulFyNXdJ1kgzfnxTaBJ+neBRhvv01Tcp0RbcYjP/UX
         YEpfvTVuhXjJwLFaB4ts/r7If956xgZryrZZunRhTnCWz0jHzTW1eBbZOFjQ5UDsJLQi
         Sr24og7lbJSHfL7LkOCkANPOfDEQgFB6fVbG0=
Received: by 10.142.127.9 with SMTP id z9mr14963588wfc.184.1278862842740;
        Sun, 11 Jul 2010 08:40:42 -0700 (PDT)
Received: from [127.0.1.1] (zaq3d2e62b2.zaq.ne.jp [61.46.98.178])
        by mx.google.com with ESMTPS id l29sm3393232rvb.7.2010.07.11.08.40.40
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 11 Jul 2010 08:40:41 -0700 (PDT)
Subject: [PATCH 2/2] MIPS: MTX-1: cleanup and comments
To:     linux-mips@linux-mips.org, manuel.lauss@googlemail.com,
        ralf@linux-mips.org
From:   Bruno Randolf <randolf.bruno@googlemail.com>
Cc:     florian@openwrt.org
Date:   Mon, 12 Jul 2010 00:40:38 +0900
Message-ID: <20100711154038.29863.23111.stgit@void>
In-Reply-To: <20100711154028.29863.74414.stgit@void>
References: <20100711154028.29863.74414.stgit@void>
User-Agent: StGit/0.15
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-Path: <randolf.bruno@googlemail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 27366
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: randolf.bruno@googlemail.com
Precedence: bulk
X-list: linux-mips

Add some comments about mtx1_pci_idsel() and remove a dead block of old code.

Signed-off-by: Bruno Randolf <br1@einfach.org>
---
 arch/mips/alchemy/mtx-1/board_setup.c |   12 ++++--------
 1 files changed, 4 insertions(+), 8 deletions(-)

diff --git a/arch/mips/alchemy/mtx-1/board_setup.c b/arch/mips/alchemy/mtx-1/board_setup.c
index 52d883d..3cf2fa2 100644
--- a/arch/mips/alchemy/mtx-1/board_setup.c
+++ b/arch/mips/alchemy/mtx-1/board_setup.c
@@ -105,14 +105,10 @@ void __init board_setup(void)
 int
 mtx1_pci_idsel(unsigned int devsel, int assert)
 {
-#define MTX_IDSEL_ONLY_0_AND_3 0
-#if MTX_IDSEL_ONLY_0_AND_3
-	if (devsel != 0 && devsel != 3) {
-		printk(KERN_ERR "*** not 0 or 3\n");
-		return 0;
-	}
-#endif
-
+	/* This function is only necessary to support a proprietary Cardbus
+	 * adapter on the mtx-1 "singleboard" variant. It triggers a custom
+	 * logic chip connected to EXT_IO3 (GPIO1) to suppress IDSEL signals.
+	 */
 	if (assert && devsel != 0)
 		/* Suppress signal to Cardbus */
 		alchemy_gpio_set_value(1, 0);	/* set EXT_IO3 OFF */
