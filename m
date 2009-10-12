Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 12 Oct 2009 18:57:20 +0200 (CEST)
Received: from mail-bw0-f208.google.com ([209.85.218.208]:39615 "EHLO
	mail-bw0-f208.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1493461AbZJLQ5N (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 12 Oct 2009 18:57:13 +0200
Received: by bwz4 with SMTP id 4so3237856bwz.0
        for <multiple recipients>; Mon, 12 Oct 2009 09:57:06 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=ZYIUeg5y0XKdj6v/zoqFmhURjt+Wp7XFhEmHDcKfA1M=;
        b=QsOoZ5dlXUPgea6PM+HqAmn57tcYSkH5xrJXdS8BeIGG9+stkAI633arPkoL6eOogW
         oj+TbWVWVEixYp/GOtNu/+VoWgZoyZNChGfpm9RVK1GbZVxxVzFuleKyBWnvypEIVDoI
         SYWjVXYnOU+kS2j/+iifat6plliNszX95jhTg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=UjeExj06Dv8lTbggayoW82POZg8shWJDgvNjhraNOaXk+Kh/5B/bG7NWle/iaM5dLr
         EkA4CRRFv2nXT02CMO7UADCzDA7mzt1Zn+zacHjjPgoqtNwPOUFsAVBpjcIjyCK2VrNc
         AvlUIfP7IDbYWpGaW7EjylyGrCffXzQDmjc98=
Received: by 10.103.48.17 with SMTP id a17mr2545773muk.82.1255366626870;
        Mon, 12 Oct 2009 09:57:06 -0700 (PDT)
Received: from localhost.localdomain (p5496E0B2.dip.t-dialin.net [84.150.224.178])
        by mx.google.com with ESMTPS id j9sm47123mue.26.2009.10.12.09.57.05
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 12 Oct 2009 09:57:05 -0700 (PDT)
From:	Manuel Lauss <manuel.lauss@googlemail.com>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	Linux-MIPS <linux-mips@linux-mips.org>,
	Manuel Lauss <manuel.lauss@gmail.com>
Subject: [PATCH] MIPS: Alchemy: fix DB1550 PCI interrupt typo
Date:	Mon, 12 Oct 2009 18:57:06 +0200
Message-Id: <1255366626-10307-1-git-send-email-manuel.lauss@gmail.com>
X-Mailer: git-send-email 1.6.5.rc2
In-Reply-To: <1254939315-8158-5-git-send-email-manuel.lauss@gmail.com>
References: <1254939315-8158-5-git-send-email-manuel.lauss@gmail.com>
Return-Path: <manuel.lauss@googlemail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24237
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: manuel.lauss@googlemail.com
Precedence: bulk
X-list: linux-mips

Fix a copy-paste error in patch "Alchemy: Stop IRQ name sharing".

Signed-off-by: Manuel Lauss <manuel.lauss@gmail.com>
---
Ralf, please fold this into the patch "Alchemy: Stop IRQ name sharing"
in lmo-queue!

Thanks!

 arch/mips/alchemy/devboards/db1x00/board_setup.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/mips/alchemy/devboards/db1x00/board_setup.c b/arch/mips/alchemy/devboards/db1x00/board_setup.c
index b1f3711..64eb26f 100644
--- a/arch/mips/alchemy/devboards/db1x00/board_setup.c
+++ b/arch/mips/alchemy/devboards/db1x00/board_setup.c
@@ -62,9 +62,9 @@ char irq_tab_alchemy[][5] __initdata = {
 
 #ifdef CONFIG_MIPS_DB1550
 char irq_tab_alchemy[][5] __initdata = {
-	[11] = { -1, AU1500_PCI_INTC, 0xff, 0xff, 0xff }, /* IDSEL 11 - on-board HPT371 */
-	[12] = { -1, AU1500_PCI_INTB, AU1500_PCI_INTC, AU1500_PCI_INTD, AU1500_PCI_INTA }, /* IDSEL 12 - PCI slot 2 (left) */
-	[13] = { -1, AU1500_PCI_INTA, AU1500_PCI_INTB, AU1500_PCI_INTC, AU1500_PCI_INTD }, /* IDSEL 13 - PCI slot 1 (right) */
+	[11] = { -1, AU1550_PCI_INTC, 0xff, 0xff, 0xff }, /* IDSEL 11 - on-board HPT371 */
+	[12] = { -1, AU1550_PCI_INTB, AU1550_PCI_INTC, AU1550_PCI_INTD, AU1550_PCI_INTA }, /* IDSEL 12 - PCI slot 2 (left) */
+	[13] = { -1, AU1550_PCI_INTA, AU1550_PCI_INTB, AU1550_PCI_INTC, AU1550_PCI_INTD }, /* IDSEL 13 - PCI slot 1 (right) */
 };
 #endif
 
-- 
1.6.5.rc2
