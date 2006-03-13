Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 13 Mar 2006 20:59:35 +0000 (GMT)
Received: from fw-ca-1-hme0.vitesse.com ([64.215.88.90]:9830 "EHLO
	email.vitesse.com") by ftp.linux-mips.org with ESMTP
	id S8133814AbWCMU6o convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 13 Mar 2006 20:58:44 +0000
Received: from wilson.vitesse.com (wilson [10.9.72.71])
	by email.vitesse.com (8.11.0/8.11.0) with ESMTP id k2DL7a309963;
	Mon, 13 Mar 2006 13:07:37 -0800 (PST)
Received: from MX-COS.vsc.vitesse.com (mx-cs1 [10.9.72.41])
	by wilson.vitesse.com (8.11.6/8.11.6) with ESMTP id k2DL81b22590;
	Mon, 13 Mar 2006 14:08:01 -0700 (MST)
X-MimeOLE: Produced By Microsoft Exchange V6.0.6556.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: Cross compile kernel w/ buildroot toolchain
Date:	Mon, 13 Mar 2006 14:07:34 -0700
Message-ID: <389E6A416914954182ECDFCD844D8269434FC1@MX-COS.vsc.vitesse.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Cross compile kernel w/ buildroot toolchain
Thread-Index: AcZG4KOhV3wKmLqjTzKXVtkFbXC5TQAAEU1g
From:	"Kurt Schwemmer" <kurts@vitesse.com>
To:	"Ralf Baechle" <ralf@linux-mips.org>
Cc:	<linux-mips@linux-mips.org>
Return-Path: <kurts@vitesse.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10797
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kurts@vitesse.com
Precedence: bulk
X-list: linux-mips

I didn't touch any of the source yet. 

I'm downloading the 1/10/05 2.6.15 tarball (
ftp://ftp.linux-mips.org/pub/linux/mips/kernel/v2.6/linux-2.6.15.tar.gz
)now to see if that fixes things.

In response to Thiemo's message the error with (V=1) is:

make -f scripts/Makefile.build obj=arch/mips/kernel
  /klocal/buildroot/build_mipsel/staging_dir/bin/mipsel-linux-gcc
-Wp,-MD,arch/mips/kernel/.entry.o.d  -nostdinc -isystem
/klocal/buildroot/build_mipsel/staging_dir/bin-ccache/../lib/gcc/mipsel-
linux-uclibc/3.4.5/include -D__KERNEL__ -Iinclude  -D__ASSEMBLY__  -I
/usr/local/src/linux-2.6/include/asm/gcc -G 0 -mno-abicalls -fno-pic
-pipe  -finline-limit=100000 -mabi=32 -march=mips32r2 -Wa,-32
-Wa,-march=mips32r2 -Wa,-mips32r2 -Wa,--trap
-Iinclude/asm-mips/mach-mips -Iinclude/asm-mips/mach-generic -Wall
-Wstrict-prototypes -Wno-trigraphs -fno-strict-aliasing -fno-common
-ffreestanding -O2     -fomit-frame-pointer  -I
/usr/local/src/linux-2.6/include/asm/gcc -G 0 -mno-abicalls -fno-pic
-pipe  -finline-limit=100000 -mabi=32 -march=mips32r2 -Wa,-32
-Wa,-march=mips32r2 -Wa,-mips32r2 -Wa,--trap
-Iinclude/asm-mips/mach-mips -Iinclude/asm-mips/mach-generic    -c -o
arch/mips/kernel/entry.o arch/mips/kernel/entry.S
arch/mips/kernel/entry.S: Assembler messages:
arch/mips/kernel/entry.S:157: Error: opcode not supported on this
processor: mips32 (mips32) `jr.hb $31'
make[1]: *** [arch/mips/kernel/entry.o] Error 1
make: *** [arch/mips/kernel] Error 2

Also, assembler -v output:
GNU assembler version 2.16.1 (mipsel-linux-uclibc) using BFD version
2.16.1

Thanks,
Kurt Schwemmer

> -----Original Message-----
> From: Ralf Baechle [mailto:ralf@linux-mips.org] 
> Sent: Monday, March 13, 2006 1:57 PM
> To: Kurt Schwemmer
> Cc: linux-mips@linux-mips.org
> Subject: Re: Cross compile kernel w/ buildroot toolchain
> 
> On Mon, Mar 13, 2006 at 01:39:53PM -0700, Kurt Schwemmer wrote:
> 
> > I got 2.6.15 "a while back" (>1 month). 
> > 
> > I'll try getting the most recent source. Sorry, I avoided 
> this due to 
> > my company blocking rsync and thus making it a pain to get 
> the sources...
> 
> The reason your case is odd is that the kernel only uses a 
> single jr.hb instruction which is in the instruction_hazard() 
> macro in include/asm-mips/hazards.h.  This macro first of all 
> is a gcc inline assembler macro and also wraps the jr.hb 
> instruction between .set mips64r2 ... .set mips0, so you 
> should never ever get an error message.  And you're getting 
> an error message for entry.S, an assembler file.  Seems you 
> must have done some not so kosher changes to that tree?
> 
>   Ralf
> 
