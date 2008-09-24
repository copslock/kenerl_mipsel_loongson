Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 24 Sep 2008 20:20:04 +0100 (BST)
Received: from hall.aurel32.net ([91.121.138.14]:35514 "EHLO hall.aurel32.net")
	by ftp.linux-mips.org with ESMTP id S29587227AbYIXTT5 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 24 Sep 2008 20:19:57 +0100
Received: from volta.aurel32.net ([2002:52e8:2fb:1:21e:8cff:feb0:693b])
	by hall.aurel32.net with esmtpsa (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.63)
	(envelope-from <aurelien@aurel32.net>)
	id 1KiZu0-0003gZ-Oe; Wed, 24 Sep 2008 21:19:56 +0200
Received: from aurel32 by volta.aurel32.net with local (Exim 4.69)
	(envelope-from <aurelien@aurel32.net>)
	id 1KiZtz-00057a-Hv; Wed, 24 Sep 2008 21:19:55 +0200
Date:	Wed, 24 Sep 2008 21:19:55 +0200
From:	Aurelien Jarno <aurelien@aurel32.net>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	linux-mips@linux-mips.org, Michael Buesch <mb@bu3sch.de>
Subject: [PATCH 1/6] [MIPS] BCM47xx: Add platform specific PCI code
Message-ID: <20080924191955.GB18700@volta.aurel32.net>
References: <20080924191840.GA18700@volta.aurel32.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20080924191840.GA18700@volta.aurel32.net>
X-Mailer: Mutt 1.5.18 (2008-05-17)
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <aurelien@aurel32.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20616
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: aurelien@aurel32.net
Precedence: bulk
X-list: linux-mips

This patch, ported from OpenWRT SVN, defines pcibios_map_irq() and
pcibios_plat_dev_init() for the BCM47xx platform.

It fixes the regression introduced by commit
aab547ce0d1493d400b6468c521a0137cd8c1edf.

Signed-off-by: Aurelien Jarno <aurelien@aurel32.net>
Reviewed-by: Michael Buesch <mb@bu3sch.de>
---
 arch/mips/pci/Makefile      |    1 +
 arch/mips/pci/pci-bcm47xx.c |   58 +++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 59 insertions(+), 0 deletions(-)
 create mode 100644 arch/mips/pci/pci-bcm47xx.c

diff --git a/arch/mips/pci/Makefile b/arch/mips/pci/Makefile
index 15e01ae..c8c32f4 100644
--- a/arch/mips/pci/Makefile
+++ b/arch/mips/pci/Makefile
@@ -15,6 +15,7 @@ obj-$(CONFIG_SOC_TX3927)	+= ops-tx3927.o
 obj-$(CONFIG_PCI_VR41XX)	+= ops-vr41xx.o pci-vr41xx.o
 obj-$(CONFIG_MARKEINS)		+= ops-emma2rh.o pci-emma2rh.o fixup-emma2rh.o
 obj-$(CONFIG_PCI_TX4927)	+= ops-tx4927.o
+obj-$(CONFIG_BCM47XX)		+= pci-bcm47xx.o
 
 #
 # These are still pretty much in the old state, watch, go blind.
diff --git a/arch/mips/pci/pci-bcm47xx.c b/arch/mips/pci/pci-bcm47xx.c
new file mode 100644
index 0000000..64ccb4f
--- /dev/null
+++ b/arch/mips/pci/pci-bcm47xx.c
@@ -0,0 +1,58 @@
+/*
+ *  Copyright (C) 2008 Michael Buesch <mb@bu3sch.de>
+ *  Copyright (C) 2008 Aurelien Jarno <aurelien@aurel32.net>
+ *
+ *  This program is free software; you can redistribute  it and/or modify it
+ *  under  the terms of  the GNU General  Public License as published by the
+ *  Free Software Foundation;  either version 2 of the  License, or (at your
+ *  option) any later version.
+ *
+ *  THIS  SOFTWARE  IS PROVIDED   ``AS  IS'' AND   ANY  EXPRESS OR IMPLIED
+ *  WARRANTIES,   INCLUDING, BUT NOT  LIMITED  TO, THE IMPLIED WARRANTIES OF
+ *  MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.  IN
+ *  NO  EVENT  SHALL   THE AUTHOR  BE    LIABLE FOR ANY   DIRECT, INDIRECT,
+ *  INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
+ *  NOT LIMITED   TO, PROCUREMENT OF  SUBSTITUTE GOODS  OR SERVICES; LOSS OF
+ *  USE, DATA,  OR PROFITS; OR  BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON
+ *  ANY THEORY OF LIABILITY, WHETHER IN  CONTRACT, STRICT LIABILITY, OR TORT
+ *  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
+ *  THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
+ *
+ *  You should have received a copy of the  GNU General Public License along
+ *  with this program; if not, write  to the Free Software Foundation, Inc.,
+ *  675 Mass Ave, Cambridge, MA 02139, USA.
+ */
+
+#include <linux/types.h>
+#include <linux/pci.h>
+#include <linux/ssb/ssb.h>
+
+int pcibios_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
+{
+	int res;
+
+	res = ssb_pcibios_map_irq(dev, slot, pin);
+	if (res < 0) {
+		printk(KERN_ALERT "PCI: Failed to map IRQ of device %s\n",
+		       dev->dev.bus_id);
+		return 0;
+	}
+	/* IRQ-0 and IRQ-1 are software interrupts. */
+	WARN_ON((res == 0) || (res == 1));
+
+	return res;
+}
+
+int pcibios_plat_dev_init(struct pci_dev *dev)
+{
+	int err;
+
+	err = ssb_pcibios_plat_dev_init(dev);
+	if (err) {
+		printk(KERN_ALERT "PCI: Failed to init device %s\n",
+		       pci_name(dev));
+	}
+
+	return err;
+}
+
-- 
1.5.6.5


-- 
  .''`.  Aurelien Jarno	            | GPG: 1024D/F1BCDB73
 : :' :  Debian developer           | Electrical Engineer
 `. `'   aurel32@debian.org         | aurelien@aurel32.net
   `-    people.debian.org/~aurel32 | www.aurel32.net
