Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f3PAW6A27603
	for linux-mips-outgoing; Wed, 25 Apr 2001 03:32:06 -0700
Received: from mailgw1.netvision.net.il (mailgw1.netvision.net.il [194.90.1.14])
	by oss.sgi.com (8.11.3/8.11.3) with ESMTP id f3PAW3M27600
	for <linux-mips@oss.sgi.com>; Wed, 25 Apr 2001 03:32:04 -0700
Received: from jungo.com ([194.90.113.98])
	by mailgw1.netvision.net.il (8.9.3/8.9.3) with ESMTP id NAA04139;
	Wed, 25 Apr 2001 13:31:53 +0300 (IDT)
Message-ID: <3AE6A795.1080004@jungo.com>
Date: Wed, 25 Apr 2001 13:31:49 +0300
From: Michael Shmulevich <michaels@jungo.com>
Organization: Jungo LTD
User-Agent: Mozilla/5.0 (X11; U; Linux 2.2.17-21mdk i686; en-US; 0.8.1) Gecko/20010326
X-Accept-Language: en
MIME-Version: 1.0
To: Ian Soanes <ians@lineo.com>, Linux/MIPS <linux-mips@oss.sgi.com>
Subject: Re: usermode gdb / remote gdb
References: <3AE67CBA.4060606@jungo.com> <3AE69AAA.76A20F08@lineo.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk



Ian Soanes wrote:


> The (host side) gdb I've been using was configured with ./configure
> --target=mipsel-linux-elf (my target is an IDT MIPS 79S334 evaluation
> board). I too am using an x86 host. I used a development version of
> gdb-5.0 (I found the 'official' 5.0 had problems with the
> add-symbol-file command that I use for kernel module debugging, and more
> importantly for you... breakpoints didn't work) These problems are gone
> in the later version.

To start with, mips-linux-elf is not supported by gdbserver either with 
out-of-the-box 5.0:

$ ../../configure --target=mips-linux-elf --host=mips-linux-elf
*** ./configure.in has no "per-host:" line.
*** Hmm, looks like this directory has been autoconfiscated.
*** Running the local configure script.
loading cache config.cache
checking host system type... mips-linux-elf
checking target system type... mips-linux-elf
checking build system type... mips-linux-elf
checking for a BSD compatible install... (cached) /usr/bin/install -c
configure: error: *** GDB remote does not support host mips-linux-elf

Can you tell me which sources do you use?

> Yesterday I got gdbserver working correctly on my target (over IP or
> serial). It's a combination of Martin Rivers' mips port and my 'fixes'.
> At this stage the build is hand cranked and neither of us have put it
> under the control of the gdb configuration files. However, we (lineo)
> will now start doing this.

Happy to hear that  you got working GDB. I hope to make one too. For 
this I need to know where to get the MIPS port and your patches.
Can you send them to me?

> I hope this helps in some way. Please let me know if there is anything I
> can help with. It might also be worth contacting Fabrice, as it sounds
> like he has a working gdb and gdbserver.

These are indeed good news.

Sincerely yours,
Michael Shmulevich
______________________________________
Software Developer
Jungo - R&D
email: michaels@jungo.com
web: http://www.jungo.com
Phone: 1-877-514-0537(USA)  +972-9-8859365(Worldwide) ext. 233
Fax:   1-877-514-0538(USA)  +972-9-8859366(Worldwide)
