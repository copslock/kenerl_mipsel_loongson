Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 19 Mar 2007 17:59:42 +0000 (GMT)
Received: from father.pmc-sierra.com ([216.241.224.13]:52735 "HELO
	father.pmc-sierra.bc.ca") by ftp.linux-mips.org with SMTP
	id S20021726AbXCSR7h (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 19 Mar 2007 17:59:37 +0000
Received: (qmail 29094 invoked by uid 101); 19 Mar 2007 17:58:25 -0000
Received: from unknown (HELO pmxedge2.pmc-sierra.bc.ca) (216.241.226.184)
  by father.pmc-sierra.com with SMTP; 19 Mar 2007 17:58:25 -0000
Received: from bby1exi01.pmc_nt.nt.pmc-sierra.bc.ca (bby1exi01.pmc-sierra.bc.ca [216.241.231.251])
	by pmxedge2.pmc-sierra.bc.ca (8.13.4/8.12.7) with ESMTP id l2JHwGgW010036;
	Mon, 19 Mar 2007 09:58:24 -0800
Received: by bby1exi01.pmc-sierra.bc.ca with Internet Mail Service (5.5.2657.72)
	id <FGCPZL09>; Mon, 19 Mar 2007 10:58:13 -0800
Message-ID: <45FECF32.9020600@pmc-sierra.com>
From:	Marc St-Jean <Marc_St-Jean@pmc-sierra.com>
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc:	stjeanma@pmc-sierra.com, akpm@linux-foundation.org,
	linux-mips@linux-mips.org
Subject: Re: [PATCH 1/12] mips: PMC MSP71xx core platform
Date:	Mon, 19 Mar 2007 09:58:10 -0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2657.72)
x-originalarrivaltime: 19 Mar 2007 18:58:03.0687 (UTC) FILETIME=[85BE8370:01C76A58]
user-agent: Thunderbird 1.5.0.10 (X11/20070221)
Content-Type: text/plain;
	charset="iso-8859-1"
Return-Path: <Marc_St-Jean@pmc-sierra.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14569
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Marc_St-Jean@pmc-sierra.com
Precedence: bulk
X-list: linux-mips


Atsushi Nemoto wrote:
> On Fri, 16 Mar 2007 15:32:56 -0600, Marc St-Jean 
> <stjeanma@pmc-sierra.com> wrote:
>  > +static struct irq_chip msp_cic_irq_controller = {
>  > +     .typename = "MSP_CIC",
> 
> The 'typename' is obsolete.  Use 'name'.  Also, using new flow handler
> (and GENERIC_HARDIRQS_NO__DO_IRQ in Kconfig) might give you a little
> bit better performance.

Thanks Atsushi.

By "using new flow handler" do you mean specifying "handle_level_irq",
"handle_edge_irq". etc?

Marc
