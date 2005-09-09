Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 09 Sep 2005 16:20:29 +0100 (BST)
Received: from adsl-67-116-42-147.dsl.sntc01.pacbell.net ([IPv6:::ffff:67.116.42.147]:49159
	"EHLO avtrex.com") by linux-mips.org with ESMTP id <S8225359AbVIIPUJ>;
	Fri, 9 Sep 2005 16:20:09 +0100
Received: from [192.168.7.26] ([192.168.7.3]) by avtrex.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Fri, 9 Sep 2005 08:20:03 -0700
Message-ID: <4321A823.8050703@avtrex.com>
Date:	Fri, 09 Sep 2005 08:20:03 -0700
From:	David Daney <ddaney@avtrex.com>
User-Agent: Mozilla Thunderbird 1.0.6-1.1.fc3 (X11/20050720)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To:	Matej Kupljen <matej.kupljen@ultra.si>
CC:	crossgcc@sources.redhat.com, linux-mips@linux-mips.org
Subject: Re: MIPS SF toolchain
References: <1126098584.12696.19.camel@localhost.localdomain>	 <431F0850.8090804@avtrex.com>	 <1126168866.25388.11.camel@orionlinux.starfleet.com>	 <1126179199.25389.20.camel@orionlinux.starfleet.com>	 <1126182122.25393.27.camel@orionlinux.starfleet.com>	 <432058C1.80106@avtrex.com> <1126248502.20058.5.camel@localhost.localdomain>
In-Reply-To: <1126248502.20058.5.camel@localhost.localdomain>
Content-Type: multipart/mixed;
 boundary="------------050704070601060306050104"
X-OriginalArrivalTime: 09 Sep 2005 15:20:03.0878 (UTC) FILETIME=[F3E50C60:01C5B551]
Return-Path: <ddaney@avtrex.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8912
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@avtrex.com
Precedence: bulk
X-list: linux-mips

This is a multi-part message in MIME format.
--------------050704070601060306050104
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Matej Kupljen wrote:
> Hi
> 
> 
>>>Can I just #ifdef this code if compiled for sf?
>>>
>>
>>I do have some patches for glibc to get rid of these in a soft float 
>>build.  
> 
> 
> Can I see these patches, please?
> (What is the #define for the FP?)
> 
> 
>>However as Ralf Baechle said in the other message, the kernel FP 
>>emulator works and is not that large of an overhead.
> 

Attached is the portions of my patches to glibc-2.3.3 that contain the 
setjump/longjump hacks.  There are other things in there as well, so you 
will have to pick and choose as to which parts you want.

I did this more as a proof of concept rather than the definitive answer. 
  There are still some FP instructions being generated but I have not 
tracked them down yet.

On my 2.4.29 based kernel (mipsel-linux) with glibc 2.3.3 and busybox 
1.00, I don't get the 'Algorithmics/MIPS FPU Emulator v1.5' message 
until I run ldconfig or ftp.  Most other programs don't seem to run any 
FP instructions.

> 
> I also removed the FP Emulator in the kernel, just to be sure that
> no SF ins are executed (I can send the patch to the list, but I know
> there has already been discussion about this).
> 
> IMHO, if we say that we have a SF toolchain then there MUST NOT
> BE any SF ins, otherwise we have a "semi soft float" toolchain.
> Don't you agree?

Of course I agree.

David Daney.

--------------050704070601060306050104
Content-Type: application/x-gzip;
 name="glibc-2.3.3.diff.gz"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="glibc-2.3.3.diff.gz"

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
--------------050704070601060306050104--
