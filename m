Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 01 Aug 2003 18:47:33 +0100 (BST)
Received: from gateway-1237.mvista.com ([IPv6:::ffff:12.44.186.158]:36599 "EHLO
	orion.mvista.com") by linux-mips.org with ESMTP id <S8225207AbTHARrb>;
	Fri, 1 Aug 2003 18:47:31 +0100
Received: (from jsun@localhost)
	by orion.mvista.com (8.11.6/8.11.6) id h71HlPU15176;
	Fri, 1 Aug 2003 10:47:25 -0700
Date: Fri, 1 Aug 2003 10:47:25 -0700
From: Jun Sun <jsun@mvista.com>
To: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc: macro@ds2.pg.gda.pl, linux-mips@linux-mips.org, jsun@mvista.com
Subject: Re: Malta + USB on 2.4, anyone?
Message-ID: <20030801104725.I11120@mvista.com>
References: <Pine.GSO.3.96.1030731121705.17497D-100000@delta.ds2.pg.gda.pl> <20030731103629.D14914@mvista.com> <20030731111506.F14914@mvista.com> <20030801.172623.85417982.nemoto@toshiba-tops.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20030801.172623.85417982.nemoto@toshiba-tops.co.jp>; from anemo@mba.ocn.ne.jp on Fri, Aug 01, 2003 at 05:26:23PM +0900
Return-Path: <jsun@mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2964
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jsun@mvista.com
Precedence: bulk
X-list: linux-mips

On Fri, Aug 01, 2003 at 05:26:23PM +0900, Atsushi Nemoto wrote:
> >>>>> On Thu, 31 Jul 2003 11:15:06 -0700, Jun Sun <jsun@mvista.com> said:
> jsun> I suspect the main UHCI driver does not get cache flushing or
> jsun> bus/virt address right.
> 
> It seems usb_control_msg is not safe with an unaligned buffer.  Is
> this patch solve your problem?
>

Nope.

The symptoms of erractic hw behavior seems to suggest maybe addressing
is wrong in physical space.  Just a guess.  I don't think I will spend
more time on this though. :)

Thanks for the patch.

Jun
