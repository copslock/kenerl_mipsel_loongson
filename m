Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fAQEmA206081
	for linux-mips-outgoing; Mon, 26 Nov 2001 06:48:10 -0800
Received: from dea.linux-mips.net (localhost [127.0.0.1])
	by oss.sgi.com (8.11.2/8.11.3) with ESMTP id fAQEm7o06078
	for <linux-mips@oss.sgi.com>; Mon, 26 Nov 2001 06:48:07 -0800
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.1/8.11.1) id fAQDm4R15454;
	Tue, 27 Nov 2001 00:48:04 +1100
Date: Tue, 27 Nov 2001 00:48:04 +1100
From: Ralf Baechle <ralf@oss.sgi.com>
To: Andre.Messerschmidt@infineon.com
Cc: linux-mips@oss.sgi.com
Subject: Re: Cross Compiler again
Message-ID: <20011127004804.A15327@dea.linux-mips.net>
References: <86048F07C015D311864100902760F1DD01B5E418@dlfw003a.dus.infineon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <86048F07C015D311864100902760F1DD01B5E418@dlfw003a.dus.infineon.com>; from Andre.Messerschmidt@infineon.com on Mon, Nov 26, 2001 at 02:38:39PM +0100
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Mon, Nov 26, 2001 at 02:38:39PM +0100, Andre.Messerschmidt@infineon.com wrote:

> > Shit in, shit out.  You must be invoking the compiler with some option for
> > GP relative optimization.  Won't work.
> > 
> A typical gcc call is like this:
> gcc -Wall -Wstrict-prototypes -O2 -mno-abicalls -fno-pic -mcpu=r4000 -D_32_
> -mips2 -Wa,--trap -pipe -c foo.c -o foo.o
> 
> Is there any option missing that might me defaulting to such an
> optimization?

-G 0.

> I have played with the different -O# options without success.

What compiler are you using?  All compilers I've ever released did default
to -G 0.

  Ralf
