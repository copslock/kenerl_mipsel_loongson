Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 13 Jan 2004 01:52:06 +0000 (GMT)
Received: from hermes.fachschaften.tu-muenchen.de ([IPv6:::ffff:129.187.202.12]:21456
	"HELO hermes.fachschaften.tu-muenchen.de") by linux-mips.org
	with SMTP id <S8225349AbUAMBwG>; Tue, 13 Jan 2004 01:52:06 +0000
Received: (qmail 3083 invoked from network); 13 Jan 2004 01:49:21 -0000
Received: from mimas.fachschaften.tu-muenchen.de (129.187.202.58)
  by hermes.fachschaften.tu-muenchen.de with QMQP; 13 Jan 2004 01:49:21 -0000
Date: Tue, 13 Jan 2004 02:52:02 +0100
From: Adrian Bunk <bunk@fs.tum.de>
To: ralf@gnu.org
Cc: linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Subject: [2.6 patch] fix DECSTATION depends
Message-ID: <20040113015202.GE9677@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Return-Path: <bunk@fs.tum.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3904
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: bunk@fs.tum.de
Precedence: bulk
X-list: linux-mips

Hi Ralf,

it seems the following is required in Linus' tree to get correct depends 
for DECSTATION:

--- linux-2.6.1-mm2/arch/mips/Kconfig.old	2004-01-13 02:33:53.000000000 +0100
+++ linux-2.6.1-mm2/arch/mips/Kconfig	2004-01-13 02:36:04.000000000 +0100
@@ -51,7 +51,7 @@
 
 config DECSTATION
 	bool "Support for DECstations"
-	depends on MIPS32 || EXPERIMENTAL
+	depends on MIPS32 && EXPERIMENTAL
 	---help---
 	  This enables support for DEC's MIPS based workstations.  For details
 	  see the Linux/MIPS FAQ on <http://oss.sgi.com/mips/> and the


cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed
