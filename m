Received:  by oss.sgi.com id <S553757AbRAICwJ>;
	Mon, 8 Jan 2001 18:52:09 -0800
Received: from brutus.conectiva.com.br ([200.250.58.146]:57846 "EHLO
        dhcp046.distro.conectiva") by oss.sgi.com with ESMTP
	id <S553751AbRAICvs>; Mon, 8 Jan 2001 18:51:48 -0800
Received: (ralf@lappi.waldorf-gmbh.de) by bacchus.dhis.org
	id <S869786AbRAICli>; Tue, 9 Jan 2001 00:41:38 -0200
Date:	Tue, 9 Jan 2001 00:41:38 -0200
From:	Ralf Baechle <ralf@oss.sgi.com>
To:	Predrag Malicevic <pmalic@blic.net>
Cc:	<linux-mips@oss.sgi.com>
Subject: Re: O200 problem...
Message-ID: <20010109004138.A12181@bacchus.dhis.org>
References: <Pine.LNX.4.30.0101090210460.10752-100000@quake.blic.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.30.0101090210460.10752-100000@quake.blic.net>; from pmalic@blic.net on Tue, Jan 09, 2001 at 03:16:20AM +0100
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Tue, Jan 09, 2001 at 03:16:20AM +0100, Predrag Malicevic wrote:

> I'm trying to install Linux on an Origin 200 and I'm having problems with
> booting the kernel (CVS tree linux from oss.sgi.com).  I've included below
> a console session of my tries to boot the kernel.  In two cases below I
> used the default kernel configuration but without the SCSI driver.  In the
> first case I used parameters root=/dev/nfs and nfsroot=.... It reached
> 'Calibrating delay loop' and then 'Got dbe at 0xffffffff8013e970'.  After
> that, I guess, some kind of register dump followed (I'm working with MIPS
> architecture for the first time).  In the second case it reached "TCP:
> Hash tables configured". Besides these two tries, I've tried using
> different kernel configuration options in the machine selection category
> and besides the obvious ones (IP27, IP27 N-Mode and Multi-Processing), I'm
> clueless about the meaning of other options.

> CPU 0 clock is 65535MHz.

Something's fishy.  I guess ;-)

> [ Here the machines hangs again. I've tried many more times with different kernel configurations, but it's the same thing. It either "gets a dbe" or just stops after "TCP: Hash tables ..." ]

I assume it's your specific configuration that's triggering the problem.
I've got the current CVS kernel running on 2 dual processor O200 and a
32 processor Origin 2000, so it can't be all broken.  I think all known
to be working configuratons are machines with significantly more memory;
dunno if that's really related or not.

Thanks for sending the oops message; however without additional data
provided I can't use it.  Can you please point please put the kernel image
that resulted in the oops online?

  Ralf
