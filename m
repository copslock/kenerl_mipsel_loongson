Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 30 Sep 2003 20:15:02 +0100 (BST)
Received: from avtrex.com ([IPv6:::ffff:216.102.217.178]:49067 "EHLO
	avtrex.com") by linux-mips.org with ESMTP id <S8225483AbTI3TPA>;
	Tue, 30 Sep 2003 20:15:00 +0100
Received: from avtrex.com ([192.168.0.111] RDNS failed) by avtrex.com with Microsoft SMTPSVC(5.0.2195.6713);
	 Tue, 30 Sep 2003 12:14:55 -0700
Message-ID: <3F79D62F.5070901@avtrex.com>
Date: Tue, 30 Sep 2003 12:14:55 -0700
From: David Daney <ddaney@avtrex.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021130
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Sudeep Kottilingal <skottilingal@kinetowireless.com>
CC: linux-mips@linux-mips.org,
	Joe Baranowski <jbaranowski@kinetowireless.com>
Subject: Re: Backtrace capability
References: <2EEAE99C5AA0B14BB6A0BBB4ABF8D1E117960E@blunote.bluzona.com>
In-Reply-To: <2EEAE99C5AA0B14BB6A0BBB4ABF8D1E117960E@blunote.bluzona.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 30 Sep 2003 19:14:55.0675 (UTC) FILETIME=[21F820B0:01C38787]
Return-Path: <ddaney@avtrex.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3336
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@avtrex.com
Precedence: bulk
X-list: linux-mips

Sudeep Kottilingal wrote:

> Hi all,
>
> I am trying to debug some SIGSEGV when I leave my system ON for a few 
> days. At the time of the
>
> Crash I am not able to get a nice back-trace/stack trace yet. (I do 
> not see the execinfo.h file on my uclibc toolchain
>
> Which implies its not supported yet on my toolchain release).
>
> *Has anyone had success in incorporating backtrace capability into a 
> uclibc binary yet …?*
>
> *If your answer is yes, could u give me some pointers on how to do it 
> and set it up ..?*
>
> *If your answer is no is there any other alternative set up to get 
> more information.*
>
> I do not run an ICD or ICE on my board. Neither do I have a serial 
> console. My console is redirected via Telnet.
>
> Currently I am running the application which crashes on the linux PC 
> through totalview debugger.
>
> Waiting for it to crash.
>
> sudeep
>
I hacked together a backtrace that you may be able to adapt. It was 
originally for gcj, but we use several variations for other things as 
well. It kind of relies on an o32 ABI calling convention.

The code is in this mail message:

http://gcc.gnu.org/ml/java-patches/2003-q3/msg00584.html

Look at:

libjava/sysdep/mips/mipsel-backtracer.c
libjava/sysdep/mips/mipsel-backtracer.h
libjava/sysdep/mips/mipsel-bthelper.S

David Daney
