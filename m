Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 30 Dec 2003 15:43:42 +0000 (GMT)
Received: from witte.sonytel.be ([IPv6:::ffff:80.88.33.193]:15239 "EHLO
	witte.sonytel.be") by linux-mips.org with ESMTP id <S8225269AbTL3Pnl>;
	Tue, 30 Dec 2003 15:43:41 +0000
Received: from teasel.sonytel.be (localhost [127.0.0.1])
	by witte.sonytel.be (8.12.10/8.12.10) with ESMTP id hBUFhaQF010996;
	Tue, 30 Dec 2003 16:43:36 +0100 (MET)
Received: (from dimitri@localhost)
	by teasel.sonytel.be (8.9.3+Sun/8.9.3) id QAA10593;
	Tue, 30 Dec 2003 16:43:36 +0100 (MET)
Date: Tue, 30 Dec 2003 16:43:36 +0100
From: Dimitri Torfs <dimitri@sonycom.com>
To: Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
Cc: linux-mips@linux-mips.org
Subject: Re: supported systems running on 2.6 ?
Message-ID: <20031230154336.GA10535@sonycom.com>
References: <20031230144904.GA10358@sonycom.com> <20031231001701.4c43637b.yuasa@hh.iij4u.or.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031231001701.4c43637b.yuasa@hh.iij4u.or.jp>
User-Agent: Mutt/1.4.1i
Return-Path: <dimitri@sonycom.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3855
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dimitri@sonycom.com
Precedence: bulk
X-list: linux-mips

On Wed, Dec 31, 2003 at 12:17:01AM +0900, Yoichi Yuasa wrote:
> On Tue, 30 Dec 2003 15:49:04 +0100
> Dimitri Torfs <dimitri@sonycom.com> wrote:
> 
> > Hi,
> > 
> >   are there already MIPS systems running on 2.6.0 ? If so, which ones
> >   ? I'm currently porting a VR41xx based configuration from 2.4.24 to
> >   2.6.0: boot sequence seems to be OK, but the init process doesn't
> >   come up (it looks like its not properly laid out in memory, thus
> >   continuously generating exceptions (do_signal()) ...). Is it too
> >   soon to expect it to work ?
> 
> Which Vr41xx's configuration did you use?

None of the default ones in the tree, it's not a board listed in the
configs (the board has a VR4120A and a VR4131 cpu). I'm currently
using a configuration with CONFIG_EMBEDDED_RAMDISK set and
CONFIG_MACH_VR41XX. 

Is there a working config with a VR41xx on 2.6.0 ? It would surprise
me since I had to do some fixes for the VR41xx series (for some I
already sent a patch) which seem to indicate the VR41xx specifics have
not yet been actively looked at for 2.6.0 (although I know you
have been submitting patches for the Vr41xx).


Dimitri




-- 
Dimitri Torfs             |  NSCE 
dimitri.torfs@sonycom.com |  Sint Stevens Woluwestraat 55
tel: +32 2 2908451        |  1130 Brussel
fax: +32 2 7262686        |  Belgium
