Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fARLqNq32235
	for linux-mips-outgoing; Tue, 27 Nov 2001 13:52:23 -0800
Received: from hell (buserror-extern.convergence.de [212.84.236.66])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id fARLqKo32232
	for <linux-mips@oss.sgi.com>; Tue, 27 Nov 2001 13:52:20 -0800
Received: from js by hell with local (Exim 3.33 #1 (Debian))
	id 168pDA-000204-00; Tue, 27 Nov 2001 21:52:12 +0100
Date: Tue, 27 Nov 2001 21:52:12 +0100
From: Johannes Stezenbach <js@convergence.de>
To: "H . J . Lu" <hjl@lucon.org>
Cc: linux-mips@oss.sgi.com
Subject: Re: The Linux binutils 2.11.92.0.12 is released.
Message-ID: <20011127215212.A7656@convergence.de>
Mail-Followup-To: Johannes Stezenbach <js@convergence.de>,
	"H . J . Lu" <hjl@lucon.org>, linux-mips@oss.sgi.com
References: <20011126212859.A17557@lucon.org> <20011127180022.A6897@convergence.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20011127180022.A6897@convergence.de>
User-Agent: Mutt/1.3.23i
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

I wrote:
> b) I still get the -march vs. -mipsN warings:
> 
> mipsel-linux-gcc -I /home/js/MIPS/kernel/build/linux-2.4.14-mips/include/asm/gcc -D__KERNEL__ -I/home/js/MIPS/kernel/build/linux-2.4.14-mips/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -G 0 -mno-abicalls -fno-pic -mips2 -Wa,-m4100,--trap -pipe    -fno-omit-frame-pointer -c -o sched.o sched.c
> Assembler messages:
> Warning: The -march option is incompatible to -mipsN and therefore ignored.

/me being stupid.
I forgot to apply the binutils-2.0.92.0.12/mips/binutils-mips-isa.patch.

With the patch, binutils works correctly.


Regards,
Johannes
