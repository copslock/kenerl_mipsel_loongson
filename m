Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 06 May 2010 17:46:26 +0200 (CEST)
Received: from gateway01.websitewelcome.com ([69.56.236.19]:48614 "HELO
        gateway01.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with SMTP id S1492585Ab0EFPqT (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 6 May 2010 17:46:19 +0200
Received: (qmail 26260 invoked from network); 6 May 2010 15:49:08 -0000
Received: from gator750.hostgator.com (174.132.194.2)
  by gateway01.websitewelcome.com with SMTP; 6 May 2010 15:49:08 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; s=default; d=paralogos.com;
        h=Received:Message-ID:Date:From:User-Agent:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
        b=X7IeQkFmM3EAXtLl/sS6yI+k2dIx9cTzj8S+Y0Ez9oHCfwOc+YinBIXZg7KCdBGyN+omV7vmh6wxvYuGhJ+friTHyRaElEEH81yx8CFc0P6wDy5wmQgUAZl32BN5vV23;
Received: from c-98-207-157-135.hsd1.ca.comcast.net ([98.207.157.135]:2892 helo=[127.0.0.1])
        by gator750.hostgator.com with esmtpa (Exim 4.69)
        (envelope-from <kevink@paralogos.com>)
        id 1OA3H6-00052V-Kc; Thu, 06 May 2010 10:46:08 -0500
Message-ID: <4BE2E445.5050809@paralogos.com>
Date:   Thu, 06 May 2010 08:46:13 -0700
From:   "Kevin D. Kissell" <kevink@paralogos.com>
User-Agent: Thunderbird 2.0.0.24 (Windows/20100228)
MIME-Version: 1.0
To:     Sergei Shtylyov <sshtylyov@mvista.com>
CC:     Atsushi Nemoto <anemo@mba.ocn.ne.jp>, ralf@linux-mips.org,
        mcdonald.shane@gmail.com, linux-mips@linux-mips.org
Subject: Re: [MIPS] FPU emulator: allow Cause bits of FCSR to be writeable
 by ctc1
References: <4BE122D1.3000609@paralogos.com>    <20100505091159.GA4016@linux-mips.org>  <4BE19214.4010209@paralogos.com> <20100506.012240.118951273.anemo@mba.ocn.ne.jp> <4BE1C4EA.1020202@paralogos.com> <4BE2A6EE.80705@mvista.com>
In-Reply-To: <4BE2A6EE.80705@mvista.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator750.hostgator.com
X-AntiAbuse: Original Domain - linux-mips.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - paralogos.com
Return-Path: <kevink@paralogos.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26625
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kevink@paralogos.com
Precedence: bulk
X-list: linux-mips

Sergei Shtylyov wrote:
> Kevin D. Kissell wrote:
>
>> I'm cool with the patch as is, but in the general spirit of regarding
>> numeric constants other than 0 and 1 as instruments of Satan, it
>> would probably be even better if those reserved bits were defined
>> (FPU_CSR_RSVD, or whatever is compatible with existing convention for
>> such bits) along with the other FCSR bit masks in mipsregs.h, so that
>> the assigment looks like:
>>
>>          ctx->fcr31 = (value & ~(FPU_CSR_RSVD | 0x3)) |
>>                   ieee_rm[value & 0x3];
>
>   0x3 is still neither 0 nor 1, and so remains an instrument of Satan.
> How about #defining it also? :-)
In some software engineering cultures, that would be considered a good
idea or even mandatory.  This being the Linux kernel, I think it's OK,
because, as Shane remarked, it's a mask that's local to the module and
whose value is "obvious", and such things are pretty commonly handled as
numeric constants in the kernel.

There actually *is* a #define for that field, FPU_CSR_RD, which could be
used here in place of the 0x3, but I'm a little torn about its use.  On
one hand "value & ~(FPU_CSR_RSVD | FPU_CSR_RD)" is more clear about what
we're doing, but on the other hand, it's less obvious that "value &
FPU_CSR_RD" is generating an integer in the range 0-3 for an index.  So
I'm absolutely fine with the code as written, but wouldn't complain if
someone wanted to make it use the symbolic constant.

          Yours in excessive geekery,

          Kevin K.
