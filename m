Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 04 Jan 2008 16:45:26 +0000 (GMT)
Received: from fig.raritan.com ([12.144.63.197]:50919 "EHLO fig.raritan.com")
	by ftp.linux-mips.org with ESMTP id S20023566AbYADQpR (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 4 Jan 2008 16:45:17 +0000
Received: from [192.168.32.225] ([192.168.32.225]) by fig.raritan.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.1830);
	 Fri, 4 Jan 2008 11:45:10 -0500
Message-ID: <477E6296.7090605@raritan.com>
Date:	Fri, 04 Jan 2008 11:45:10 -0500
From:	Gregor Waltz <gregor.waltz@raritan.com>
User-Agent: Thunderbird 1.5.0.10 (X11/20070403)
MIME-Version: 1.0
To:	linux-mips@linux-mips.org
Subject: Toshiba JMR 3927 working setup?
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 04 Jan 2008 16:45:10.0813 (UTC) FILETIME=[2BBFBCD0:01C84EF1]
Return-Path: <Gregor.Waltz@raritan.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17911
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: gregor.waltz@raritan.com
Precedence: bulk
X-list: linux-mips

I have been working on a JMR 3927 based system for a number of years. 
For all of that time, we have been running:
binutils 2.11.90.0.1
gcc 2.95.3
glibc 2.2.1
linux 2.4.12


We want to update to a 2.6 kernel, recent build tools, and saner system 
libraries. Although, it seems that the JMR 3927 is still technically 
supported, I have not found any info on whether anybody is still running 
Linux on it and what combination of software they are using. Any idea?
Is there a combination of software versions that are known to work on 
this hardware?


I have used crosstool 0.43 to build:
binutils 2.15
gcc 3.4.5
glibc 2.3.6

I cannot get these kernels to build:
linux-2.6.13
linux-2.6.15
linux-2.6.16.57
linux-2.6.17.14
linux-2.6.9

My colleague and I have built these:
linux-2.6.21.7
linux-2.6.23.9
linux-2.6.23.12

However, they all yield a TLBL exception similar to the following:

Exception! EPC=80056eb4 CAUSE=30000008(TLBL)
80056eb4 8ce4000c lw      a0,12(a3)                         # 0xc

Each build has different exception values. The values are the same each 
attempt with the same build.

Is this a problem in the kernel code or the build tools?
Any ideas on how to make it run?

Using the recently built tools, I am currently trying to build the 
2.4.12 kernel that is known to work, which is proving difficult. If I 
can get it to build, I am hoping to see whether the tools are able to 
build a functioning kernel.

Thanks
