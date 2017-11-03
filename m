Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 03 Nov 2017 15:15:49 +0100 (CET)
Received: from 19pmail.ess.barracuda.com ([64.235.150.245]:53913 "EHLO
        19pmail.ess.barracuda.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990740AbdKCOPliL2jV convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 3 Nov 2017 15:15:41 +0100
Received: from MIPSMAIL01.mipstec.com (mailrelay.mips.com [12.201.5.28]) by mx27.ess.sfj.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NO); Fri, 03 Nov 2017 14:14:02 +0000
Received: from MIPSMAIL01.mipstec.com ([fe80::5c93:1f20:524d:a563]) by
 MIPSMAIL01.mipstec.com ([fe80::5c93:1f20:524d:a563%13]) with mapi id
 14.03.0361.001; Fri, 3 Nov 2017 07:10:14 -0700
From:   Aleksandar Markovic <Aleksandar.Markovic@mips.com>
To:     Joe Perches <joe@perches.com>,
        Aleksandar Markovic <aleksandar.markovic@rt-rk.com>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
CC:     Miodrag Dinic <Miodrag.Dinic@mips.com>,
        Goran Ferenc <Goran.Ferenc@mips.com>,
        "David S. Miller" <davem@davemloft.net>,
        "Douglas Leung" <Douglas.Leung@mips.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        James Hogan <James.Hogan@mips.com>,
        "Jason Cooper" <jason@lakedaemon.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        "Mauro Carvalho Chehab" <mchehab@kernel.org>,
        Miodrag Dinic <miodrag.dinic@imgtec.com>,
        Paul Burton <Paul.Burton@mips.com>,
        "Petar Jovanovic" <Petar.Jovanovic@mips.com>,
        Raghu Gandham <Raghu.Gandham@mips.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Thomas Gleixner" <tglx@linutronix.de>
Subject: RE: [PATCH v7 2/5] irqchip/irq-goldfish-pic: Add Goldfish PIC driver
Thread-Topic: [PATCH v7 2/5] irqchip/irq-goldfish-pic: Add Goldfish PIC
 driver
Thread-Index: AQHTU/bGIxO3y2UlSk20Itmu6UhbuaMBvl+AgADzPl0=
Date:   Fri, 3 Nov 2017 14:10:13 +0000
Message-ID: <BD3A5F1946F2E540A31AF2CE969BAEEEC19BF3@MIPSMAIL01.mipstec.com>
References: <1509639716-4787-1-git-send-email-aleksandar.markovic@rt-rk.com>
         <1509639716-4787-3-git-send-email-aleksandar.markovic@rt-rk.com>,<1509640479.31043.80.camel@perches.com>
In-Reply-To: <1509640479.31043.80.camel@perches.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [82.117.201.26]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-BESS-ID: 1509718439-637137-12450-568425-9
X-BESS-VER: 2017.12-r1710252241
X-BESS-Apparent-Source-IP: 12.201.5.28
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.186549
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------
        0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS59374 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status: 1
Return-Path: <Aleksandar.Markovic@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60702
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Aleksandar.Markovic@mips.com
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

> From: Joe Perches [joe@perches.com]
> ...
>On Thu, 2017-11-02 at 17:21 +0100, Aleksandar Markovic wrote:
> ...
>
> > Signed-off-by: Miodrag Dinic <miodrag.dinic@mips.com>
> > Signed-off-by: Goran Ferenc <goran.ferenc@mips.com>
> > Signed-off-by: Aleksandar Markovic <aleksandar.markovic@mips.com>
> > wq
> 
> vi much?
> 

:)

> > +/*
> > + * Driver for MIPS Goldfish Programmable Interrupt Controller.
> > + *
> > + * Author: Miodrag Dinic <miodrag.dinic@mips.com>
> > + *
> > + * This program is free software; you can redistribute       it and/or modify it
> > + * under  the terms of       the GNU General  Public License as published by the
> > + * Free Software Foundation;  either version 2 of the  License, or (at your
> > + * option) any later version.
> > + */
> 
> Odd mix of spaces and tabs
> 

Will be fixed in v8.

> It'd be good to add a #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> before any #include so the pr_<level> output is prefixed appropriately.

Error and info messages will be completely revised in v8.

Thanks for the review!

Aleksandar
From andrew@lunn.ch Fri Nov  3 16:48:14 2017
Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 03 Nov 2017 16:48:21 +0100 (CET)
Received: from vps0.lunn.ch ([185.16.172.187]:49238 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23990588AbdKCPsOZwPKt (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 3 Nov 2017 16:48:14 +0100
Received: from andrew by vps0.lunn.ch with local (Exim 4.84_2)
        (envelope-from <andrew@lunn.ch>)
        id 1eAeCZ-0000YU-Ol; Fri, 03 Nov 2017 16:48:11 +0100
Date:   Fri, 3 Nov 2017 16:48:11 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     David Daney <ddaney@caviumnetworks.com>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        David Daney <david.daney@cavium.com>,
        linux-mips@linux-mips.org, ralf@linux-mips.org,
        James Hogan <james.hogan@mips.com>, netdev@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-kernel@vger.kernel.org,
        "Steven J. Hill" <steven.hill@cavium.com>,
        devicetree@vger.kernel.org, Carlos Munoz <cmunoz@cavium.com>
Subject: Re: [PATCH 6/7] netdev: octeon-ethernet: Add Cavium Octeon III
 support.
Message-ID: <20171103154811.GS24320@lunn.ch>
References: <20171102003606.19913-1-david.daney@cavium.com>
 <20171102003606.19913-7-david.daney@cavium.com>
 <55d6cf88-7444-42ea-02f1-27efdee2be4b@gmail.com>
 <ee206580-e419-903f-de36-72d5803b1b7b@caviumnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ee206580-e419-903f-de36-72d5803b1b7b@caviumnetworks.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <andrew@lunn.ch>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60703
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: andrew@lunn.ch
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

> >>+static char *mix_port;
> >>+module_param(mix_port, charp, 0444);
> >>+MODULE_PARM_DESC(mix_port, "Specifies which ports connect to MIX interfaces.");
> >
> >Can you derive this from Device Tree /platform data configuration?
> >
> >>+
> >>+static char *pki_port;
> >>+module_param(pki_port, charp, 0444);
> >>+MODULE_PARM_DESC(pki_port, "Specifies which ports connect to the PKI.");
> >
> >Likewise
> 
> The SoC is flexible in how it is configured.  Technically the device tree
> should only be used to specify information about the physical configuration
> of the system that cannot be probed for, and this is about policy rather
> that physical wiring.  That said, we do take the default configuration from
> the device tree, but give the option here to override via the module command
> line.

Module parameters are pretty much frowned upon. 

You should really try to remove them all, if possible.

> >>+/* Registers are accessed via xkphys */
> >>+#define SSO_BASE			0x1670000000000ull
> >>+#define SSO_ADDR(node)			(SET_XKPHYS + NODE_OFFSET(node) +      \
> >>+					 SSO_BASE)
> >>+#define GRP_OFFSET(grp)			((grp) << 16)
> >>+#define GRP_ADDR(n, g)			(SSO_ADDR(n) + GRP_OFFSET(g))
> >>+#define SSO_GRP_AQ_CNT(n, g)		(GRP_ADDR(n, g)		   + 0x20000700)
> >>+
> >>+#define MIO_PTP_BASE			0x1070000000000ull
> >>+#define MIO_PTP_ADDR(node)		(SET_XKPHYS + NODE_OFFSET(node) +      \
> >>+					 MIO_PTP_BASE)
> >>+#define MIO_PTP_CLOCK_CFG(node)		(MIO_PTP_ADDR(node)		+ 0xf00)
> >>+#define MIO_PTP_CLOCK_HI(node)		(MIO_PTP_ADDR(node)		+ 0xf10)
> >>+#define MIO_PTP_CLOCK_COMP(node)	(MIO_PTP_ADDR(node)		+ 0xf18)
> >
> >I am sure this will work great on anything but MIPS64 ;)
> 
> Sarcasm duly noted.
> 
> That said, by definition it is exactly an OCTEON-III/MIPS64, and can never
> be anything else.  It is known a priori that the hardware and this driver
> will never be used anywhere else.

Please make sure your Kconfig really enforces this. Generally, we
suggest allowing the driver to be compiled when COMPILE_TEST is set.
That gives you better compiler test coverage. But it seems like this
driver won't compile under such conditions.

> >>+static int num_packet_buffers = 768;
> >>+module_param(num_packet_buffers, int, 0444);
> >>+MODULE_PARM_DESC(num_packet_buffers,
> >>+		 "Number of packet buffers to allocate per port.");
> >
> >Consider implementing ethtool -g/G for this.
> 
> That may be work for a follow-on patch.

Then please remove the module parameter now.

> >>+static int rx_queues = 1;
> >>+module_param(rx_queues, int, 0444);
> >>+MODULE_PARM_DESC(rx_queues, "Number of RX threads per port.");
> >
> >Same thing, can you consider using an ethtool knob for that?
> 
> Also may be work for a follow-on patch.

Ditto

> >>+/**
> >>+ * Reads a 64 bit value from the processor local scratchpad memory.
> >>+ *
> >>+ * @param offset byte offset into scratch pad to read
> >>+ *
> >>+ * @return value read
> >>+ */
> >>+static inline u64 scratch_read64(u64 offset)
> >>+{
> >>+	return *(u64 *)((long)SCRATCH_BASE + offset);
> >>+}
> >
> >No barriers needed whatsoever?
> 
> Nope.

Then it would be good to add a comment about why no barrier is
needed. Otherwise people are going to ask why there is no barrier,
submit patches adding barriers, etc.

       Andrew
