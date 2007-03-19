Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 19 Mar 2007 10:44:50 +0000 (GMT)
Received: from ex.2n.cz ([213.29.92.11]:2247 "EHLO ex.2n.cz")
	by ftp.linux-mips.org with ESMTP id S20021775AbXCSKoq (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 19 Mar 2007 10:44:46 +0000
Received: from orphique ([192.168.22.100]) by ex.2n.cz with Microsoft SMTPSVC(5.0.2195.6713);
	 Mon, 19 Mar 2007 11:44:18 +0100
Received: from ladis by orphique with local (Exim 3.36 #1 (Debian))
	id 1HTFJL-0004K6-00; Mon, 19 Mar 2007 11:41:55 +0100
Date:	Mon, 19 Mar 2007 11:41:55 +0100
To:	Jean Delvare <khali@linux-fr.org>
Cc:	Ralf Baechle <ralf@linux-mips.org>,
	Marc St-Jean <stjeanma@pmc-sierra.com>,
	akpm@linux-foundation.org, linux-mips@linux-mips.org,
	i2c@lm-sensors.org
Subject: Re: [PATCH 8/12] drivers: PMC MSP71xx TWI driver]
Message-ID: <20070319104155.GA16362@michl.2n.cz>
References: <20070316230333.GA17478@linux-mips.org> <20070317085244.f99aad86.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070317085244.f99aad86.khali@linux-fr.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
From:	Ladislav Michl <ladis@linux-mips.org>
X-OriginalArrivalTime: 19 Mar 2007 10:44:19.0010 (UTC) FILETIME=[8C0F8A20:01C76A13]
Return-Path: <ladis@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14544
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ladis@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Sat, Mar 17, 2007 at 08:52:44AM +0100, Jean Delvare wrote:
[snip]
> Why are you making a separate algorithm driver? This should really only
> be done when the algorithm is very generic. This is the exception, not
> the rule. These days I tend to move algorithm code back into the only
> bus driver that uses them (i2c-algo-sibyte done recently, i2c-algo-sgi
> is next on my list.)

Please remove i2c-algo-sgi from your list. This algorithm is used by
the VINO asic (drivers/media/video/vino.c) present in SGI Indy machines as
well as by the MACE asic (no driver exist yet) present in SGI O2 machines.
You may consider applying this patch (also removes trailing whitespace).

Signed-off-by: Ladislav Michl <ladis@linux-mips.org>

--- linux-omap-2.6.git/drivers/i2c/algos/i2c-algo-sgi.c.orig	2007-03-19 11:26:30.000000000 +0100
+++ linux-omap-2.6.git/drivers/i2c/algos/i2c-algo-sgi.c	2007-03-19 11:39:00.000000000 +0100
@@ -1,6 +1,7 @@
 /*
- * i2c-algo-sgi.c: i2c driver algorithms for SGI adapters.
- * 
+ * i2c-algo-sgi.c: i2c driver algorithm used by the VINO (SGI Indy) and
+ * MACE (SGI O2) chips.
+ *
  * This file is subject to the terms and conditions of the GNU General Public
  * License version 2 as published by the Free Software Foundation.
  *
@@ -162,8 +163,8 @@
 	.functionality	= sgi_func,
 };
 
-/* 
- * registering functions to load algorithms at runtime 
+/*
+ * registering functions to load algorithms at runtime
  */
 int i2c_sgi_add_bus(struct i2c_adapter *adap)
 {
