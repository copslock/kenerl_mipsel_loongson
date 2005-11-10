Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 10 Nov 2005 15:28:36 +0000 (GMT)
Received: from smtp101.biz.mail.mud.yahoo.com ([68.142.200.236]:50050 "HELO
	smtp101.biz.mail.mud.yahoo.com") by ftp.linux-mips.org with SMTP
	id S3457893AbVKJP2R (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 10 Nov 2005 15:28:17 +0000
Received: (qmail 80469 invoked from network); 10 Nov 2005 15:29:41 -0000
Received: from unknown (HELO ?192.168.1.110?) (ppopov@embeddedalley.com@63.194.214.47 with plain)
  by smtp101.biz.mail.mud.yahoo.com with SMTP; 10 Nov 2005 15:29:41 -0000
Subject: Re: smc91x support
From:	Pete Popov <ppopov@embeddedalley.com>
Reply-To: ppopov@embeddedalley.com
To:	Matej Kupljen <matej.kupljen@ultra.si>
Cc:	"'linux-mips@linux-mips.org'" <linux-mips@linux-mips.org>
In-Reply-To: <1131634331.18165.30.camel@localhost.localdomain>
References: <1131634331.18165.30.camel@localhost.localdomain>
Content-Type: multipart/mixed; boundary="=-cxSBhw4V0vKhXoRAS6M9"
Organization: Embedded Alley Solutions, Inc
Date:	Thu, 10 Nov 2005 07:29:45 -0800
Message-Id: <1131636585.4890.14.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Return-Path: <ppopov@embeddedalley.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9466
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ppopov@embeddedalley.com
Precedence: bulk
X-list: linux-mips


--=-cxSBhw4V0vKhXoRAS6M9
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Thu, 2005-11-10 at 15:52 +0100, Matej Kupljen wrote:
> Hi
> 
> On 21st september Peter Popov modified:
> arch/mips/au1000/common/platform.c
> 
> With the log message:
> smc91x platform support; requires patch to smc91x.h which was sent
>         upstream.
> 
> Any news about this?
> What is the patch required for smc91x.h?

I have to check with Nicolas Pitre.

Meanwhile I've attached the patch here.

> I also added support for smc91x.h to enable it on the DBAU1200,
> but as I wrote in another mail, I get bad performance.

So do I. That part is just a low performance part plus the bus settings
on the db1200 are set for the slowest part on the local bus. Depending
on which peripherals you use on the local bus, you may be able to change
the settings and get better performance from the Ethernet. Jordan may
have more hints about this.

Pete

> I enabled the debug mode and I now I see that I get a lot of 
> overruns, like:
> ...
> [4294761.172000] eth0: RX overrun (EPH_ST 0x0001)
> [4294761.190000] eth0: RX overrun (EPH_ST 0x0001)
> [4294761.198000] eth0: RX overrun (EPH_ST 0x0001)
> ...
> 
> Is there any solution to this?
> Maybe to use DDMA?
> 
> BR,
> Matej
> 
> 

--=-cxSBhw4V0vKhXoRAS6M9
Content-Disposition: attachment; filename=smc91x_au1x.patch
Content-Type: text/x-patch; name=smc91x_au1x.patch; charset=utf-8
Content-Transfer-Encoding: 7bit

diff -Naur --exclude=CVS linux-2.6-orig/drivers/net/Kconfig linux-2.6-dev/drivers/net/Kconfig
--- linux-2.6-orig/drivers/net/Kconfig	2005-09-15 08:45:33.000000000 -0700
+++ linux-2.6-dev/drivers/net/Kconfig	2005-09-21 11:40:13.000000000 -0700
@@ -800,7 +800,7 @@
 	tristate "SMC 91C9x/91C1xxx support"
 	select CRC32
 	select MII
-	depends on NET_ETHERNET && (ARM || REDWOOD_5 || REDWOOD_6 || M32R || SUPERH)
+	depends on NET_ETHERNET && (ARM || REDWOOD_5 || REDWOOD_6 || M32R || SUPERH || SOC_AU1X00)
 	help
 	  This is a driver for SMC's 91x series of Ethernet chipsets,
 	  including the SMC91C94 and the SMC91C111. Say Y if you want it
diff -Naur --exclude=CVS linux-2.6-orig/drivers/net/smc91x.h linux-2.6-dev/drivers/net/smc91x.h
--- linux-2.6-orig/drivers/net/smc91x.h	2005-09-15 08:45:41.000000000 -0700
+++ linux-2.6-dev/drivers/net/smc91x.h	2005-09-21 11:42:49.000000000 -0700
@@ -289,6 +289,38 @@
 #define RPC_LSA_DEFAULT		RPC_LED_TX_RX
 #define RPC_LSB_DEFAULT		RPC_LED_100_10
 
+#elif defined(CONFIG_SOC_AU1X00)
+
+#include <au1xxx.h>
+
+/* We can only do 16-bit reads and writes in the static memory space. */
+#define SMC_CAN_USE_8BIT	0
+#define SMC_CAN_USE_16BIT	1
+#define SMC_CAN_USE_32BIT	0
+#define SMC_IO_SHIFT		0
+#define SMC_NOWAIT		1
+
+#define SMC_inw(a, r)		au_readw((unsigned long)((a) + (r)))
+#define SMC_insw(a, r, p, l)	\
+	do {	\
+		unsigned long _a = (unsigned long)((a) + (r)); \
+		int _l = (l); \
+		u16 *_p = (u16 *)(p); \
+		while (_l-- > 0) \
+			*_p++ = au_readw(_a); \
+	} while(0)
+#define SMC_outw(v, a, r)	au_writew(v, (unsigned long)((a) + (r)))
+#define SMC_outsw(a, r, p, l)	\
+	do {	\
+		unsigned long _a = (unsigned long)((a) + (r)); \
+		int _l = (l); \
+		const u16 *_p = (const u16 *)(p); \
+		while (_l-- > 0) \
+			au_writew(*_p++ , _a); \
+	} while(0)
+
+#define set_irq_type(irq, type) do {} while (0)
+
 #else
 
 #define SMC_CAN_USE_8BIT	1

--=-cxSBhw4V0vKhXoRAS6M9--
