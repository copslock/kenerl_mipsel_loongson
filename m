Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 22 Feb 2016 20:15:58 +0100 (CET)
Received: from mail1.windriver.com ([147.11.146.13]:62714 "EHLO
        mail1.windriver.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27011154AbcBVTP4zS9yN (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 22 Feb 2016 20:15:56 +0100
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com [147.11.189.40])
        by mail1.windriver.com (8.15.2/8.15.1) with ESMTPS id u1MJFmYo004919
        (version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL);
        Mon, 22 Feb 2016 11:15:48 -0800 (PST)
Received: from [147.11.216.197] (147.11.216.197) by ALA-HCA.corp.ad.wrs.com
 (147.11.189.50) with Microsoft SMTP Server id 14.3.248.2; Mon, 22 Feb 2016
 11:15:47 -0800
Subject: Re: 4.5-rc4 kernel is failed to bootup on CN6880
To:     Aaro Koskinen <aaro.koskinen@nokia.com>, <david.daney@cavium.com>
References: <56C7BD89.2040800@windriver.com>
 <20160222124303.GR22974@ak-desktop.emea.nsn-net.net>
CC:     <linux-kernel@vger.kernel.org>, <linux-mips@linux-mips.org>
From:   Yang Shi <yang.shi@windriver.com>
Message-ID: <56CB5E63.1080005@windriver.com>
Date:   Mon, 22 Feb 2016 11:15:47 -0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.1
MIME-Version: 1.0
In-Reply-To: <20160222124303.GR22974@ak-desktop.emea.nsn-net.net>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <Yang.Shi@windriver.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52161
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yang.shi@windriver.com
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

On 2/22/2016 4:43 AM, Aaro Koskinen wrote:
> Hi,
>
> On Fri, Feb 19, 2016 at 05:12:41PM -0800, Yang Shi wrote:
>> I tried to boot 4.5-rc4 kernel on my CN6880 board, but it is failed at
>> booting up secondary cores. The error is:
> With v4.5-rc5, EBB6800 is booting fine:
>
> [    0.000000] CPU0 revision is: 000d9108 (Cavium Octeon II)
> [...]
> [ 2286.273935] SMP: Booting CPU01 (CoreId  1)...
> [ 2286.278201] CPU1 revision is: 000d9108 (Cavium Octeon II)
> [...]
> [ 2287.214953] SMP: Booting CPU31 (CoreId 31)...
> [ 2287.224668] CPU31 revision is: 000d9108 (Cavium Octeon II)
> [ 2287.224865] Brought up 32 CPUs
>
>> CPU31 revision is: 000d9101 (Cavium Octeon II)
>> SMP: Booting CPU32 (CoreId 32)...
>> Secondary boot timeout
>>
>> I passed "numcores=32" in kernel commandline since there are 32 cores ion
>> CN6880.
> You shouldn't have CPU32 in that case, the numbering starts from zero.
> Also the coremask is 32-bit.
>
> I can reproduce your issue with CONFIG_NR_CPUS=64. Possibly this code
> is incorrect for NR_CPUS bigger than 32:
>
>          /* The present CPUs get the lowest CPU numbers. */
>          cpus = 1;
>          for (id = 0; id < NR_CPUS; id++) {
>                  if ((id != coreid) && (core_mask & (1 << id))) {
>                          set_cpu_possible(cpus, true);
>                          set_cpu_present(cpus, true);
>
> What CONFIG_NR_CPUS did you use?

Thanks. I did have 48 NR_CPUS set. It works when I changed it to 32.

I think the problem is core_mask is 32 bit. But when NR_CPUS > 32, in 
"core_mask & (1 << id)" core_mask will be sign extended, then the 
statement will return non-zero all the time.

Yang

>
> A.
>
