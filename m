Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fB7FuSr12352
	for linux-mips-outgoing; Fri, 7 Dec 2001 07:56:28 -0800
Received: from defiant.informatik.uni-bremen.de (defiant.informatik.uni-bremen.de [134.102.204.163])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id fB7FuPo12349
	for <linux-mips@oss.sgi.com>; Fri, 7 Dec 2001 07:56:25 -0800
Received: (from cbusse@localhost)
	by defiant.informatik.uni-bremen.de (8.11.6/8.11.6/SuSE Linux 0.5) id fB7F2bF03203;
	Fri, 7 Dec 2001 16:02:37 +0100
Date: Fri, 7 Dec 2001 16:02:37 +0100
From: carsten busse <cbusse@defiant.informatik.uni-bremen.de>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linux-mips@oss.sgi.com
Subject: Re: Linux on Indy, kernel compile (2.4.14) and xfree ...
Message-ID: <20011207160237.A2909@defiant.informatik.uni-bremen.de>
References: <20011206182620.A16589@defiant.informatik.uni-bremen.de> <Pine.GSO.4.21.0112061848470.20870-200000@mullein.sonytel.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.21.0112061848470.20870-200000@mullein.sonytel.be>
User-Agent: Mutt/1.3.22.1i
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Thu, Dec 06, 2001 at 06:50:04PM +0100, Geert Uytterhoeven wrote:
> See attached email (from last Oct).
> 
> Gr{oetje,eeting}s,
> 
> 						Geert
> 
thanks geert, this already helped a lot, but know i don't get any further. may be you have another solution for this in your pocket?

in kernel/exit.c, there is a function defined called "release_task", which is used by arch/mips/kernel/irixsig.c .

the problem is, that the symbol is not exported. i inserted an "EXPORT_SYMBOL(release_task);" into exit.c after the function, and inserted exit.o in the export-objs list in the kernel/Makefile, and "extern static void release_task(...)" into arch/mips/kernel/irixsig.c

the problem is, that the linker is still unable to find the symbol when linking asm/mips/kernel/kernel.o :(

does anyone know, what i did wrong? its a regular misunderstanding in using the export-objs list by me, i think.
i already tried putting exit.o at the beginning and at the end of the list in kernel/Makefile, i didn't removed it from the obj-y list

carsten
