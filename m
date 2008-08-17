Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 17 Aug 2008 18:52:01 +0100 (BST)
Received: from py-out-1112.google.com ([64.233.166.180]:62316 "EHLO
	py-out-1112.google.com") by ftp.linux-mips.org with ESMTP
	id S28578193AbYHQRvx (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sun, 17 Aug 2008 18:51:53 +0100
Received: by py-out-1112.google.com with SMTP id z57so1225249pyg.22
        for <linux-mips@linux-mips.org>; Sun, 17 Aug 2008 10:51:51 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:to:subject
         :message-id:date:from;
        bh=FSHUMxQ21gdilOFJK34JwQ76+3ZbrkEUw8RieimVBW8=;
        b=ICE9pnr3E/DzVqR1PJTvUzHaPr/wyyic7wWlB02vDg/NKLuVIMT3d9DAW9k8Wxdyvk
         zFUzjlK7CyVnatq/nXX7n+iIAZyGfNTrNel/gHUaS0aarxyMyzO9ilIC2+5sN740rlym
         ACGUbNaRBR3vgYxS8SzJX5Zj9NkQLITP/l4ko=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=to:subject:message-id:date:from;
        b=r5kCDR1L3o1/nmrKAY7UsJIErqXmVjMtEQLNkdxSxOE8KO3iQWm39aGca01Svj8gKy
         4oIlhS2rI6950pZIesvZGgkDGZ19pyRDaisQWXNJjr8mjdBdOYTjmO3MjK5B+iDodWFx
         aOhre9+PkPlVvQH1/Qgclzy7eWBA8wi/VEkY8=
Received: by 10.65.192.19 with SMTP id u19mr9150383qbp.9.1218995511033;
        Sun, 17 Aug 2008 10:51:51 -0700 (PDT)
Received: from localhost ( [142.165.146.214])
        by mx.google.com with ESMTPS id s35sm11364958qbs.13.2008.08.17.10.51.49
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 17 Aug 2008 10:51:50 -0700 (PDT)
Received: from shane by localhost with local (Exim 4.63)
	(envelope-from <shane@localhost>)
	id 1KUmPs-0005uZ-Du; Sun, 17 Aug 2008 11:51:48 -0600
To:	linux-mips@linux-mips.org, ralf@linux-mips.org
Subject: [MIPS] msp71xx: resolve compilation problem in msp_setup.c
Message-Id: <E1KUmPs-0005uZ-Du@localhost>
Date:	Sun, 17 Aug 2008 11:51:48 -0600
From:	Shane McDonald <mcdonald.shane@gmail.com>
Return-Path: <mcdonald.shane@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20240
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mcdonald.shane@gmail.com
Precedence: bulk
X-list: linux-mips

The msp71xx_defconfig has never compiled in a kernel release.  This is
because the file msp_setup.c relies on some definitions from the PMCMSP
GPIO driver, which has not yet been accepted into the kernel.
This patch checks for the existence of the PMCMSP GPIO driver;
if it doesn't exist, no GPIO functions are referenced.

This patch will continue to work after the GPIO driver has been accepted,
so no changes will be necessary when that happens.

Signed-off-by: Shane McDonald <mcdonald.shane@gmail.com>
---
 arch/mips/pmc-sierra/msp71xx/msp_setup.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

Note that this patch doesn't clean up all compilation problems with
the MSP71xx: there is still a problem with a multiple definition
of plat_timer_setup.  I'm trying to wrangle some hardware to sort
this out.  Note that removing the definition of plat_timer_setup
in msp_time.c allows the kernel to compile completely,
but I don't know if it will run.

diff -uprN orig/arch/mips/pmc-sierra/msp71xx/msp_setup.c patched/arch/mips/pmc-sierra/msp71xx/msp_setup.c
--- orig/arch/mips/pmc-sierra/msp71xx/msp_setup.c	2008-08-17 10:15:11.000000000 -0600
+++ patched/arch/mips/pmc-sierra/msp71xx/msp_setup.c	2008-08-17 10:15:48.000000000 -0600
@@ -19,7 +19,7 @@
 #include <msp_prom.h>
 #include <msp_regs.h>
 
-#if defined(CONFIG_PMC_MSP7120_GW)
+#if defined(CONFIG_PMC_MSP7120_GW) && defined(CONFIG_PMCMSP_GPIO)
 #include <msp_regops.h>
 #include <msp_gpio.h>
 #define MSP_BOARD_RESET_GPIO	9
@@ -79,7 +79,7 @@ void msp7120_reset(void)
 	/* Wait a bit for the DDRC to settle */
 	for (i = 0; i < 100000000; i++);
 
-#if defined(CONFIG_PMC_MSP7120_GW)
+#if defined(CONFIG_PMC_MSP7120_GW) && defined(CONFIG_PMCMSP_GPIO)
 	/*
 	 * Set GPIO 9 HI, (tied to board reset logic)
 	 * GPIO 9 is the 4th GPIO of register 3
