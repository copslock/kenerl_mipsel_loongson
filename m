Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 13 Sep 2007 02:51:38 +0100 (BST)
Received: from phoenix.bawue.net ([193.7.176.60]:32231 "EHLO mail.bawue.net")
	by ftp.linux-mips.org with ESMTP id S20024280AbXIMBva (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 13 Sep 2007 02:51:30 +0100
Received: from lagash (88-106-155-113.dynamic.dsl.as9105.com [88.106.155.113])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.bawue.net (Postfix) with ESMTP id 1A666B882A;
	Thu, 13 Sep 2007 03:42:54 +0200 (CEST)
Received: from ths by lagash with local (Exim 4.67)
	(envelope-from <ths@networkno.de>)
	id 1IVdjC-0001t3-Ji; Thu, 13 Sep 2007 02:42:46 +0100
Date:	Thu, 13 Sep 2007 02:42:46 +0100
From:	Thiemo Seufer <ths@networkno.de>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	Matteo Croce <technoboy85@gmail.com>, linux-mips@linux-mips.org,
	Eugene Konev <ejka@imfi.kspu.ru>, netdev@vger.kernel.org,
	davem@davemloft.net, kuznet@ms2.inr.ac.ru, pekkas@netcore.fi,
	jmorris@namei.org, yoshfuji@linux-ipv6.org, kaber@coreworks.de,
	openwrt-devel@lists.openwrt.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH][MIPS][7/7] AR7: ethernet
Message-ID: <20070913014246.GB15247@networkno.de>
References: <200709080143.12345.technoboy85@gmail.com> <200709080223.00613.technoboy85@gmail.com> <20070912165029.GG4571@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070912165029.GG4571@linux-mips.org>
User-Agent: Mutt/1.5.16 (2007-06-11)
Return-Path: <ths@networkno.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16484
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ths@networkno.de
Precedence: bulk
X-list: linux-mips

Ralf Baechle wrote:
> On Sat, Sep 08, 2007 at 02:23:00AM +0200, Matteo Croce wrote:
[snip]
> > +/* Register definitions */
> > +struct cpmac_control_regs {
> > +	u32 revision;
> > +	u32 control;
> > +	u32 teardown;
> > +	u32 unused;
> > +} __attribute__ ((packed));
> > +
> > +struct cpmac_int_regs {
> > +	u32 stat_raw;
> > +	u32 stat_masked;
> > +	u32 enable;
> > +	u32 clear;
> > +} __attribute__ ((packed));
> > +
> > +struct cpmac_stats {
> > +	u32 good;
> > +	u32 bcast;
> > +	u32 mcast;
> > +	u32 pause;
> > +	u32 crc_error;
> > +	u32 align_error;
> > +	u32 oversized;
> > +	u32 jabber;
> > +	u32 undersized;
> > +	u32 fragment;
> > +	u32 filtered;
> > +	u32 qos_filtered;
> > +	u32 octets;
> > +} __attribute__ ((packed));
> 
> All struct members here are sized such that there is no padding needed, so
> the packed attribute doesn't buy you anything - unless of course the
> entire structure is missaligned but I don't see how that would be possible
> in this driver so the __attribute__ ((packed)) should go - it result in
> somwhat larger and slower code.

FWIW, a modern gcc will warn about such superfluous packed attributes,
that's another reason to remove those.


Thiemo
