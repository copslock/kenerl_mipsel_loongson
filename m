Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 11 Feb 2005 18:59:15 +0000 (GMT)
Received: from mail1.sonicwall.com ([IPv6:::ffff:67.115.118.17]:48338 "EHLO
	relay1.sonicwall.com") by linux-mips.org with ESMTP
	id <S8225282AbVBKS7A>; Fri, 11 Feb 2005 18:59:00 +0000
Received: from us0exb02.us.sonicwall.com ([10.50.128.202]) by relay1.sonicwall.com with Microsoft SMTPSVC(5.0.2195.6713);
	 Fri, 11 Feb 2005 10:58:55 -0800
Received: from [10.0.15.99] ([10.0.15.99]) by us0exb02.us.sonicwall.com with Microsoft SMTPSVC(5.0.2195.6713);
	 Fri, 11 Feb 2005 10:58:54 -0800
Message-ID: <420D006E.3000107@total-knowledge.com>
Date:	Fri, 11 Feb 2005 10:58:54 -0800
From:	"Ilya A. Volynets-Evenbakh" <ilya@total-knowledge.com>
Organization: Total Knowledge
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20041221
X-Accept-Language: en-us, en
MIME-Version: 1.0
To:	"Maciej W. Rozycki" <macro@linux-mips.org>
CC:	"Stephen P. Becker" <geoman@gentoo.org>,
	Frederic TEMPORELLI - astek <ftemporelli@astek.fr>,
	linux-mips@linux-mips.org
Subject: Re: IP32 - issues with last CVS snapshoot
References: <420CEE7F.3080201@astek.fr> <420CF611.5030705@gentoo.org> <Pine.LNX.4.61L.0502111825300.30117@blysk.ds.pg.gda.pl>
In-Reply-To: <Pine.LNX.4.61L.0502111825300.30117@blysk.ds.pg.gda.pl>
X-Enigmail-Version: 0.89.6.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 11 Feb 2005 18:58:54.0973 (UTC) FILETIME=[BBE3A2D0:01C5106B]
Return-Path: <ilya@total-knowledge.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7231
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ilya@total-knowledge.com
Precedence: bulk
X-list: linux-mips

O64 may not be supported ABI, but it provides us with a feature that is 
really usefull:
specifically, it generates 32 bit symbol addresses instead of 64 bit 
ones. This cuts
down on code size considerably. If this feature was implemented in 
toolchain as separate
switch, O64 hack could go away.

With that said, you are of course right - IP32 code and some drivers are 
broken, because
they do rely on this feature in many places.

This also means - for a user it isn't recommended to use ElF64 kernel ;-)




Maciej W. Rozycki wrote:

>On Fri, 11 Feb 2005, Stephen P. Becker wrote:
>
>  
>
>>>First, there's something wrong with "make ip32_defconfig" which generate
>>>config file with "Kernel code model = 64-bit kernel" (MIPS64=y) but
>>>doesn't preselect  "Use 64-bit ELF format for building" (BUILD_ELF64=n)
>>>doing so, "make" quickly generates an error:
>>>      
>>>
>>O2 doesn't use 64-bit ELF format.  You have to use o64.  See the
>>    
>>
>
> O64 isn't a supported ABI for Linux.  It's a crazy ad-hoc hack that 
>shouldn't be used at all.  Code to handle it somehow may still exist in 
>binutils, but it's abandoned -- nobody bothers checking if it still works.  
>With the upcoming explicit reloc support for non-PIC code in GCC 4.0 it 
>won't work at all anymore.
>
>  
>
>>arch/mips/Makefile portion of http://dev.gentoo.org/~geoman/cvs.diff for the
>>proper changes.  I'm willing to bet a lot of your problems will go away if you
>>stop using ELF64.  Such a kernel will boot, but it never quite works right.
>>    
>>
>
> If you have a problem with n64 binaries, then either you have broken 
>tools or there is a bug in the platform-dependent code somewhere -- 
>probably some inline asm forgetting about the %higher and %highest 
>relocations.  Check your tools (I'd recommend GCC 3.4.3 and binutils 2.15) 
>and if they're fine, then file a bug report.  N64 binaries work for 
>several platforms (I've tested three myself; I'm sure others did that 
>for others as well).
>
> Regardless of the format used for building, the final executable is 
>converted to ELF32 or ELF64 if necessary to suit the bootloader used, as 
>controlled by the CONFIG_BOOT_ELF32 and CONFIG_BOOT_ELF64 options.
>
>  Maciej
>
>  
>


-- 
Ilya A. Volynets-Evenbakh
Total Knowledge. CTO
http://www.total-knowledge.com
