Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fASJLZn01150
	for linux-mips-outgoing; Wed, 28 Nov 2001 11:21:35 -0800
Received: from nevyn.them.org (mail@NEVYN.RES.CMU.EDU [128.2.145.6])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id fASJLWo01146
	for <linux-mips@oss.sgi.com>; Wed, 28 Nov 2001 11:21:33 -0800
Received: from drow by nevyn.them.org with local (Exim 3.32 #1 (Debian))
	id 1699Kf-00076I-00; Wed, 28 Nov 2001 13:21:17 -0500
Date: Wed, 28 Nov 2001 13:21:17 -0500
From: Daniel Jacobowitz <dan@debian.org>
To: "TWEDE,ROGER (HP-Boise,ex1)" <roger_twede@hp.com>
Cc: Linux/MIPS Development <linux-mips@oss.sgi.com>
Subject: Re: RedHat 7.1 cross toolchain kernel build problem
Message-ID: <20011128132117.A27181@nevyn.them.org>
References: <CBD6266EA291D5118144009027AA63353F9275@xboi05.boi.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CBD6266EA291D5118144009027AA63353F9275@xboi05.boi.hp.com>
User-Agent: Mutt/1.3.23i
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Wed, Nov 28, 2001 at 01:06:00PM -0500, TWEDE,ROGER (HP-Boise,ex1) wrote:
> Does anyone have any ideas why the i386->mipsel cross toolchain at
> oss.sgi.com:/pub/linux/redhat/7.1/RPMS/i386/toolchain* fails to build
> vgacon.o in the kernel's drivers/video directory?
> 
> 
> I get the following errors from the assembler:
> {standard input}:4683: Error: expression too complex
> {standard input}:4683: Fatal error: internal Error, line 1980,
> ../../tools-20011020/gas/config/tc-mips.c
> make[3]: *** [vgacon.o] Error 1
> 
> Apparently the compiler has generated assembly which the assembler cannot
> handle.
> I compiled to a .s assembly file and line 4683 was simply 'sb $6,$5($3)'.

If you search the list archives, I've posted patches for this several
times.  It's a compiler bug but can be worked around in io.h.  $5($3)
is not a legal addressing mode.

-- 
Daniel Jacobowitz                           Carnegie Mellon University
MontaVista Software                         Debian GNU/Linux Developer
