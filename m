Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 20 Feb 2003 19:42:36 +0000 (GMT)
Received: from port48.ds1-vbr.adsl.cybercity.dk ([IPv6:::ffff:212.242.58.113]:17214
	"EHLO valis.localnet") by linux-mips.org with ESMTP
	id <S8225262AbTBTTmg>; Thu, 20 Feb 2003 19:42:36 +0000
Received: from murphy.dk (brm@brian.localnet [10.0.0.2])
	by valis.localnet (8.12.7/8.12.7/Debian-2) with ESMTP id h1KJf16n013570;
	Thu, 20 Feb 2003 20:41:01 +0100
Message-ID: <3E552F93.7070104@murphy.dk>
Date: Thu, 20 Feb 2003 20:42:11 +0100
From: Brian Murphy <brian@murphy.dk>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020623 Debian/1.0.0-0.woody.1
MIME-Version: 1.0
To: Tibor Polgar <tpolgar@freehandsystems.com>
CC: linux-mips@linux-mips.org
Subject: Re: Ramdisk image on flash.
References: <200302201135.09154.krishnakumar@naturesoft.net> <1045765647.30379.262.camel@zeus.mvista.com> <3E552CDF.ECD08EEF@freehandsystems.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <brian@murphy.dk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1479
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: brian@murphy.dk
Precedence: bulk
X-list: linux-mips

Tibor Polgar wrote:

>Pete Popov wrote:
>  
>
>>On Wed, 2003-02-19 at 22:05, Krishnakumar. R wrote:
>>    
>>
>>>Hi,
>>>
>>>Is there any way that I can keep
>>>a ramdisk image (containing the root filesystem)
>>>in a flash device and boot to it.
>>>      
>>>
>>Yes, and other architectures have support for passing arguments to the
>>kernel that tell it where the ramdisk is. I don't know that we've done
>>that for MIPS, yet.  It wouldn't be too hard to do and maybe someone on
>>this list is already working on it (I think someone actually is working
>>on it and was preparing a patch for Ralf).
>>    
>>
>
>For having separate initrd and kernel load we also need an aware bootloader
>that knows where to find the ramdisk.   RedBoot, from what i read, seems to be
>i386 specific.    The Yamon i've patched "COULD" be made to do it.   
>  
>
RedBoot is very portable and not at all i386 specific. I just ported it 
to the LASAT
boards I support in the linux kernel - it took a few days. When you have 
ported it
you almost instantly have a really nice embedded operating system too. 
Perhaps
you were confusing it with GRUB?

How this helps with ramdisks I don't know :-).

/Brian
