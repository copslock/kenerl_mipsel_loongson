Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f6PBP9w22235
	for linux-mips-outgoing; Wed, 25 Jul 2001 04:25:09 -0700
Received: from dea.waldorf-gmbh.de (u-138-18.karlsruhe.ipdial.viaginterkom.de [62.180.18.138])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f6PBP6O22221
	for <linux-mips@oss.sgi.com>; Wed, 25 Jul 2001 04:25:06 -0700
Received: (from ralf@localhost)
	by dea.waldorf-gmbh.de (8.11.1/8.11.1) id f6PBOt902987;
	Wed, 25 Jul 2001 13:24:55 +0200
Date: Wed, 25 Jul 2001 13:24:55 +0200
From: Ralf Baechle <ralf@oss.sgi.com>
To: Andre.Messerschmidt@infineon.com
Cc: linux-mips@oss.sgi.com
Subject: Re: GCC and Modules
Message-ID: <20010725132455.A2662@bacchus.dhis.org>
References: <86048F07C015D311864100902760F1DDFF0016@dlfw003a.dus.infineon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <86048F07C015D311864100902760F1DDFF0016@dlfw003a.dus.infineon.com>; from Andre.Messerschmidt@infineon.com on Wed, Jul 25, 2001 at 11:12:47AM +0200
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Wed, Jul 25, 2001 at 11:12:47AM +0200, Andre.Messerschmidt@infineon.com wrote:

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

-fno-pic you mean.  Half PIC is meaningless under Linux.

  Ralf
