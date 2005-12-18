Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 18 Dec 2005 13:40:01 +0000 (GMT)
Received: from mxfw3.q-free.com ([62.92.116.8]:21776 "HELO mxfw3.q-free.com")
	by ftp.linux-mips.org with SMTP id S3458391AbVLRNjm convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sun, 18 Dec 2005 13:39:42 +0000
Received: from hurricane.q-free.com ([192.168.4.14])
 by mxfw3.q-free.com (NAVGW 2.5.1.2) with SMTP id M2005121814404221697
 for <linux-mips@linux-mips.org>; Sun, 18 Dec 2005 14:40:42 +0100
Received: from oyvindk.q-free.com (h192-168-2-34.q-free.com [192.168.2.34] (may be forged))
	by hurricane.q-free.com (8.12.8/8.12.8) with ESMTP id jBIDeTqT031375
	for <linux-mips@linux-mips.org>; Sun, 18 Dec 2005 14:40:29 +0100
From:	=?iso-8859-1?q?=D8yvind_Kristiansen?= 
	<oyvind.kristiansen@q-free.com> (by way of
	=?iso-8859-1?q?=D8yvind_Kristiansen?= <oyvind.kristiansen@q-free.com>)
Subject: Re: 2.4.22 Kernel Build Error
Date:	Sun, 18 Dec 2005 14:40:29 +0100
User-Agent: KMail/1.6.2
To:	linux-mips@linux-mips.org
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Message-Id: <200512181440.29297.oyvind.kristiansen@q-free.com>
Return-Path: <oyvind.kristiansen@q-free.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9689
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: oyvind.kristiansen@q-free.com
Precedence: bulk
X-list: linux-mips

Hi!
Don't expect the Linux/MIPS port to be too stable. We have used it for some
time, and personally I would not recommend most of the 2.4.x kernels. With
the latest kernels, it seem they have improved greatly. 

Best Regards,
Øyvind Kristiansen

On Sunday 18 December 2005 06:48, you wrote:
> I repated the build process with the kernel versions 2.4.25 and 2.4.27
> and I got the same errors. I downloaded these kernels from
> linux-mips.org through CVS.
>
> Can someone please explain me the mistake that I seem to be
> committing? I'm a newbie to Linux/MIPS arena and so find these errors
> very confusing.
>
> Thanks,
> Shireesh
>
> > On 12/16/05, Shireesh Annam <annamshr@gmail.com> wrote:
> > > I'm now using the SDE-Linux 5.03.06 for the big-endian target. I
> > > started the 2.4.22 kernel build process, but soon I get the following
> > > compile error.
> > >
> > > **********
> > > make[2]: Entering directory `/root/linux/arch/mips/mm'
> > > mips-linux-gcc -D__KERNEL__ -I/root/linux/include -Wall
> > > -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing
> > > -fno-common -fomit-frame-pointer -I /root/linux/include/asm/gcc -G 0
> > > -mno-abicalls -fno-pic -pipe  -mabi=32 -mcpu=r4600 -mips2 -Wa,--trap
> > > -nostdinc -iwithprefix include -DKBUILD_BASENAME=sc_ip22  -c -o
> > > sc-ip22.o sc-ip22.c
> > > {standard input}: Assembler messages:
> > > {standard input}:126: Error: Number (0x9000000080000000) larger than 32
> > > bits {standard input}:148: Error: Number (0x9000000080000000) larger
> > > than 32 bits {standard input}:168: Error: Number (0x9000000080000000)
> > > larger than 32 bits make[2]: *** [sc-ip22.o] Error 1
> > > make[2]: Leaving directory `/root/linux/arch/mips/mm'
> > > make[1]: *** [first_rule] Error 2
> > > make[1]: Leaving directory `/root/linux/arch/mips/mm'
> > > make: *** [_dir_arch/mips/mm] Error 2
> > >
> > > **********
> > >
> > > I'm not able to understand these error messages. Could someone throiw
> > > some light on this issue? Is this because of the toolchain that I'm
> > > using for building the kernel?
> > >
> > > Thanks,
> > > Shireesh
> > >
> > > On 12/15/05, Ralf Baechle <ralf@linux-mips.org> wrote:
> > > > You're trying to build a stoneage kernel with a much newer compiler -
> > > > SDE 6 uses gcc 3.4 - which doesn't work.  Use an older compiler such
> > > > as gcc <= 3.3.x.  SDE 5.x contains gcc 2.96 btw.
> > > >
> > > >   Ralf

--
Oyvind Kristiansen
R&D Engineer

Q-Free ASA
P.O.Box 3974 Leangen
7443 Trondheim
Norway

E-Mail: oyvind.kristiansen@q-free.com
WWW: http://www.q-free.com
