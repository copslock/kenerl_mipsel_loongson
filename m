Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f2LHdnA02642
	for linux-mips-outgoing; Wed, 21 Mar 2001 09:39:49 -0800
Received: from nilpferd.fachschaften.tu-muenchen.de (nilpferd.fachschaften.tu-muenchen.de [129.187.176.79])
	by oss.sgi.com (8.11.3/8.11.3) with SMTP id f2LHdmM02639
	for <linux-mips@oss.sgi.com>; Wed, 21 Mar 2001 09:39:48 -0800
Received: (qmail 8747 invoked from network); 21 Mar 2001 17:39:46 -0000
Received: from gaia.fachschaften.tu-muenchen.de (129.187.176.73)
  by nilpferd.fachschaften.tu-muenchen.de with SMTP; 21 Mar 2001 17:39:46 -0000
Date: Wed, 21 Mar 2001 18:39:48 +0100 (CET)
From: Adrian Bunk <bunk@fs.tum.de>
X-X-Sender:  <bunk@gaia.fachschaften.tu-muenchen.de>
To: <linux-mips@oss.sgi.com>
Subject: Re: Compile error with current CVS kernel
In-Reply-To: <Pine.NEB.4.33.0103122252170.23935-100000@mimas.fachschaften.tu-muenchen.de>
Message-ID: <Pine.NEB.4.33.0103211837550.22248-100000@gaia.fachschaften.tu-muenchen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Hi Ralf,

the latest CVS kernel still doesn't build, but the error message has
changed:

<--  snip  -->

...
mipsel-linux-nm vmlinux | grep -v '\(compiled\)\|\(\.o$\)\|\( [aUw]
\)\|\(\.\.ng$\)\|\(LASH[RL]DI\)' | sort > System.map
make[1]: Entering directory `/home/bunk/Ringo/linux/arch/mips/boot'
gcc -o elf2ecoff elf2ecoff.c
./elf2ecoff /home/bunk/Ringo/linux/vmlinux vmlinux.ecoff -a
Sections ordering prevents a.out conversion.
make[1]: *** [vmlinux.ecoff] Error 1
make[1]: Leaving directory `/home/bunk/Ringo/linux/arch/mips/boot'
make: *** [boot] Error 2

<--  snip  -->

cu
Adrian

-- 

Nicht weil die Dinge schwierig sind wagen wir sie nicht,
sondern weil wir sie nicht wagen sind sie schwierig.
