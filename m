Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f6HIAxj25818
	for linux-mips-outgoing; Tue, 17 Jul 2001 11:10:59 -0700
Received: from noose.gt.owl.de (postfix@noose.gt.owl.de [62.52.19.4])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f6HIAwV25815
	for <linux-mips@oss.sgi.com>; Tue, 17 Jul 2001 11:10:58 -0700
Received: by noose.gt.owl.de (Postfix, from userid 10)
	id D212D801; Tue, 17 Jul 2001 20:10:56 +0200 (CEST)
Received: by paradigm.rfc822.org (Postfix, from userid 1000)
	id 65CD14626; Tue, 17 Jul 2001 20:11:14 +0200 (CEST)
Date: Tue, 17 Jul 2001 20:11:14 +0200
From: Florian Lohoff <flo@rfc822.org>
To: SGI MIPS list <linux-mips@oss.sgi.com>,
   Debian MIPS list <debian-mips@lists.debian.org>
Subject: Re: Oops in serial driver
Message-ID: <20010717201114.C5552@paradigm.rfc822.org>
References: <20010717181156.A32024@lug-owl.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.17i
In-Reply-To: <20010717181156.A32024@lug-owl.de>; from jbglaw@lug-owl.de on Tue, Jul 17, 2001 at 06:11:56PM +0200
Organization: rfc822 - pure communication
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Tue, Jul 17, 2001 at 06:11:56PM +0200, Jan-Benedict Glaw wrote:
> Hi!
> I'm currently testing with current CVS kernels and facing some bad
> Oopses in DECstation's serial driver:-( Top fafourites are rs_interrupt
> and zs_channels. Does anybody already have a fix for this? I fear
> noting down all the Oops from framebuffer, as it is for obvious reason
> not written to serial console...

Loop up the assembly code in the functions and check which register
they attempt to use. You wont need to write down all registers.

It would be interesting under which occurencies the oops happens - When
running on fb why do you use the serials ? 

Flo
-- 
Florian Lohoff                  flo@rfc822.org             +49-5201-669912
     Why is it called "common sense" when nobody seems to have any?
