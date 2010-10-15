Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 15 Oct 2010 13:09:57 +0200 (CEST)
Received: from t111.niisi.ras.ru ([193.232.173.111]:42704 "EHLO
        t111.niisi.ras.ru" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1491102Ab0JOLJy (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 15 Oct 2010 13:09:54 +0200
Received: from aa19.niisi.msk.ru (aa19.niisi.msk.ru [172.16.0.19] (may be forged))
        by t111.niisi.ras.ru (8.13.8/8.13.8) with ESMTP id o9FB9s6o017700;
        Fri, 15 Oct 2010 15:09:56 +0400
Received: from [192.168.173.2] (aa248 [172.16.0.248])
        by aa19.niisi.msk.ru (8.13.8/8.13.8) with ESMTP id o9FB0B8U008124;
        Fri, 15 Oct 2010 15:00:11 +0400
Message-ID: <4CB83A24.2050004@niisi.msk.ru>
Date:   Fri, 15 Oct 2010 15:25:24 +0400
From:   "Gleb O. Raiko" <raiko@niisi.msk.ru>
Organization: NIISI RAN
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.9.1.5) Gecko/20091204 Thunderbird/3.0
MIME-Version: 1.0
To:     David Daney <ddaney@caviumnetworks.com>
CC:     linux-mips@linux-mips.org, ralf@linux-mips.org
Subject: Re: [PATCH] MIPS: Implement __read_mostly
References: <1287085009-16445-1-git-send-email-ddaney@caviumnetworks.com>
In-Reply-To: <1287085009-16445-1-git-send-email-ddaney@caviumnetworks.com>
Content-Type: text/plain; charset=KOI8-R; format=flowed
Content-Transfer-Encoding: 7bit
X-Antivirus: Dr.Web (R) for Mail Servers on t111.niisi.ras.ru host
X-Antivirus-Code: 100000
Return-Path: <raiko@niisi.msk.ru>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28085
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: raiko@niisi.msk.ru
Precedence: bulk
X-list: linux-mips

On 14.10.2010 23:36, David Daney wrote:
> diff --git a/arch/mips/kernel/setup.c b/arch/mips/kernel/setup.c
> --- a/arch/mips/kernel/setup.c
> +++ b/arch/mips/kernel/setup.c
> @@ -69,7 +69,7 @@ static char __initdata builtin_cmdline[COMMAND_LINE_SIZE] = CONFIG_CMDLINE;
>    * mips_io_port_base is the begin of the address space to which x86 style
>    * I/O ports are mapped.
>    */
> -const unsigned long mips_io_port_base __read_mostly = -1;
> +const unsigned long mips_io_port_base = -1;
>   EXPORT_SYMBOL(mips_io_port_base);

While we're here could we eliminate mips_io_port_base for boards that 
don't need it.

Now, it almost might be done by defining something like
__swizzle_addr_[bwlq](port)	((port) - mips_io_port_base)

Unfortunately, __swizzle_addr_[bwlq] is also used for memory acceeses 
too (in read/write[bwlq]), so definition above doesn't work.

By providing two variants, e.g. __swizzle_io_addr_[bwlq] and 
__swizzle_mem_addr_[bwlq] we can eliminate unnecessary loads of 
mips_io_port_base.

BTW, in recent kernels the trick with mips_io_port_base doesn't work 
well anyway. The solely purpose of the trick was to prevent loading of 
mips_io_port_base across function calls. Now drivers tend to use 
ioread/iowrite that don't use mips_io_port_base at all or use its own 
wrappers for in/out[bwlq] that _do_ load mips_io_port_base on every call.

Gleb.
