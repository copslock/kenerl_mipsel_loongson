Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 28 Apr 2003 20:47:33 +0100 (BST)
Received: from il-la.la.idealab.com ([IPv6:::ffff:63.251.211.5]:14779 "HELO
	idealab.com") by linux-mips.org with SMTP id <S8225246AbTD1Trb>;
	Mon, 28 Apr 2003 20:47:31 +0100
Received: (qmail 2682 invoked by uid 6180); 28 Apr 2003 19:47:26 -0000
Date: Mon, 28 Apr 2003 12:47:26 -0700
From: Jeff Baitis <baitisj@evolution.com>
To: Gabor Kerenyi <wom@tateyama.hu>
Cc: linux-mips@linux-mips.org
Subject: Re: crosscompile doesn't work :(
Message-ID: <20030428124726.H30468@luca.pas.lab>
Reply-To: baitisj@evolution.com
References: <200304281825.09697.wom@tateyama.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200304281825.09697.wom@tateyama.hu>; from wom@tateyama.hu on Mon, Apr 28, 2003 at 06:25:09PM +0200
Return-Path: <baitisj@idealab.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-Spam-Checker-Version: SpamAssassin 2.50 (1.173-2003-02-20-exp)
X-archive-position: 2224
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: baitisj@evolution.com
Precedence: bulk
X-list: linux-mips

Gabor:

I just got binutils 2.12, gcc 3.2.3, and glibc 2.2.5 working on my Red Hat
Linux boxen, and I'm targeting mipsel-linux. If you would like the source /
binary RPMs to see what I did, let me know; maybe Alien can fix them up
for you.

I feel your pain concerning the cross compiling. I at first tried to install
GCC 3.2 everything to /opt/toolchains using --prefix and/or other options, but
it seemed like GCC was particularly upset with --prefix. I tried the gcc 3.2.3
source WITHOUT --prefix, and it seemed to configure itself properly and coexist
OK.

Best of luck!

-Jeff

On Mon, Apr 28, 2003 at 06:25:09PM +0200, Gabor Kerenyi wrote:
> hi!
> 
> I'm totally new to MIPS and the bigger trouble that I'm also
> new to cross compiling.
> I will get a little MIPS board with PCMCIA, USB, serial,
> Ethernet, 4Mb flash memory. I have to build a linux for it
> from scratch but I have never done cross compiling before.
> 
> I use debian (Woody) and I installed the toolchain package,
> configured for mipsel-linux, I built the binutils and gcc,
> (binutils 2.12, gcc 3.2.3)
> 
> I did:
> tpkg-make mipsel-linux
> cd binutils
> debuild
> debi
> 
> tpkg-install-libc mipsel-linux
> 
> cd ../gcc-3.2.3
> debuild
> debi
> 
> I can compile a simple c code, but I can't compile the kernel.
> I tried to compile 2.4.19 and I ran into trouble at the beginning:
> 
> the 'as' said that -mcpu option is not recognized. OK, I removed
> this option. Then everything seemed to be fine but when the 
> compilation arrived to the arch/mips directiory than I got the
> following error messages:
> 
> make[1]: Leaving directory `/usr/src/linux/arch/mips/math-emu'
> make CFLAGS="-D__KERNEL__ -I/usr/src/linux/include -Wall 
> -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing 
> -fno-common -fomit-frame-pointer -I /usr/src/linux/include/asm/gcc -G 
> 0 -mno-abicalls -fno-pic -pipe -mips2 -Wa,--trap " -C  arch/mips/sni
> make[1]: Entering directory `/usr/src/linux/arch/mips/sni'
> mipsel-linux-gcc -D__KERNEL__ -I/usr/src/linux/include -Wall 
> -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing 
> -fno-common -fomit-frame-pointer -I /usr/src/linux/include/asm/gcc -G 
> 0 -mno-abicalls -fno-pic -pipe -mips2 -Wa,--trap  -c int-handler.S -o 
> int-handler.o
> /usr/src/linux/include/asm/mipsregs.h: Assembler messages:
> /usr/src/linux/include/asm/mipsregs.h:562: Error: unrecognized opcode 
> `static inline void tlb_probe(void)'
> /usr/src/linux/include/asm/mipsregs.h:563: Warning: rest of line 
> ignored; first ignored character is `{'
> /usr/src/linux/include/asm/mipsregs.h:564: Error: unrecognized opcode 
> `__asm__ __volatile__('
> /usr/src/linux/include/asm/mipsregs.h:565: Warning: rest of line 
> ignored; first ignored character is `"'
> /usr/src/linux/include/asm/mipsregs.h:566: Warning: rest of line 
> ignored; first ignored character is `"'
> /usr/src/linux/include/asm/mipsregs.h:567: Warning: rest of line 
> ignored; first ignored character is `"'
> /usr/src/linux/include/asm/mipsregs.h:568: Warning: rest of line 
> ignored; first ignored character is `"'
> /usr/src/linux/include/asm/mipsregs.h:569: Warning: rest of line 
> ignored; first ignored character is `}'
> 
> The board chose was only a test bacause I don't know anything about
> the board I'm going to use. There is a nice Japanese page about it,
> but I can't read it.
> 
> http://www.tcs-8000.info/products/
> 
> Can anyone help? I have to bulid a complete little system in 4Mb 
> within a month.
> 
> I also tried to build the cross compile environment from the sources
> directly not using toolchain but I got much less success. it didn't
> compile at all (gcc).
> 
> Thanks a lot,
> 
> Gabor
> 
> 

-- 
         Jeffrey Baitis - Associate Software Engineer

                    Evolution Robotics, Inc.
                     130 West Union Street
                       Pasadena CA 91103

 tel: 626.535.2776  |  fax: 626.535.2777  |  baitisj@evolution.com 
