Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fARJPsw29161
	for linux-mips-outgoing; Tue, 27 Nov 2001 11:25:54 -0800
Received: from ocean.lucon.org (c1473286-a.stcla1.sfba.home.com [24.176.137.160])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id fARJPqo29158
	for <linux-mips@oss.sgi.com>; Tue, 27 Nov 2001 11:25:52 -0800
Received: by ocean.lucon.org (Postfix, from userid 1000)
	id A935C125C8; Tue, 27 Nov 2001 10:25:50 -0800 (PST)
Date: Tue, 27 Nov 2001 10:25:50 -0800
From: "H . J . Lu" <hjl@lucon.org>
To: Johannes Stezenbach <js@convergence.de>
Cc: linux-mips@oss.sgi.com
Subject: Re: The Linux binutils 2.11.92.0.12 is released.
Message-ID: <20011127102550.A30681@lucon.org>
References: <20011126212859.A17557@lucon.org> <20011127180022.A6897@convergence.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20011127180022.A6897@convergence.de>; from js@convergence.de on Tue, Nov 27, 2001 at 06:00:22PM +0100
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Tue, Nov 27, 2001 at 06:00:22PM +0100, Johannes Stezenbach wrote:
> 
> b) I still get the -march vs. -mipsN warings:
> 
> mipsel-linux-gcc -I /home/js/MIPS/kernel/build/linux-2.4.14-mips/include/asm/gcc -D__KERNEL__ -I/home/js/MIPS/kernel/build/linux-2.4.14-mips/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -G 0 -mno-abicalls -fno-pic -mips2 -Wa,-m4100,--trap -pipe    -fno-omit-frame-pointer -c -o sched.o sched.c
> Assembler messages:
> Warning: The -march option is incompatible to -mipsN and therefore ignored.
> 

Please make sure binutils 2.11.92.0.12 is used. Please send me the
output of

# mipsel-linux-gcc -v -I /home/js/MIPS/kernel/build/linux-2.4.14-mips/include/asm/gcc -D__KERNEL__ -I/home/js/MIPS/kernel/build/linux-2.4.14-mips/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -G 0 -mno-abicalls -fno-pic -mips2 -Wa,-m4100,--trap -pipe    -fno-omit-frame-pointer -c -o sched.o sched.c

"-v" will tell me which gas you are using.

H.J.
