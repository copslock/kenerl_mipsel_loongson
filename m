Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 07 Jun 2006 15:57:07 +0100 (BST)
Received: from adsl-71-128-175-242.dsl.pltn13.pacbell.net ([71.128.175.242]:33949
	"EHLO build.embeddedalley.com") by ftp.linux-mips.org with ESMTP
	id S8134014AbWFGO5A (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 7 Jun 2006 15:57:00 +0100
Received: from localhost.localdomain (build.embeddedalley.com [127.0.0.1])
	by build.embeddedalley.com (8.13.1/8.13.1) with ESMTP id k57Esc9c019601;
	Wed, 7 Jun 2006 07:54:40 -0700
Subject: Re: [linux-usb-devel] [PATCH] Fix OHCI HCD build for PNX 8550
From:	Pete Popov <ppopov@embeddedalley.com>
Reply-To: ppopov@embeddedalley.com
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	David Brownell <david-b@pacbell.net>,
	linux-usb-devel@lists.sourceforge.net, gregkh@suse.de,
	linux-mips@linux-mips.org
In-Reply-To: <20060607143721.GA31497@linux-mips.org>
References: <20060607135922.GA26754@linux-mips.org>
	 <200606070727.57618.david-b@pacbell.net>
	 <20060607143721.GA31497@linux-mips.org>
Content-Type: text/plain
Organization: Embedded Alley Solutions, Inc
Date:	Wed, 07 Jun 2006 17:56:47 +0300
Message-Id: <1149692207.18925.259.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Return-Path: <ppopov@embeddedalley.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11687
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ppopov@embeddedalley.com
Precedence: bulk
X-list: linux-mips

On Wed, 2006-06-07 at 15:37 +0100, Ralf Baechle wrote:
> On Wed, Jun 07, 2006 at 07:27:56AM -0700, David Brownell wrote:
> 
> > On Wednesday 07 June 2006 6:59 am, Ralf Baechle wrote:
> > > The PNX8550 OHCI is a platform device so we better include the necessary
> > > headers.
> > 
> > PNX ohci support has not been submitted upstream yet... just merge this
> > with that patch before submitting.
> 
> Whops.  Well, I discovered alot more breakage that this one so I'll
> abstain and leave the fixing to others that actually have hardware ...

I'll talk to Philips to see how they want to handle the maintenance of
the 8550.

Thanks,

Pete
