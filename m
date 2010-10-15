Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 15 Oct 2010 21:04:07 +0200 (CEST)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:7029 "EHLO
        mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491762Ab0JOTEE (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 15 Oct 2010 21:04:04 +0200
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,7,2,8378)
        id <B4cb8a5c40000>; Fri, 15 Oct 2010 12:04:36 -0700
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.4675);
         Fri, 15 Oct 2010 12:04:17 -0700
Received: from dd1.caveonetworks.com ([12.108.191.236]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.4675);
         Fri, 15 Oct 2010 12:04:17 -0700
Message-ID: <4CB8A5A0.9060801@caviumnetworks.com>
Date:   Fri, 15 Oct 2010 12:04:00 -0700
From:   David Daney <ddaney@caviumnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.12) Gecko/20100907 Fedora/3.0.7-1.fc12 Thunderbird/3.0.7
MIME-Version: 1.0
To:     "Gleb O. Raiko" <raiko@niisi.msk.ru>, linux-mips@linux-mips.org
CC:     ralf@linux-mips.org
Subject: Re: [PATCH] MIPS: Implement __read_mostly
References: <1287085009-16445-1-git-send-email-ddaney@caviumnetworks.com> <4CB83A24.2050004@niisi.msk.ru>
In-Reply-To: <4CB83A24.2050004@niisi.msk.ru>
Content-Type: text/plain; charset=KOI8-R; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 15 Oct 2010 19:04:17.0219 (UTC) FILETIME=[C3E07930:01CB6C9B]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28093
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

On 10/15/2010 04:25 AM, Gleb O. Raiko wrote:
> On 14.10.2010 23:36, David Daney wrote:
>> diff --git a/arch/mips/kernel/setup.c b/arch/mips/kernel/setup.c
>> --- a/arch/mips/kernel/setup.c
>> +++ b/arch/mips/kernel/setup.c
>> @@ -69,7 +69,7 @@ static char __initdata
>> builtin_cmdline[COMMAND_LINE_SIZE] = CONFIG_CMDLINE;
>> * mips_io_port_base is the begin of the address space to which x86 style
>> * I/O ports are mapped.
>> */
>> -const unsigned long mips_io_port_base __read_mostly = -1;
>> +const unsigned long mips_io_port_base = -1;
>> EXPORT_SYMBOL(mips_io_port_base);
>
> While we're here could we eliminate mips_io_port_base for boards that
> don't need it.
>

That is a logically separate issue, so would be the subject of a 
different patch.  I don't personally plan on working on it, but would be 
happy to review anything someone else came up with.

David Daney


> Now, it almost might be done by defining something like
> __swizzle_addr_[bwlq](port) ((port) - mips_io_port_base)
>
> Unfortunately, __swizzle_addr_[bwlq] is also used for memory acceeses
> too (in read/write[bwlq]), so definition above doesn't work.
>
> By providing two variants, e.g. __swizzle_io_addr_[bwlq] and
> __swizzle_mem_addr_[bwlq] we can eliminate unnecessary loads of
> mips_io_port_base.
>
> BTW, in recent kernels the trick with mips_io_port_base doesn't work
> well anyway. The solely purpose of the trick was to prevent loading of
> mips_io_port_base across function calls. Now drivers tend to use
> ioread/iowrite that don't use mips_io_port_base at all or use its own
> wrappers for in/out[bwlq] that _do_ load mips_io_port_base on every call.
>
> Gleb.
>
