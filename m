Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 30 Dec 2003 17:10:30 +0000 (GMT)
Received: from mo03.iij4u.or.jp ([IPv6:::ffff:210.130.0.20]:11219 "EHLO
	mo03.iij4u.or.jp") by linux-mips.org with ESMTP id <S8225274AbTL3RK3>;
	Tue, 30 Dec 2003 17:10:29 +0000
Received: from mdo00.iij4u.or.jp (mdo00.iij4u.or.jp [210.130.0.170])
	by mo03.iij4u.or.jp (8.8.8/MFO1.5) with ESMTP id CAA03036;
	Wed, 31 Dec 2003 02:10:24 +0900 (JST)
Received: 4UMDO00 id hBUHANN24530; Wed, 31 Dec 2003 02:10:23 +0900 (JST)
Received: 4UMRO01 id hBUHANf05815; Wed, 31 Dec 2003 02:10:23 +0900 (JST)
	from stratos.frog (64.43.138.210.xn.2iij.net [210.138.43.64]) (authenticated)
Date: Wed, 31 Dec 2003 02:10:18 +0900
From: Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
To: Dimitri Torfs <dimitri@sonycom.com>
Cc: yuasa@hh.iij4u.or.jp, linux-mips@linux-mips.org
Subject: Re: supported systems running on 2.6 ?
Message-Id: <20031231021018.224b6c20.yuasa@hh.iij4u.or.jp>
In-Reply-To: <20031230154336.GA10535@sonycom.com>
References: <20031230144904.GA10358@sonycom.com>
	<20031231001701.4c43637b.yuasa@hh.iij4u.or.jp>
	<20031230154336.GA10535@sonycom.com>
X-Mailer: Sylpheed version 0.9.8a (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yuasa@hh.iij4u.or.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3858
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yuasa@hh.iij4u.or.jp
Precedence: bulk
X-list: linux-mips

On Tue, 30 Dec 2003 16:43:36 +0100
Dimitri Torfs <dimitri@sonycom.com> wrote:

> On Wed, Dec 31, 2003 at 12:17:01AM +0900, Yoichi Yuasa wrote:
> > On Tue, 30 Dec 2003 15:49:04 +0100
> > Dimitri Torfs <dimitri@sonycom.com> wrote:
> > 
> > > Hi,
> > > 
> > >   are there already MIPS systems running on 2.6.0 ? If so, which ones
> > >   ? I'm currently porting a VR41xx based configuration from 2.4.24 to
> > >   2.6.0: boot sequence seems to be OK, but the init process doesn't
> > >   come up (it looks like its not properly laid out in memory, thus
> > >   continuously generating exceptions (do_signal()) ...). Is it too
> > >   soon to expect it to work ?
> > 
> > Which Vr41xx's configuration did you use?
> 
> None of the default ones in the tree, it's not a board listed in the
> configs (the board has a VR4120A and a VR4131 cpu). I'm currently
> using a configuration with CONFIG_EMBEDDED_RAMDISK set and
> CONFIG_MACH_VR41XX. 
> 
> Is there a working config with a VR41xx on 2.6.0 ? It would surprise
> me since I had to do some fixes for the VR41xx series (for some I
> already sent a patch) which seem to indicate the VR41xx specifics have
> not yet been actively looked at for 2.6.0 (although I know you
> have been submitting patches for the Vr41xx).

About 2.6 of linux-mips, development progressed quickly
several of these months.

Therefore, we are not completing Vr41xx about 2.6.

Yoichi
