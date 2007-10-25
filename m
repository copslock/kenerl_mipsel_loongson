Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 25 Oct 2007 14:53:53 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:49829 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20022613AbXJYNxv (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 25 Oct 2007 14:53:51 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id l9PDraJJ023359;
	Thu, 25 Oct 2007 14:53:37 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id l9PDrYC6023358;
	Thu, 25 Oct 2007 14:53:34 +0100
Date:	Thu, 25 Oct 2007 14:53:34 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org,
	linux-mips@linux-mips.org
Subject: [IDE] Fix build bug
Message-ID: <20071025135334.GA23272@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.14 (2007-02-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17208
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

  CC      drivers/ide/pci/generic.o
drivers/ide/pci/generic.c:52: error: __setup_str_ide_generic_all_on causes a
+section type conflict

This sort of build error is becoming a regular issue.  Either all or non
of the elements that go into a particular section of a compilation unit
need to be const.  Or an error may result such as in this case if
CONFIG_HOTPLUG is unset.

Maybe worth a check in checkpatch.pl - but certainly gcc's interolerance
is also being less than helpful here.

---
 drivers/ide/pci/generic.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ide/pci/generic.c b/drivers/ide/pci/generic.c
index f44d708..0047684 100644
--- a/drivers/ide/pci/generic.c
+++ b/drivers/ide/pci/generic.c
@@ -67,7 +67,7 @@ MODULE_PARM_DESC(all_generic_ide, "IDE generic will claim all unknown PCI IDE st
 		.udma_mask	= ATA_UDMA6, \
 	}
 
-static const struct ide_port_info generic_chipsets[] __devinitdata = {
+static struct ide_port_info generic_chipsets[] __devinitdata = {
 	/*  0 */ DECLARE_GENERIC_PCI_DEV("Unknown",	0),
 
 	{	/* 1 */
