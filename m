Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f6PDw9M06888
	for linux-mips-outgoing; Wed, 25 Jul 2001 06:58:09 -0700
Received: from lntex.lineo.com ([38.211.144.13])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f6PDw5O06879;
	Wed, 25 Jul 2001 06:58:06 -0700
Received: from lineo.com ([38.211.144.16])
          by lntex.lineo.com (Lotus Domino Release 5.0.8)
          with ESMTP id 2001072508575162:55 ;
          Wed, 25 Jul 2001 08:57:51 -0500 
Message-ID: <3B5ED17F.6D50331F@lineo.com>
Date: Wed, 25 Jul 2001 15:02:39 +0100
From: Ian Soanes <ians@lineo.com>
Organization: Lineo UK
X-Accept-Language: en
MIME-Version: 1.0
To: Andre.Messerschmidt@infineon.com
CC: ralf@oss.sgi.com, linux-mips@oss.sgi.com
Subject: Re: AW: GCC and Modules
References: <86048F07C015D311864100902760F1DDFF0016@dlfw003a.dus.infineon.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=us-ascii
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Andre.Messerschmidt@infineon.com wrote:
> 
> Hi.
> 
> > He's refering to the last official release of binutils which indeed wasn't
> > usable for modutils.
> >
> I compiled the tools by myself but the problems remain.
> My module should only print a message using printk, but I can't get it to
> run.
> 
> Here are my results:
> > insmod module.o
> insmod: unresolved symbol _gp_disp
> 
> Module compiled with -mno-abicalls and -no-half-pic (as someone in the
> archives mentioned)
> > insmod module.o
> Warning: unhandled reloc 9
> insmod: Unhandled relocation of type 9 for
> Warning: unhandled reloc 11
> insmod: Unhandled relocation of type 11 for printk
> Warning: unhandled reloc 9
> insmod: Unhandled relocation of type 9 for
> Warning: unhandled reloc 11
> insmod: Unhandled relocation of type 11 for printk
> 
> Does anybody know what the problem is?
> 

Hi Andre,

This may be a little out of date, but compiling with the module with
-mlong-calls worked for me when I had similar problems loading modules a
while back. Relinking the module with 'ld -r -o new_mod.o orig_mod.o'
was useful too ...it worked around some 'exceeds local_symtab_size'
messages.

At the time I was using modutils 2.4.5 and an older version of binutils
(sorry I'm not near the relevant box to check exactly which version), so
maybe some of this is not relevant any more.

Hope this helps in some way,
Ian
