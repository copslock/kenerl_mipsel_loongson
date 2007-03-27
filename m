Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 27 Mar 2007 18:55:56 +0100 (BST)
Received: from alpha.total-knowledge.com ([205.217.158.170]:13721 "EHLO
	total-knowledge.com") by ftp.linux-mips.org with ESMTP
	id S20022367AbXC0Rzu (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 27 Mar 2007 18:55:50 +0100
Received: (qmail 31282 invoked from network); 27 Mar 2007 10:54:34 -0700
Received: from unknown (HELO ?192.168.0.217?) (ilya@209.157.142.202)
  by alpha.total-knowledge.com with ESMTPA; 27 Mar 2007 10:54:34 -0700
Message-ID: <46095A60.5070605@total-knowledge.com>
Date:	Tue, 27 Mar 2007 10:54:40 -0700
From:	"Ilya A. Volynets-Evenbakh" <ilya@total-knowledge.com>
Organization: Total Knowledge
User-Agent: Thunderbird 1.5.0.10 (X11/20070312)
MIME-Version: 1.0
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
CC:	linux-mips@linux-mips.org
Subject: Re: [PATCH]: Remove CONFIG_BUILD_ELF64 entirely
References: <4607CF1D.50904@gentoo.org>	<20070326.234316.23009158.anemo@mba.ocn.ne.jp>	<46086A90.7070402@gentoo.org> <20070327.235310.128618679.anemo@mba.ocn.ne.jp>
In-Reply-To: <20070327.235310.128618679.anemo@mba.ocn.ne.jp>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-Path: <ilya@total-knowledge.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14736
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ilya@total-knowledge.com
Precedence: bulk
X-list: linux-mips

Because we are too lazy to get HIGHMEM working in order to get
support for all of its memory. Not to mention that HIGHMEM is Evil(TM).

Atsushi Nemoto wrote:
> On Mon, 26 Mar 2007 20:51:28 -0400, Kumba <kumba@gentoo.org> wrote:
>   
>> Lets try this one; the kernel was built with gcc-4.1.2 and binutils-2.17 this 
>> time around, and I tested it before running objdump on it.  It just hangs right 
>> after loading:
>>
>>  > bootp(): console=ttyS0,38400 root=/dev/md0
>> Setting $netaddr to 192.168.1.12 (from server )
>> Obtaining  from server
>> 4358278+315290 entry: 0x80401000
>>     
>
> Now I can not see any problem with the disassembled code.  No idea why
> it does not work at all...
>
> BTW, why IP32 does not support 32-bit kernel, though it has 32-bit
> firmware?
> ---
> Atsushi Nemoto
>
>   

-- 
Ilya A. Volynets-Evenbakh
Total Knowledge. CTO
http://www.total-knowledge.com
