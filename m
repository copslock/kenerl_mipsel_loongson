Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 06 Jan 2005 18:15:45 +0000 (GMT)
Received: from mailout.stusta.mhn.de ([IPv6:::ffff:141.84.69.5]:12305 "HELO
	mailout.stusta.mhn.de") by linux-mips.org with SMTP
	id <S8225331AbVAFSPj>; Thu, 6 Jan 2005 18:15:39 +0000
Received: (qmail 17308 invoked from network); 6 Jan 2005 18:15:28 -0000
Received: from r063144.stusta.swh.mhn.de (10.150.63.144)
  by mailout.stusta.mhn.de with SMTP; 6 Jan 2005 18:15:28 -0000
Received: by r063144.stusta.swh.mhn.de (Postfix, from userid 1000)
	id D02C8BC15F; Thu,  6 Jan 2005 19:15:21 +0100 (CET)
Date: Thu, 6 Jan 2005 19:15:20 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>, greg@kroah.com,
	Ladislav Michl <ladis@linux-mips.org>
Cc: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com,
	ralf@linux-mips.org, linux-mips@linux-mips.org
Subject: [2.6 patch] 2.6.10-mm2: let I2C_ALGO_SGI depend on MIPS
Message-ID: <20050106181519.GG3096@stusta.de>
References: <20050106002240.00ac4611.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050106002240.00ac4611.akpm@osdl.org>
User-Agent: Mutt/1.5.6+20040907i
Return-Path: <bunk@stusta.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6819
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: bunk@stusta.de
Precedence: bulk
X-list: linux-mips

On Thu, Jan 06, 2005 at 12:22:40AM -0800, Andrew Morton wrote:
>...
> All 560 patches:
>...
> bk-i2c.patch
>...


There's no reason for offering a MIPS-only driver on other architectures 
(even though it does compile).

Even better dependencies on specific MIPS variables might be possible 
that obsolete this patch, but this patch fixes at least the !MIPS case.


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.10-mm2-full/drivers/i2c/algos/Kconfig.old	2005-01-06 19:07:16.000000000 +0100
+++ linux-2.6.10-mm2-full/drivers/i2c/algos/Kconfig	2005-01-06 19:08:22.000000000 +0100
@@ -61,7 +61,7 @@
 
 config I2C_ALGO_SGI
 	tristate "I2C SGI interfaces"
-	depends on I2C
+	depends on I2C && MIPS
 	help
 	  Supports the SGI interfaces like the ones found on SGI Indy VINO
 	  or SGI O2 MACE.
