Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f3ALlD017544
	for linux-mips-outgoing; Tue, 10 Apr 2001 14:47:13 -0700
Received: from cvsftp.cotw.com (cvsftp.cotw.com [208.242.241.39])
	by oss.sgi.com (8.11.3/8.11.3) with ESMTP id f3ALl9M17540;
	Tue, 10 Apr 2001 14:47:09 -0700
Received: from cotw.com (ptecdev3.inter.net [192.168.10.5])
	by cvsftp.cotw.com (8.9.3/8.9.3) with ESMTP id QAA24746;
	Tue, 10 Apr 2001 16:47:05 -0500
Message-ID: <3AD38E04.696F2085@cotw.com>
Date: Tue, 10 Apr 2001 15:49:40 -0700
From: Scott A McConnell <samcconn@cotw.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.16-3 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Ralf Baechle <ralf@oss.sgi.com>
CC: linux-mips@oss.sgi.com
Subject: Re: loadaddr
References: <3AD337DA.16570750@cotw.com> <20010410183854.C1932@bacchus.dhis.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Ralf Baechle wrote:

> On Tue, Apr 10, 2001 at 09:42:02AM -0700, Scott A McConnell wrote:
>
> > What am I doing that is causing the  leading ffffffff in the addresses?
>
> Everything right :-)
>
> 32-bit addresses on MIPS get sign extended into 64-bit addresses.  Binutils
> had related bugs; I assume you switched binutils versions between the
> two builds?

OK, I wasn't sure so I asked. Yes, I changed the tools.

I have been able to build a 2.4.2 kernel but I can't make it run.

I have also steped up to the latest kernel in cvs. Having a bit more trouble
with that:

mipsel-linux-gcc -I /opt/mips/linux-2.4.3/include/asm/gcc -D__KERNEL__
-I/opt/mips/linux-2.4.3/include -Wall -Wstrict-prototypes -O2
-fomit-frame-pointer  -G 0 -mno-abicalls -fno-pic -mcpu=r5000 -mips2
-Wa,--trap -pipe    -c -o vgacon.o vgacon.c
{standard input}: Assembler messages:
{standard input}:1978: Error: expression too complex
{standard input}:1978: Fatal error: internal Error, line 1823,
../../binutils-patched/gas/config/tc-mips.c
make[3]: *** [vgacon.o] Error 1
make[3]: Leaving directory `/opt/mips/linux-2.4.3/drivers/video'
make[2]: *** [first_rule] Error 2
make[2]: Leaving directory `/opt/mips/linux-2.4.3/drivers/video'
make[1]: *** [_subdir_video] Error 2
make[1]: Leaving directory `/opt/mips/linux-2.4.3/drivers'
make: *** [_dir_drivers] Error 2
