Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f3O7QCo01960
	for linux-mips-outgoing; Tue, 24 Apr 2001 00:26:12 -0700
Received: from mailgw3.netvision.net.il (mailgw3.netvision.net.il [194.90.1.11])
	by oss.sgi.com (8.11.3/8.11.3) with ESMTP id f3O7Q6M01956;
	Tue, 24 Apr 2001 00:26:06 -0700
Received: from jungo.com ([194.90.113.98])
	by mailgw3.netvision.net.il (8.9.3/8.9.3) with ESMTP id KAA09906;
	Tue, 24 Apr 2001 10:24:30 +0300 (IDT)
Message-ID: <3AE52A87.9050403@jungo.com>
Date: Tue, 24 Apr 2001 10:25:59 +0300
From: Michael Shmulevich <michaels@jungo.com>
Organization: Jungo LTD
User-Agent: Mozilla/5.0 (X11; U; Linux 2.2.17-21mdk i686; en-US; 0.8.1) Gecko/20010326
X-Accept-Language: en
MIME-Version: 1.0
To: Ralf Baechle <ralf@oss.sgi.com>
CC: Linux/MIPS <linux-mips@oss.sgi.com>, FR Linux/MIPS <linux-mips@fnet.fr>
Subject: Re: ld.so-1.9.x for mips
References: <3AE44D0A.9080003@jungo.com> <20010423170302.E4623@bacchus.dhis.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Ralf,


> While this package surprisingly compiles for MIPS it shouldn't be used
> ever for anything on Linux/MIPS as we don't have libc4 / libc 5. 

You're right about Libc5, but I need it for uClibc. Besides it 
surprisingly does not compile for MIPS, as it misses many parts of MIPS 
assembly code, usually found under sysdep part of ld.so.

> The equivalent for libc6 aka glibc 2 is part of glibc.

The whole idea behind uClibc was to get rid of that huge chunk of 
memory-wasting package, and I do not mean to use any part of it.
Unless you can tell me how ld.so of glibc can be compiled standalone :-)



> Florian, can you remove this package from Debian/MIPS?

Florian, please, if you still have sources, can you tell me where they are?


Sincerely yours,
Michael Shmulevich
______________________________________
Software Developer
Jungo - R&D
email: michaels@jungo.com
web: http://www.jungo.com
Phone: 1-877-514-0537(USA)  +972-9-8859365(Worldwide) ext. 233
Fax:   1-877-514-0538(USA)  +972-9-8859366(Worldwide)
