Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fB8LPKr18869
	for linux-mips-outgoing; Sat, 8 Dec 2001 13:25:20 -0800
Received: from gandalf.physik.uni-konstanz.de (gandalf.physik.uni-konstanz.de [134.34.144.69])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id fB8LPIo18866
	for <linux-mips@oss.sgi.com>; Sat, 8 Dec 2001 13:25:18 -0800
Received: from galadriel.physik.uni-konstanz.de [134.34.144.79] (8)
	by gandalf.physik.uni-konstanz.de with esmtp (Exim 3.12 #1 (Debian))
	id 16Co25-0005Lw-00; Sat, 08 Dec 2001 21:25:13 +0100
Received: from agx by galadriel.physik.uni-konstanz.de with local (Exim 3.12 #1 (Debian))
	id 16Co0r-0003I0-00; Sat, 08 Dec 2001 21:23:57 +0100
Date: Sat, 8 Dec 2001 21:23:57 +0100
From: Guido Guenther <agx@debian.org>
To: Andreas Jaeger <aj@suse.de>
Cc: Daniel Jacobowitz <dan@debian.org>, linux-mips@oss.sgi.com
Subject: Re: understanding elf_machine_load_address
Message-ID: <20011208212357.A12633@galadriel.physik.uni-konstanz.de>
Mail-Followup-To: Andreas Jaeger <aj@suse.de>,
	Daniel Jacobowitz <dan@debian.org>, linux-mips@oss.sgi.com
References: <20011208141141.GA11437@bogon.ms20.nix> <u8n10tg2oy.fsf@gromit.moeb> <20011208114713.A20432@nevyn.them.org> <u8g06lfqhj.fsf@gromit.moeb>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <u8g06lfqhj.fsf@gromit.moeb>; from aj@suse.de on Sat, Dec 08, 2001 at 08:42:32PM +0100
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Sat, Dec 08, 2001 at 08:42:32PM +0100, Andreas Jaeger wrote:
[..snip..] 
> That's what I've asked myself also when fixing the dynamic linker.
> But Ralf convinced me that $31 will get filled in (and I verified that
> it did) - otherwise the dynamic linker would not work on any system at
> all.
> 
> But it might be worth checking if Guido notices a problem.
Not in elf_machine_load_address but in _dl_runtime_resolve(see my other
posting), I just came across it when looking at dl-machine.h.
 -- Guido
