Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 26 Apr 2006 12:20:00 +0100 (BST)
Received: from bender.bawue.de ([193.7.176.20]:45019 "HELO bender.bawue.de")
	by ftp.linux-mips.org with SMTP id S4475374AbWDZLTu (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 26 Apr 2006 12:19:50 +0100
Received: from lagash (unknown [194.74.144.146])
	by bender.bawue.de (Postfix) with ESMTP
	id 4685D44FC0; Wed, 26 Apr 2006 13:33:07 +0200 (MEST)
Received: from ths by lagash with local (Exim 4.61)
	(envelope-from <ths@networkno.de>)
	id 1FYiBl-0002r6-On; Wed, 26 Apr 2006 12:28:09 +0100
Date:	Wed, 26 Apr 2006 12:28:09 +0100
To:	Bin Chen <binary.chen@gmail.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: why not put 64 bit value directly to register
Message-ID: <20060426112809.GD29550@networkno.de>
References: <5800c1cc0604252149i55ab181ax7d9355a869a9b251@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5800c1cc0604252149i55ab181ax7d9355a869a9b251@mail.gmail.com>
User-Agent: Mutt/1.5.11+cvs20060403
From:	Thiemo Seufer <ths@networkno.de>
Return-Path: <ths@networkno.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11210
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ths@networkno.de
Precedence: bulk
X-list: linux-mips

Bin Chen wrote:
> Hi,
> 
> This code is snip from u-boot, I don't know why the 32bit-64bit conversion
> is needed, why not put val directly to register but do the transform?
> 
> static void cvmx_write_cop0_entry_lo_0(uint64_t val)
> {
>     uint32_t val_low  = val & 0xffffffff;
>     uint32_t val_high = val  >> 32;
> 
>     uint32_t tmp; /* temp register */
> 
>     asm volatile (
>         "  .set mips64                       \n"
>         "  .set noreorder                    \n"
>         /* Standard twin 32 bit -> 64 bit construction */
>         "  dsll  %[valh], 32                 \n"
>         "  dla   %[tmp], 0xffffffff          \n"
>         "  and   %[vall], %[tmp], %[vall]    \n"
>         "  daddu %[valh], %[valh], %[vall]   \n"
>         /* Combined value is in valh */
>         "  dmtc0 %[valh],$2,0                \n"
>         "  .set reorder                      \n"
>          :[tmp] "=&r" (tmp) : [valh] "r" (val_high), [vall] "r" (val_low) );
> }

This will convert on a 64bit capable MIPS CPU an o32 ABI register pair
holding a long long to a 64bit register value, and write that to a CP0
register.

It will break if an exception happens in between unless the exception
handlers save/restore the upper half as well.


Thiemo
