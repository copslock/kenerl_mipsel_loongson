Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 13 Apr 2005 21:01:51 +0100 (BST)
Received: from mail.timesys.com ([IPv6:::ffff:65.117.135.102]:21346 "EHLO
	exchange.timesys.com") by linux-mips.org with ESMTP
	id <S8225936AbVDMUBg>; Wed, 13 Apr 2005 21:01:36 +0100
Received: from [192.168.2.27] ([192.168.2.27]) by exchange.timesys.com with Microsoft SMTPSVC(5.0.2195.6713);
	 Wed, 13 Apr 2005 15:57:02 -0400
Message-ID: <425D7A99.5040401@timesys.com>
Date:	Wed, 13 Apr 2005 16:01:29 -0400
From:	Greg Weeks <greg.weeks@timesys.com>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To:	Daniel Laird <danieljlaird@hotmail.com>
CC:	macro@linux-mips.org, libc-alpha@sources.redhat.com,
	linux-mips@linux-mips.org
Subject: Re: Building GLIBC 2.3.4 on MIPS
References: <BAY101-F3978081BDE57937C67314CDC340@phx.gbl>
In-Reply-To: <BAY101-F3978081BDE57937C67314CDC340@phx.gbl>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 13 Apr 2005 19:57:02.0812 (UTC) FILETIME=[F60061C0:01C54062]
Return-Path: <greg.weeks@timesys.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7723
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: greg.weeks@timesys.com
Precedence: bulk
X-list: linux-mips

Daniel Laird wrote:

> I have tried this with any number of patches you want to name
>
> I can do the following combo
> glibc-2.3.2
> glibc-linuxthreads-2.3.4
> kernel 2.6.11.6
> binutils-2.15.96
>
> It all works but glibc-2.3.3, 2.3.4, 2.3.5 all fail.  bits/syscalls.h 
> is not even generated.  I do not have the problem where it generated 
> wrongly it just does not get made on my system and also the wrong 
> flags are passed to the HOST compiler which requires patching.
>
> If anyone ever get glibc-2.3.4 and the rest working let me know 
> (please check that bits/syscall.h exists)

I've got glibc-2.3.3-200407050320 and gcc-3.4.1-20040715 building here. 
A number of patches of course. I remember the syscall thing was a pain.

Greg Weeks
