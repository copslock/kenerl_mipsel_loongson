Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g2PKa1027796
	for linux-mips-outgoing; Mon, 25 Mar 2002 12:36:01 -0800
Received: from coplin09.mips.com ([80.63.7.130])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g2PKZvq27792
	for <linux-mips@oss.sgi.com>; Mon, 25 Mar 2002 12:35:57 -0800
Received: (from hartvige@localhost)
	by coplin09.mips.com (8.11.6/8.11.6) id g2PKbTQ28092
	for linux-mips@oss.sgi.com; Mon, 25 Mar 2002 21:37:29 +0100
From: Hartvig Ekner <hartvige@mips.com>
Message-Id: <200203252037.g2PKbTQ28092@coplin09.mips.com>
Subject: Re: Mips16 toolchain?
To: linux-mips@oss.sgi.com
Date: Mon, 25 Mar 2002 21:37:29 +0100 (CET)
In-Reply-To: <no.id> from "Dominic Sweetman" at Mar 25, 2002 06:13:18 PM
X-Mailer: ELM [version 2.5 PL5]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Dominic Sweetman writes:
> 
> We are also developing a compiler from the same source tree, but
> configured for Linux.  That was the compiler we'll be looking for
> beta-testers for in the next couple of months.
> 
> If you want to be able to build MIPS16 applications and then run them
> on Linux, this is more challenging.  You have to build everything
> static: then it works mostly, and some people at MIPS have built and
> run some programs.

I have built glibc in a static and non-PIC version to allow linking against
M16 user apps (non-PIC required because current Linux compilers cannot 
generate M16 PIC code). It worked fine using the Algo 5.0 Beta for Linux. 
I successfully built a few applications (ones which only required libc).

It won't be really useful until somebody builds a complete library set
which is static and non-PIC, or PIC support gets included in the M16
code generator.

/Hartvig
