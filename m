Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 04 Mar 2009 22:25:46 +0000 (GMT)
Received: from sj-iport-3.cisco.com ([171.71.176.72]:41373 "EHLO
	sj-iport-3.cisco.com") by ftp.linux-mips.org with ESMTP
	id S21365695AbZCDWZo convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 4 Mar 2009 22:25:44 +0000
X-IronPort-AV: E=Sophos;i="4.38,303,1233532800"; 
   d="scan'208";a="139494868"
Received: from sj-dkim-4.cisco.com ([171.71.179.196])
  by sj-iport-3.cisco.com with ESMTP; 04 Mar 2009 22:25:37 +0000
Received: from sj-core-2.cisco.com (sj-core-2.cisco.com [171.71.177.254])
	by sj-dkim-4.cisco.com (8.12.11/8.12.11) with ESMTP id n24MPbT9025135;
	Wed, 4 Mar 2009 14:25:37 -0800
Received: from xbh-rtp-201.amer.cisco.com (xbh-rtp-201.cisco.com [64.102.31.12])
	by sj-core-2.cisco.com (8.13.8/8.13.8) with ESMTP id n24MPaj8022064;
	Wed, 4 Mar 2009 22:25:36 GMT
Received: from xmb-rtp-218.amer.cisco.com ([64.102.31.117]) by xbh-rtp-201.amer.cisco.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Wed, 4 Mar 2009 17:25:36 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [PATCH, RFC] MIPS: Implement the getcontext API
Date:	Wed, 4 Mar 2009 17:25:35 -0500
Message-ID: <FF038EB85946AA46B18DFEE6E6F8A289BE0B68@xmb-rtp-218.amer.cisco.com>
In-Reply-To: <20090304154418.GA13464@linux-mips.org>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH, RFC] MIPS: Implement the getcontext API
Thread-Index: Acmc4ESDyhWudsJMRte5BEcO+1iu2QAN0gVQ
References: <alpine.DEB.1.10.0902282326580.4064@tp.orcam.me.uk> <49AD6139.60209@caviumnetworks.com> <200903040919.29294.brian.foster@innova-card.com> <20090304154418.GA13464@linux-mips.org>
From:	"David VomLehn (dvomlehn)" <dvomlehn@cisco.com>
To:	"Ralf Baechle" <ralf@linux-mips.org>,
	"Brian Foster" <brian.foster@innova-card.com>
Cc:	"David Daney" <ddaney@caviumnetworks.com>,
	"Maciej W. Rozycki" <macro@codesourcery.com>,
	<linux-mips@linux-mips.org>, <libc-ports@sourceware.org>,
	"Maciej W. Rozycki" <macro@linux-mips.org>
X-OriginalArrivalTime: 04 Mar 2009 22:25:36.0599 (UTC) FILETIME=[24071670:01C99D18]
DKIM-Signature:	v=1; a=rsa-sha256; q=dns/txt; l=1814; t=1236205537; x=1237069537;
	c=relaxed/simple; s=sjdkim4002;
	h=Content-Type:From:Subject:Content-Transfer-Encoding:MIME-Version;
	d=cisco.com; i=dvomlehn@cisco.com;
	z=From:=20=22David=20VomLehn=20(dvomlehn)=22=20<dvomlehn@cis
	co.com>
	|Subject:=20RE=3A=20[PATCH,=20RFC]=20MIPS=3A=20Implement=20
	the=20getcontext=20API
	|Sender:=20;
	bh=Jb5HcdrPhHVfpf0WY4tayloauviO7DYGwAEnQShfgmU=;
	b=twC9FsnRhuMmYebOc1LzoYNJDtfWMih2SqlyOATQ8e2LOYIaRGZeXUVvFX
	ulwe08MT9XRkhYmzbL22N/t3Qxm0mnR4ay+wD9bYnzWlweDXxZ6xEnKmf/iG
	AlXDJIZi+z;
Authentication-Results:	sj-dkim-4; header.From=dvomlehn@cisco.com; dkim=pass (
	sig from cisco.com/sjdkim4002 verified; ); 
Return-Path: <dvomlehn@cisco.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22004
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dvomlehn@cisco.com
Precedence: bulk
X-list: linux-mips

> -----Original Message-----
> From: linux-mips-bounce@linux-mips.org 
> [mailto:linux-mips-bounce@linux-mips.org] On Behalf Of Ralf Baechle
> Sent: Wednesday, March 04, 2009 7:44 AM
> To: Brian Foster
> Cc: David Daney; Maciej W. Rozycki; 
> linux-mips@linux-mips.org; libc-ports@sourceware.org; Maciej 
> W. Rozycki
> Subject: Re: [PATCH, RFC] MIPS: Implement the getcontext API
> 
> On Wed, Mar 04, 2009 at 09:19:28AM +0100, Brian Foster wrote:
> 
> > On Tuesday 03 March 2009 17:56:25 David Daney wrote:
> > >[ ... ]
> > > When (and if) we move the sigreturn trampoline to a vdso 
> we should be
> > > able to maintain the ABI.
> > 
> >  it's more a matter of "when" rather than "if".
> >  there is still an intention here to use XI (we
> >  have SmartMIPS), which requires not using the
> >  signal (or FP) trampoline on the stack.
> > 
> >  moving the signal trampoline to a vdso (which
> >  is(? was?) called, maybe misleadingly, 'vsyscall',
> >  on other architectures) is the obvious solution to
> >  that part of the puzzle.  and yes, it is possible
> >  to maintain the ABI; the signal trampoline is still
> >  also put on the stack, and modulo XI, would work if
> >  used - the trampoline-on-stack is simply not used
> >  if there is a vdso with the signal trampoline.
> 
> We generally want to get rid of stack trampolines.  
> Trampolines require
> cacheflushing which especially on SMP systems can be a rather 
> expensive
> operation.

If I understand this correctly, using a vdso would allow a stack without
execute permission on those processors that differentiate between read
and execute permission. This defeats attaches that use buffer overrun to
write code to be executed onto the stack, a nice thing for more secure
systems.
