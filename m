Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 06 Jun 2017 16:10:28 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:54211 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992110AbdFFOKVwPXRu (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 6 Jun 2017 16:10:21 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id EBD464A28CC3F;
        Tue,  6 Jun 2017 15:10:11 +0100 (IST)
Received: from [10.80.2.5] (10.80.2.5) by HHMAIL01.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server (TLS) id 14.3.294.0; Tue, 6 Jun
 2017 15:10:15 +0100
Subject: Re: [PATCH v3 6/7] net: pch_gbe: Allow longer for resets
To:     Paul Burton <paul.burton@imgtec.com>, <netdev@vger.kernel.org>
CC:     Tobias Klauser <tklauser@distanz.ch>,
        "David S . Miller" <davem@davemloft.net>,
        Jarod Wilson <jarod@redhat.com>, <linux-mips@linux-mips.org>,
        Eric Dumazet <edumazet@google.com>
References: <20170602234042.22782-1-paul.burton@imgtec.com>
 <20170602234042.22782-7-paul.burton@imgtec.com>
From:   Marcin Nowakowski <marcin.nowakowski@imgtec.com>
Message-ID: <bb3deb9d-26b5-af4b-455f-a94155adc472@imgtec.com>
Date:   Tue, 6 Jun 2017 16:10:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.1.1
MIME-Version: 1.0
In-Reply-To: <20170602234042.22782-7-paul.burton@imgtec.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.2.5]
Return-Path: <Marcin.Nowakowski@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58259
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: marcin.nowakowski@imgtec.com
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

Hi Paul,

On 03.06.2017 01:40, Paul Burton wrote:
> Resets of the EG20T MAC on the MIPS Boston development board take longer
> than the 1000 loops that pch_gbe_wait_clr_bit was performing. Rather
> than simply increasing the number of loops, switch to using
> readl_poll_timeout_atomic() from linux/iopoll.h in order to provide some
> independence from the speed of the CPU.
> 
>   #define DRV_VERSION     "1.01"
> @@ -318,13 +319,11 @@ s32 pch_gbe_mac_read_mac_addr(struct pch_gbe_hw *hw)
>    */
>   static void pch_gbe_wait_clr_bit(void *reg, u32 bit)
>   {
> +	int err;
>   	u32 tmp;
>   
> -	/* wait busy */
> -	tmp = 1000;
> -	while ((ioread32(reg) & bit) && --tmp)
> -		cpu_relax();
> -	if (!tmp)
> +	err = readl_poll_timeout_atomic(reg, tmp, !(tmp & bit), 10, 500);
> +	if (err)
>   		pr_err("Error: busy bit is not cleared\n");
>   }

This new timeout value appears to be too low - I'm seeing plenty of 
timeout warnings now and ultimately the device fails to initialise:

[    7.541876] pch_gbe: EG20T PCH Gigabit Ethernet Driver - version 1.01
[    7.566451] pch_gbe: Error: busy bit is not cleared
[    7.572654] pch_gbe: Error: busy bit is not cleared
[    7.578727] pch_gbe: Error: busy bit is not cleared
[    7.587814] pch_gbe 0000:02:00.1: Invalid MAC address, interface 
disabled.
[    7.595605] pch_gbe 0000:02:00.1: MAC address : 00:00:00:00:00:00
[    7.606451] pch_gbe: Error: busy bit is not cleared
[    7.612572] pch_gbe: Error: busy bit is not cleared
[    7.618618] pch_gbe: Error: busy bit is not cleared
<...>
[   10.063351] pch_gbe 0000:02:00.1 eth0: Error: Invalid MAC address
[   10.074713] pch_gbe: Error: busy bit is not cleared
[   10.081030] pch_gbe: Error: busy bit is not cleared
[   10.087178] pch_gbe: Error: busy bit is not cleared
[   10.093328] pch_gbe: Error: busy bit is not cleared
[   10.100883] pch_gbe 0000:02:00.1 eth0: Error End
[   10.106272] IP-Config: Failed to open eth0

My tests show that a timeout value as big as 20000 may be required to 
make it work reliably ...

Marcin
