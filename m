Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 23 Apr 2003 00:07:46 +0100 (BST)
Received: from p508B5EC1.dip.t-dialin.net ([IPv6:::ffff:80.139.94.193]:50364
	"EHLO dea.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225208AbTDVXHl>; Wed, 23 Apr 2003 00:07:41 +0100
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.6/8.11.6) id h3MN7RC08505;
	Wed, 23 Apr 2003 01:07:27 +0200
Date: Wed, 23 Apr 2003 01:07:27 +0200
From: Ralf Baechle <ralf@linux-mips.org>
To: Jun Sun <jsun@mvista.com>
Cc: Jeff Baitis <baitisj@evolution.com>,
	Pete Popov <ppopov@mvista.com>, linux-mips@linux-mips.org,
	Matthew Dharm <mdharm@momenco.com>
Subject: Re: Improperly handled case in arch/mips/au1000/common/time.c
Message-ID: <20030423010727.A8410@linux-mips.org>
References: <20030422125450.E10148@luca.pas.lab> <20030422155625.E28544@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030422155625.E28544@mvista.com>; from jsun@mvista.com on Tue, Apr 22, 2003 at 03:56:25PM -0700
Return-Path: <ralf@linux-mips.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2142
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Apr 22, 2003 at 03:56:25PM -0700, Jun Sun wrote:

> I think this is a good example to show benefit of code sharing.
> There is no good reason for au1x00 boards of not using new time.c.
> You get to write less board code, fewer bugs and future proof.

There are just three configurations left using CONFIG_OLD_TIME_C:

 - EV64120 which I guess can be considered abandonded
 - Momenco Ocelot (Matthew, feel like you have time to take care of
   this?)
 - RM200  (semi-maintained, my turn to fix it ...)

Seems like it's time to get rid of CONFIG_OLD_TIME_C.

  Ralf
