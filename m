Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 12 Feb 2004 14:32:57 +0000 (GMT)
Received: from mx5.Informatik.Uni-Tuebingen.De ([IPv6:::ffff:134.2.12.32]:11432
	"EHLO mx5.informatik.uni-tuebingen.de") by linux-mips.org with ESMTP
	id <S8225248AbUBLOc5>; Thu, 12 Feb 2004 14:32:57 +0000
Received: from localhost (loopback [127.0.0.1])
	by mx5.informatik.uni-tuebingen.de (Postfix) with ESMTP
	id E4467144; Thu, 12 Feb 2004 15:32:48 +0100 (NFT)
Received: from mx3.informatik.uni-tuebingen.de ([134.2.12.26])
 by localhost (mx5 [134.2.12.32]) (amavisd-new, port 10024) with ESMTP
 id 51948-04; Thu, 12 Feb 2004 15:32:47 +0100 (NFT)
Received: from dual (semeai [134.2.15.66])
	by mx3.informatik.uni-tuebingen.de (Postfix) with ESMTP
	id 69B7D134; Thu, 12 Feb 2004 15:32:46 +0100 (NFT)
Received: from mrvn by dual with local (Exim 3.36 #1 (Debian))
	id 1ArHtV-0003tA-00; Thu, 12 Feb 2004 15:32:45 +0100
To: Seth Mos <knuffie@xs4all.nl>
Cc: Goswin von Brederlow <brederlo@informatik.uni-tuebingen.de>,
	"jeff_lee" <jeff_lee@coventive.com>, <linux-mips@linux-mips.org>
Subject: Re: About XFS file system
References: <01df01c3f10c$ec579450$c117a8c0@pc193>
	<3DC3910A44FBD94B8513C8E2A3F220E1560A0B@sc-msexch-16.extremenetworks.com>
	<01df01c3f10c$ec579450$c117a8c0@pc193>
	<4.3.2.7.2.20040212134541.02e55be0@pop.xs4all.nl>
From: Goswin von Brederlow <brederlo@informatik.uni-tuebingen.de>
Date: 12 Feb 2004 15:32:45 +0100
In-Reply-To: <4.3.2.7.2.20040212134541.02e55be0@pop.xs4all.nl>
Message-ID: <87u11wz7ua.fsf@mrvn.homelinux.org>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Reasonable Discussion)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Virus-Scanned: by amavisd-new (McAfee AntiVirus) at informatik.uni-tuebingen.de
Return-Path: <brederlo@informatik.uni-tuebingen.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4339
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: brederlo@informatik.uni-tuebingen.de
Precedence: bulk
X-list: linux-mips

Seth Mos <knuffie@xs4all.nl> writes:

> At 03:41 12-2-2004 +0100, Goswin von Brederlow wrote:
> >"jeff_lee" <jeff_lee@coventive.com> writes:
> >
> > > Dear MIPS members,
> > >     Does anyone try XFS file system on MIPS(VR serier) platform?
> > >
> > > Thanks and best regards,
> > >
> > > Jeff
> >
> >xfs, xfs or xfs?
> 
> The filesystem not the font server. Should work, but lack of hardware
> prevents me from testing it.

There is the journaling filesystem, the userspace filesystem (used by
arla) and another one also called xfs.

I guess you mean the kernel included one though.

Nope, sorry, havent.

> Sparc, PPC, itanium and intel and x86-64 work. Pa-risc I don't know. I
> believe there are still some alpha boxes running somewhere.
> 
> 
> If you have problems you can ask for XFS related questions on
> linux-xfs@oss.sgi.com

MfG
        Goswin
