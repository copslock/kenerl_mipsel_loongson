Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f6LGHg424215
	for linux-mips-outgoing; Sat, 21 Jul 2001 09:17:42 -0700
Received: from fe040.worldonline.dk (fe040.worldonline.dk [212.54.64.205])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f6LGHeV24210
	for <linux-mips@oss.sgi.com>; Sat, 21 Jul 2001 09:17:41 -0700
Received: (qmail 5482 invoked by uid 0); 21 Jul 2001 16:17:34 -0000
Received: from 213.237.49.98.skovlyporten.dk (HELO tuxedo.skovlyporten.dk) (213.237.49.98)
  by fe040.worldonline.dk with SMTP; 21 Jul 2001 16:17:34 -0000
Received: by tuxedo.skovlyporten.dk (Postfix, from userid 501)
	id 063662608E; Sat, 21 Jul 2001 18:17:33 +0200 (CEST)
Date: Sat, 21 Jul 2001 18:17:33 +0200
From: Lars Munch Christensen <c948114@student.dtu.dk>
To: Ralf Baechle <ralf@oss.sgi.com>
Cc: Lars Munch Christensen <c948114@student.dtu.dk>, linux-mips@oss.sgi.com
Subject: Re: mips64 linker bug?
Message-ID: <20010721181733.A3591@tuxedo.skovlyporten.dk>
References: <20010721112715.C2335@tuxedo.skovlyporten.dk> <20010721172309.A25467@bacchus.dhis.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010721172309.A25467@bacchus.dhis.org>; from ralf@oss.sgi.com on Sat, Jul 21, 2001 at 05:23:09PM +0200
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Sat, Jul 21, 2001 at 05:23:09PM +0200, Ralf Baechle wrote:
> On Sat, Jul 21, 2001 at 11:27:15AM +0200, Lars Munch Christensen wrote:
> 
> > 0000000010000110 <$LM7>:
> >         return 1;
> >     10000110:   dfbf0000        0xdfbf0000
> >     10000114:   24020001        li      $v0,1
> >     10000118:   03e00008        jr      $ra
> >     1000011c:   67bd0010        0x67bd0010
> > 
> > 
> > When removing the static I get the correct address 100000f8 ?!?
> > 
> > Am I missing something.
> 
> Gas and ld of the published 64-bit binutils are entirely useless for 64-bit
> code.  Various people are working on fixing that but that takes time,
> especially the non-pic case is a bit hairy.
> 

Thanks...What should I do now? Change my code to mips32 or are there some
patches to binutils that I can use, to get it working?

Thanks for your help
Regards
Lars Munch
