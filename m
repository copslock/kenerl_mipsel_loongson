Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 08 Jan 2008 23:55:15 +0000 (GMT)
Received: from fig.raritan.com ([12.144.63.197]:13453 "EHLO fig.raritan.com")
	by ftp.linux-mips.org with ESMTP id S20029183AbYAHXzG (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 8 Jan 2008 23:55:06 +0000
Received: from [10.0.0.150] ([74.46.20.65]) by fig.raritan.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.1830);
	 Tue, 8 Jan 2008 18:54:59 -0500
Message-ID: <47840D53.50009@raritan.com>
Date:	Tue, 08 Jan 2008 18:54:59 -0500
From:	Gregor Waltz <gregor.waltz@raritan.com>
User-Agent: Thunderbird 1.5.0.10 (X11/20070403)
MIME-Version: 1.0
To:	linux-mips@linux-mips.org
Subject: Re: Toshiba JMR 3927 working setup?
References: <477E6296.7090605@raritan.com> <20080105144535.GA12824@linux-mips.org>
In-Reply-To: <20080105144535.GA12824@linux-mips.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 08 Jan 2008 23:55:00.0037 (UTC) FILETIME=[E0FA0750:01C85251]
Return-Path: <Gregor.Waltz@raritan.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17959
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: gregor.waltz@raritan.com
Precedence: bulk
X-list: linux-mips

Ralf Baechle wrote:
> You may want to switch to a recent binutils like 2.18 and gcc 4.2.2.

Ralf, are you or anybody else using that combination for mips?

With which versions of glibc and glibc-linuxthreads?

I have been having a joyous time trying to build more recent tools.
I keep getting errors like the following when building glibc of any 
version (tried from 2.3.6 through 2.7):
sysdeps/unix/sysv/linux/waitid.c:51: error: memory input 6 is not 
directly addressable

I found a patch for that 
(http://sourceware.org/ml/crossgcc/2005-04/msg00208.html), but, after 
passing that file, it fails similarly on pread.c. It seems to be an 
issue with INLINE_SYSCALL, rather than the call sites, that appears to 
be related to later versions of gcc.

Later versions of glibc (2.7, 2.6...) fail at configure time with the 
error: "The mipsel is not supported."


So, what are the lastest versions of the build tools that people are 
using on mips?

Thanks
