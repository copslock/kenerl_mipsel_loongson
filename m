Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 12 Feb 2004 14:55:43 +0000 (GMT)
Received: from mo03.iij4u.or.jp ([IPv6:::ffff:210.130.0.20]:35547 "EHLO
	mo03.iij4u.or.jp") by linux-mips.org with ESMTP id <S8224991AbUBLOzn>;
	Thu, 12 Feb 2004 14:55:43 +0000
Received: from mdo01.iij4u.or.jp (mdo01.iij4u.or.jp [210.130.0.171])
	by mo03.iij4u.or.jp (8.8.8/MFO1.5) with ESMTP id XAA03624;
	Thu, 12 Feb 2004 23:55:00 +0900 (JST)
Received: 4UMDO01 id i1CEsxV09291; Thu, 12 Feb 2004 23:54:59 +0900 (JST)
Received: 4UMRO01 id i1CEss515101; Thu, 12 Feb 2004 23:54:54 +0900 (JST)
	from stratos.frog (64.43.138.210.xn.2iij.net [210.138.43.64]) (authenticated)
Date: Thu, 12 Feb 2004 23:54:52 +0900
From: Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
To: Goswin von Brederlow <brederlo@informatik.uni-tuebingen.de>
Cc: yuasa@hh.iij4u.or.jp, knuffie@xs4all.nl,
	brederlo@informatik.uni-tuebingen.de, jeff_lee@coventive.com,
	linux-mips@linux-mips.org
Subject: Re: About XFS file system
Message-Id: <20040212235452.43a0a5f9.yuasa@hh.iij4u.or.jp>
In-Reply-To: <87u11wz7ua.fsf@mrvn.homelinux.org>
References: <01df01c3f10c$ec579450$c117a8c0@pc193>
	<3DC3910A44FBD94B8513C8E2A3F220E1560A0B@sc-msexch-16.extremenetworks.com>
	<01df01c3f10c$ec579450$c117a8c0@pc193>
	<4.3.2.7.2.20040212134541.02e55be0@pop.xs4all.nl>
	<87u11wz7ua.fsf@mrvn.homelinux.org>
X-Mailer: Sylpheed version 0.9.9 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yuasa@hh.iij4u.or.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4340
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yuasa@hh.iij4u.or.jp
Precedence: bulk
X-list: linux-mips

Hi,

On 12 Feb 2004 15:32:45 +0100
Goswin von Brederlow <brederlo@informatik.uni-tuebingen.de> wrote:

> Seth Mos <knuffie@xs4all.nl> writes:
> 
> > At 03:41 12-2-2004 +0100, Goswin von Brederlow wrote:
> > >"jeff_lee" <jeff_lee@coventive.com> writes:
> > >
> > > > Dear MIPS members,
> > > >     Does anyone try XFS file system on MIPS(VR serier) platform?
> > > >
> > > > Thanks and best regards,
> > > >
> > > > Jeff
> > >
> > >xfs, xfs or xfs?
> > 
> > The filesystem not the font server. Should work, but lack of hardware
> > prevents me from testing it.
> 
> There is the journaling filesystem, the userspace filesystem (used by
> arla) and another one also called xfs.
> 
> I guess you mean the kernel included one though.
> 
> Nope, sorry, havent.

I have tested it today.
It seems that it has a problem.

I'll investigate details tomorrow.

Yoichi
