Received:  by oss.sgi.com id <S553682AbRAPGLt>;
	Mon, 15 Jan 2001 22:11:49 -0800
Received: from brutus.conectiva.com.br ([200.250.58.146]:15600 "EHLO
        dhcp046.distro.conectiva") by oss.sgi.com with ESMTP
	id <S553672AbRAPGLU>; Mon, 15 Jan 2001 22:11:20 -0800
Received: (ralf@lappi.waldorf-gmbh.de) by bacchus.dhis.org
	id <S868141AbRAPGK3>; Tue, 16 Jan 2001 04:10:29 -0200
Date:	Tue, 16 Jan 2001 04:10:29 -0200
From:	Ralf Baechle <ralf@oss.sgi.com>
To:	Predrag Malicevic <pmalic@blic.net>
Cc:	<linux-mips@oss.sgi.com>
Subject: Re: O200 problem...
Message-ID: <20010116041028.B2068@bacchus.dhis.org>
References: <20010109004138.A12181@bacchus.dhis.org> <Pine.LNX.4.30.0101121507090.13361-100000@quake.blic.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.30.0101121507090.13361-100000@quake.blic.net>; from pmalic@blic.net on Fri, Jan 12, 2001 at 03:20:25PM +0100
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Fri, Jan 12, 2001 at 03:20:25PM +0100, Predrag Malicevic wrote:

> > Thanks for sending the oops message; however without additional data
> > provided I can't use it.  Can you please point please put the kernel image
> > that resulted in the oops online?
> 
> http://lothar.penguinpowered.com/o200.tar.gz
> 
> You'll find everything in the archive: vmlinux, System.map, kernel
> configuration file and a new session log with 'oops messages'.

I just examined your crash data; it's not obvious why what is causing the
DBE exception that is making your kernel die.  It seems to happen in
the SCSI code; I wonder if any of the devices you have on the SCSI bus
especially on the second hostadapter is making the Qlogic driver go nuts.

Can you retry your kernel with devices from this bus removed?

Thanks,

  Ralf
