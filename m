Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f3P7TJL21802
	for linux-mips-outgoing; Wed, 25 Apr 2001 00:29:19 -0700
Received: from mailgw3.netvision.net.il (mailgw3.netvision.net.il [194.90.1.11])
	by oss.sgi.com (8.11.3/8.11.3) with ESMTP id f3P7TGM21799
	for <linux-mips@oss.sgi.com>; Wed, 25 Apr 2001 00:29:17 -0700
Received: from jungo.com ([194.90.113.98])
	by mailgw3.netvision.net.il (8.9.3/8.9.3) with ESMTP id KAA22321;
	Wed, 25 Apr 2001 10:27:29 +0300 (IDT)
Message-ID: <3AE67CBA.4060606@jungo.com>
Date: Wed, 25 Apr 2001 10:28:58 +0300
From: Michael Shmulevich <michaels@jungo.com>
Organization: Jungo LTD
User-Agent: Mozilla/5.0 (X11; U; Linux 2.2.17-21mdk i686; en-US; 0.8.1) Gecko/20010326
X-Accept-Language: en
MIME-Version: 1.0
To: FR Linux/MIPS <linux-mips@fnet.fr>, Linux/MIPS <linux-mips@oss.sgi.com>
Subject: usermode gdb / remote gdb
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Hi,

I am trying to configure gdb to debug usermode on my mips box. i have 
two choices: one is to use "native"-compiled gdb, ot remote debugging on 
x86 box via serial or IP.

Currently I have no luck making any of the two configurations.

For "native" gdb I try to
$ CC=mips-linux-gcc ./configure mips-linux
and eventually I get
configure: error: *** Gdb does not support host mips-mips-linux-gnu

For remote debugging, I use
$ ./configure --target=mips
which succeded, and I even am able to get cross 'mips-gdb' which 
understands mips executables. However, when trying to configure gdbserver,

$ cd gdb/gdbserver
$ ../../configure mips-linux
*** ./configure.in has no "per-host:" line.
*** Hmm, looks like this directory has been autoconfiscated.
*** Running the local configure script.
creating cache config.cache
checking host system type... mips-mips-linux-gnu
checking target system type... mips-mips-linux-gnu
checking build system type... mips-mips-linux-gnu
checking for a BSD compatible install... /usr/bin/install -c
configure: error: *** GDB remote does not support host mips-mips-linux-gnu

Too bad, have seen it before, so I just tried to

$ ../../configure --host=mips --target=mips
*** ./configure.in has no "per-host:" line.
*** Hmm, looks like this directory has been autoconfiscated.
*** Running the local configure script.
loading cache config.cache
checking host system type... mips-mips-elf
checking target system type... mips-mips-elf
checking build system type... mips-mips-elf
checking for a BSD compatible install... /usr/bin/install -c
configure: error: *** GDB remote does not support host mips-mips-elf

And the last try (like the one that worked before):

$ ../../configure --target=mips
Configuring for a i686-pc-linux-gnu host.
*** ./configure.in has no "per-host:" line.
*** Hmm, looks like this directory has been autoconfiscated.
*** Running the local configure script.
loading cache config.cache
checking host system type... i686-pc-linux-gnu
checking target system type... mips-mips-elf
checking build system type... i686-pc-linux-gnu
checking for a BSD compatible install... /usr/bin/install -c
updating cache config.cache
creating ./config.status
creating Makefile
linking ./../config/i386/xm-linux.h to xm.h
linking ./../config/mips/tm-embed.h to tm.h
linking ./../config/nm-empty.h to nm.h

which clearly misconfigured, because of host system type set to x86, and 
nm.h is pointing to nm-emty.h (?).

 From what I see, I cannot use neither mips-linux nor mips-elf for host 
specification. On the other hand, I have seen lately a lot of discussion 
for gdb support for MIPS (bot kernel and usermode).

I just wonder what I am missing from all this story.
Your help is greatly appreciated.

Sincerely yours,
Michael Shmulevich
______________________________________
Software Developer
Jungo - R&D
email: michaels@jungo.com
web: http://www.jungo.com
Phone: 1-877-514-0537(USA)  +972-9-8859365(Worldwide) ext. 233
Fax:   1-877-514-0538(USA)  +972-9-8859366(Worldwide)
