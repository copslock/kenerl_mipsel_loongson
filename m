Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 17 Jan 2006 01:20:32 +0000 (GMT)
Received: from smtp.osdl.org ([65.172.181.4]:33252 "EHLO smtp.osdl.org")
	by ftp.linux-mips.org with ESMTP id S8133516AbWAQBUN (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 17 Jan 2006 01:20:13 +0000
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k0H1NcDZ026967
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 16 Jan 2006 17:23:38 -0800
Received: from bix (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with SMTP id k0H1Nbe2018779;
	Mon, 16 Jan 2006 17:23:37 -0800
Date:	Mon, 16 Jan 2006 17:23:20 -0800
From:	Andrew Morton <akpm@osdl.org>
To:	Martin Michlmayr <tbm@cyrius.com>
Cc:	linux-mips@linux-mips.org, grundler@parisc-linux.org,
	Jeff Garzik <jgarzik@pobox.com>
Subject: Re: Tulip RaQ2 64 Bit Fix
Message-Id: <20060116172320.1e6d3cfd.akpm@osdl.org>
In-Reply-To: <20060116165825.GG5798@deprecation.cyrius.com>
References: <4393CD9F.3090305@jg555.com>
	<20051205114456.GA2728@linux-mips.org>
	<20060116160355.GB28383@deprecation.cyrius.com>
	<43CBC97E.3090800@jg555.com>
	<20060116165825.GG5798@deprecation.cyrius.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-MIMEDefang-Filter: osdl$Revision: 1.129 $
X-Scanned-By: MIMEDefang 2.36
Return-Path: <akpm@osdl.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9911
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: akpm@osdl.org
Precedence: bulk
X-list: linux-mips

Martin Michlmayr <tbm@cyrius.com> wrote:
>
> * Jim Gifford <maillist@jg555.com> [2006-01-16 08:27]:
> > >>>The attached patch allows the tulip driver to work with the RaQ2's
> > >>>network adapter. Without the patch under a 64 bit build, it will
> > >>>never negotiate and will drop packets. This driver is part of
> > >>>Linux Parisc, by Grant Grundler. It's currently in -mm, but Jeff
> > >>>Garzick will not apply it to the main tree.
> > >>>      
> > >>Why?
> > Jeff Garzick refuses to apply it do to spinlocks. Andrew Morton is
> > including in his tree because it fixes issue with Parisc and with
> > MIPS based builds. So it's kinda of what is the right thing to do. I
> > also use this driver on my x86 builds, and it actually performs
> > better. Here is a little history of how Grant made the driver.
> > 
> > Grant Grundler is the network maintainer for Parisc Linux.  He
> > discovered that the tulip driver didn't perform that well. He
> > researched the manufactures documentation and found out how to fix
> > the driver to work to its optimum performance. He did this back in
> > 2003, has submitted it to Jeff Garzick several times with no
> > response. Around late 2004, I started to do test builds on 64 bit on
> > my RaQ2 and discovered that the driver would not auto-negotiate
> > transfer speeds. Talked to numerous people, then someone put me in
> > touch with Grant. I tested the driver for about 2 weeks, ask Grant
> > why it wasn't sent upstream, he told me about the spinlock issue. I
> > then contacted Andrew Morton, explained everything as I am here, and
> > he agreed it was needed and tried to get Jeff to add it. Jeff sends
> > back a one liner say doing to it's use of spinlocks it's not
> > accepted.
> 
> Andrew, do you think that issue will be resolved in some way at some
> point?
> 

This has been hanging around for too long.  We need to get it over the hump.

Jeff, can you please suggest how this patch should be altered to make it
acceptable?

Thanks.


From: Jim Gifford <maillist@jg555.com>,
      Grant Grundler <grundler@parisc-linux.org>,
      Peter Horton <pdh@colonel-panic.org>

With Grant's help I was able to get the tulip driver to work with 64 bit 
MIPS.

Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 drivers/net/tulip/media.c      |   22 ++++++++++++++++++++--
 drivers/net/tulip/tulip.h      |    7 +++++--
 drivers/net/tulip/tulip_core.c |    2 +-
 net/tulip/eeprom.c             |    0 
 net/tulip/interrupt.c          |    0 
 5 files changed, 26 insertions(+), 5 deletions(-)

diff -puN drivers/net/tulip/eeprom.c~tulip-fix-for-64-bit-mips drivers/net/tulip/eeprom.c
diff -puN drivers/net/tulip/interrupt.c~tulip-fix-for-64-bit-mips drivers/net/tulip/interrupt.c
diff -puN drivers/net/tulip/media.c~tulip-fix-for-64-bit-mips drivers/net/tulip/media.c
--- devel/drivers/net/tulip/media.c~tulip-fix-for-64-bit-mips	2006-01-05 22:45:01.000000000 -0800
+++ devel-akpm/drivers/net/tulip/media.c	2006-01-05 22:45:17.000000000 -0800
@@ -44,8 +44,10 @@ static const unsigned char comet_miireg2
 
 /* MII transceiver control section.
    Read and write the MII registers using software-generated serial
-   MDIO protocol.  See the MII specifications or DP83840A data sheet
-   for details. */
+   MDIO protocol.
+   See IEEE 802.3-2002.pdf (Section 2, Chapter "22.2.4 Management functions")
+   or DP83840A data sheet for more details.
+   */
 
 int tulip_mdio_read(struct net_device *dev, int phy_id, int location)
 {
@@ -272,13 +274,29 @@ void tulip_select_media(struct net_devic
 				int reset_length = p[2 + init_length];
 				misc_info = (u16*)(reset_sequence + reset_length);
 				if (startup) {
+					int timeout = 10;	/* max 1 ms */
 					iowrite32(mtable->csr12dir | 0x100, ioaddr + CSR12);
 					for (i = 0; i < reset_length; i++)
 						iowrite32(reset_sequence[i], ioaddr + CSR12);
+
+					/* flush posted writes */
+					ioread32(ioaddr + CSR12);
+
+					/* Sect 3.10.3 in DP83840A.pdf (p39) */
+					udelay(500);
+
+					/* Section 4.2 in DP83840A.pdf (p43) */
+					/* and IEEE 802.3 "22.2.4.1.1 Reset" */
+					while (timeout-- &&
+						(tulip_mdio_read (dev, phy_num, MII_BMCR) & BMCR_RESET))
+						udelay(100);
 				}
 				for (i = 0; i < init_length; i++)
 					iowrite32(init_sequence[i], ioaddr + CSR12);
+
+				ioread32(ioaddr + CSR12);	/* flush posted writes */
 			}
+
 			tmp_info = get_u16(&misc_info[1]);
 			if (tmp_info)
 				tp->advertising[phy_num] = tmp_info | 1;
diff -puN drivers/net/tulip/tulip_core.c~tulip-fix-for-64-bit-mips drivers/net/tulip/tulip_core.c
--- devel/drivers/net/tulip/tulip_core.c~tulip-fix-for-64-bit-mips	2006-01-05 22:45:01.000000000 -0800
+++ devel-akpm/drivers/net/tulip/tulip_core.c	2006-01-05 22:45:01.000000000 -0800
@@ -22,7 +22,7 @@
 #else
 #define DRV_VERSION	"1.1.13"
 #endif
-#define DRV_RELDATE	"May 11, 2002"
+#define DRV_RELDATE	"December 15, 2004"
 
 
 #include <linux/module.h>
diff -puN drivers/net/tulip/tulip.h~tulip-fix-for-64-bit-mips drivers/net/tulip/tulip.h
--- devel/drivers/net/tulip/tulip.h~tulip-fix-for-64-bit-mips	2006-01-05 22:45:01.000000000 -0800
+++ devel-akpm/drivers/net/tulip/tulip.h	2006-01-05 22:45:01.000000000 -0800
@@ -474,8 +474,11 @@ static inline void tulip_stop_rxtx(struc
 			udelay(10);
 
 		if (!i)
-			printk(KERN_DEBUG "%s: tulip_stop_rxtx() failed\n",
-					pci_name(tp->pdev));
+			printk(KERN_DEBUG "%s: tulip_stop_rxtx() failed"
+					" (CSR5 0x%x CSR6 0x%x)\n",
+					pci_name(tp->pdev),
+					ioread32(ioaddr + CSR5),
+					ioread32(ioaddr + CSR6));
 	}
 }
 
_
