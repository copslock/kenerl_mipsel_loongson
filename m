Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 05 Oct 2004 00:58:47 +0100 (BST)
Received: from sccrmhc13.comcast.net ([IPv6:::ffff:204.127.202.64]:19664 "EHLO
	sccrmhc13.comcast.net") by linux-mips.org with ESMTP
	id <S8224917AbUJDX6n>; Tue, 5 Oct 2004 00:58:43 +0100
Received: from gateway.junsun.net (c-24-6-204-16.client.comcast.net[24.6.204.16])
          by comcast.net (sccrmhc13) with ESMTP
          id <2004100423583601600c5p6je>; Mon, 4 Oct 2004 23:58:36 +0000
Received: from gateway.junsun.net (gateway [127.0.0.1])
	by gateway.junsun.net (8.12.8/8.12.8) with ESMTP id i95003TW009814;
	Mon, 4 Oct 2004 17:00:03 -0700
Received: (from jsun@localhost)
	by gateway.junsun.net (8.12.8/8.12.8/Submit) id i95002bl009812;
	Mon, 4 Oct 2004 17:00:02 -0700
Date: Mon, 4 Oct 2004 17:00:02 -0700
From: Jun Sun <jsun@junsun.net>
To: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc: jsun@mvista.com, wsonguci@yahoo.com, linux-mips@linux-mips.org
Subject: Re: 2.6 preemptive kernel on mips
Message-ID: <20041005000002.GB9718@gateway.junsun.net>
References: <20040803192244.5889.qmail@web40002.mail.yahoo.com> <20040803124048.C1926@mvista.com> <20041004.211504.03974923.nemoto@toshiba-tops.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041004.211504.03974923.nemoto@toshiba-tops.co.jp>
User-Agent: Mutt/1.4i
Return-Path: <jsun@junsun.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5936
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jsun@junsun.net
Precedence: bulk
X-list: linux-mips

On Mon, Oct 04, 2004 at 09:15:04PM +0900, Atsushi Nemoto wrote:
> >>>>> On Tue, 3 Aug 2004 12:40:48 -0700, Jun Sun <jsun@mvista.com> said:
> jsun> Try the latest kernel.  I checked preemption around 2.6.5 time
> jsun> and I believe all the obvious problems are fixed then.
> 
> Hi.  Now I'm looking current (2.6.9-rc1) code.
> 
> It lacks some preempt_disable/preempt_enable which were in
> preempt-patch for 2.4 kernel.  Are these all unnecessary at all?
> 

They are necessary.

> For example, fpu-emulation is not preemptive-safe, isn't it?
> 

That is correct.

I think the best thing to do right now is to go through
2.4 preemption patch and pick up the missing ones for 2.6.

It will probably take me a little given other things on my hand.
I strongly enourage someone else to take a shoot at it.  The latest
2.4 MIPS preemption patch seems to be 

http://linux.junsun.net/patches/oss.sgi.com/experimental/030304-b.preempt-mips.patch

Jun
