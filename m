Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 21 Feb 2011 14:21:13 +0100 (CET)
Received: from mail-ww0-f43.google.com ([74.125.82.43]:65148 "EHLO
        mail-ww0-f43.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491179Ab1BUNVJ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 21 Feb 2011 14:21:09 +0100
Received: by wwi17 with SMTP id 17so5585235wwi.24
        for <multiple recipients>; Mon, 21 Feb 2011 05:21:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:sender:from:to:subject:date:user-agent
         :organization:cc:mime-version:content-type:content-transfer-encoding
         :message-id;
        bh=w4/OiM69rO3yA0nulzRZT4vEPgB1wULZei8QmoJ2HXc=;
        b=Ii8oyCYS7owEz/CFPwg70auIk9uC6jUVUlUr1ajawufAuS71pj7nu2TnjkFukJvvIj
         ls/yQTayehPVnsmTtqQcTYMEzz2vCvj+VFPv0IAuMS0fUlwfAP06ZnKqBGb7oemOx8Hx
         /a0JnebJ5VQO185WGEJGC8b+6xHoBfhB4kDiI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:from:to:subject:date:user-agent:organization:cc:mime-version
         :content-type:content-transfer-encoding:message-id;
        b=sPCnqhnQ/WGgLwI0vhuDLNSY60ozlFuknCtRLHyk1HQAEXIF2xVV3KczIxgSq7qYlL
         386deI0LysuUBD8z4kMfTnn0rNUBtzDBBCMGo4UBVaj9N9F8XlIy4lO/uNwFStTIquvo
         Fp5ds/CMdrdGOR4YAv9GckD/3/GjHQVuhnKRQ=
Received: by 10.227.134.135 with SMTP id j7mr1162717wbt.12.1298294463744;
        Mon, 21 Feb 2011 05:21:03 -0800 (PST)
Received: from flexo.localnet (bobafett.staff.proxad.net [213.228.1.121])
        by mx.google.com with ESMTPS id j49sm2056488wer.38.2011.02.21.05.21.00
        (version=SSLv3 cipher=OTHER);
        Mon, 21 Feb 2011 05:21:01 -0800 (PST)
From:   Florian Fainelli <florian@openwrt.org>
To:     linux-mips@linux-mips.org
Subject: [PATCH] Alchemy: fix reset for MTX-1 and XXS1500
Date:   Mon, 21 Feb 2011 14:28:02 +0100
User-Agent: KMail/1.13.5 (Linux/2.6.35-25-server; KDE/4.5.1; x86_64; ; )
Organization: OpenWrt
Cc:     ralf@linux-mips.org, br1@einfach.org
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <201102211428.02125.florian@openwrt.org>
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29235
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian@openwrt.org
Precedence: bulk
X-list: linux-mips

Since commit 32fd6901 (MIPS: Alchemy: get rid of common/reset.c)
Alchemy-based boards use their own reset function. For MTX-1 and XXS1500,
the reset function pokes at the BCSR.SYSTEM_RESET register, but this does
not work. According to Bruno Randolf, this was not tested when written.

Previously, the generic au1000_restart() routine called the board specific
reset function, which for MTX-1 and XXS1500 did not work, but finally made
a jump to the reset vector, which really triggers a system restart. Fix
reboot for both targets by jumping to the reset vector.

CC: Bruno Randolf <br1@einfach.org>
CC: stable@kernel.org
Signed-off-by: Florian Fainelli <florian@openwrt.org>
---
Stable: 2.6.34+

diff --git a/arch/mips/alchemy/mtx-1/board_setup.c b/arch/mips/alchemy/mtx-1/board_setup.c
index 6398fa9..40b84b9 100644
--- a/arch/mips/alchemy/mtx-1/board_setup.c
+++ b/arch/mips/alchemy/mtx-1/board_setup.c
@@ -54,8 +54,8 @@ int mtx1_pci_idsel(unsigned int devsel, int assert);

 static void mtx1_reset(char *c)
 {
-	/* Hit BCSR.SYSTEM_CONTROL[SW_RST] */
-	au_writel(0x00000000, 0xAE00001C);
+	/* Jump to the reset vector */
+	__asm__ __volatile__("jr\t%0"::"r"(0xbfc00000));
 }

 static void mtx1_power_off(void)
diff --git a/arch/mips/alchemy/xxs1500/board_setup.c b/arch/mips/alchemy/xxs1500/board_setup.c
index b43c918..80c521e 100644
--- a/arch/mips/alchemy/xxs1500/board_setup.c
+++ b/arch/mips/alchemy/xxs1500/board_setup.c
@@ -36,8 +36,8 @@

 static void xxs1500_reset(char *c)
 {
-	/* Hit BCSR.SYSTEM_CONTROL[SW_RST] */
-	au_writel(0x00000000, 0xAE00001C);
+	/* Jump to the reset vector */
+	__asm__ __volatile__("jr\t%0"::"r"(0xbfc00000));
 }

 static void xxs1500_power_off(void)
--
1.7.1
