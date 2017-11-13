Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 13 Nov 2017 17:36:32 +0100 (CET)
Received: from userp1040.oracle.com ([156.151.31.81]:26822 "EHLO
        userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23990425AbdKMQgY5liRX (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 13 Nov 2017 17:36:24 +0100
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by userp1040.oracle.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with ESMTP id vADGZV2P002497
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 13 Nov 2017 16:35:32 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id vADGZUuJ005545
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 13 Nov 2017 16:35:30 GMT
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id vADGZNVc017675;
        Mon, 13 Nov 2017 16:35:25 GMT
Received: from [192.168.1.16] (/24.9.64.241)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 13 Nov 2017 08:35:23 -0800
Subject: Re: linux-next: Tree for Nov 7
To:     Michal Hocko <mhocko@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     Joel Stanley <joel@jms.id.au>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Abdul Haleem <abdhalee@linux.vnet.ibm.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        "James E.J. Bottomley" <jejb@parisc-linux.org>,
        Helge Deller <deller@gmx.de>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        "David S. Miller" <davem@davemloft.net>,
        Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, linux-mips@linux-mips.org,
        linux-parisc@vger.kernel.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-xtensa@linux-xtensa.org
References: <CACPK8Xfd4nqkf=Lk3n6+TNHAAi327r0dkUfGypZ3TpR0LqfS4Q@mail.gmail.com>
 <20171108142050.7w3yliulxjeco3b7@dhcp22.suse.cz>
 <20171110123054.5pnefm3mczsfv7bz@dhcp22.suse.cz>
 <CACPK8Xe5uUKEytkRiszdX511b_cYTD-z3X=ZsMcNJ-NOYnXfuQ@mail.gmail.com>
 <20171113092006.cjw2njjukt6limvb@dhcp22.suse.cz>
 <20171113094203.aofz2e7kueitk55y@dhcp22.suse.cz>
 <87lgjawgx1.fsf@concordia.ellerman.id.au>
 <20171113120057.555mvrs4fjq5tyng@dhcp22.suse.cz>
 <20171113151641.yfqrecpcxllpn5mq@dhcp22.suse.cz>
 <20171113154939.6ui2fmpokpm7g4oj@dhcp22.suse.cz>
 <20171113160637.jhekbdyfpccme3be@dhcp22.suse.cz>
From:   Khalid Aziz <khalid.aziz@oracle.com>
Organization: Oracle Corp
Message-ID: <c52fa249-9583-18a2-cbac-28abfb23d5a5@oracle.com>
Date:   Mon, 13 Nov 2017 09:35:22 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <20171113160637.jhekbdyfpccme3be@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Source-IP: aserv0022.oracle.com [141.146.126.234]
Return-Path: <khalid.aziz@oracle.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60882
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: khalid.aziz@oracle.com
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

On 11/13/2017 09:06 AM, Michal Hocko wrote:
> OK, so this one should take care of the backward compatibility while
> still not touching the arch code
> ---
> commit 39ff9bf8597e79a032da0954aea1f0d77d137765
> Author: Michal Hocko <mhocko@suse.com>
> Date:   Mon Nov 13 17:06:24 2017 +0100
> 
>      mm: introduce MAP_FIXED_SAFE
>      
>      MAP_FIXED is used quite often but it is inherently dangerous because it
>      unmaps an existing mapping covered by the requested range. While this
>      might be might be really desidered behavior in many cases there are
>      others which would rather see a failure than a silent memory corruption.
>      Introduce a new MAP_FIXED_SAFE flag for mmap to achive this behavior.
>      It is a MAP_FIXED extension with a single exception that it fails with
>      ENOMEM if the requested address is already covered by an existing
>      mapping. We still do rely on get_unmaped_area to handle all the arch
>      specific MAP_FIXED treatment and check for a conflicting vma after it
>      returns.
>      
>      Signed-off-by: Michal Hocko <mhocko@suse.com>
> 
> ...... deleted .......
> diff --git a/mm/mmap.c b/mm/mmap.c
> index 680506faceae..aad8d37f0205 100644
> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@ -1358,6 +1358,10 @@ unsigned long do_mmap(struct file *file, unsigned long addr,
>   	if (mm->map_count > sysctl_max_map_count)
>   		return -ENOMEM;
>   
> +	/* force arch specific MAP_FIXED handling in get_unmapped_area */
> +	if (flags & MAP_FIXED_SAFE)
> +		flags |= MAP_FIXED;
> +
>   	/* Obtain the address to map to. we verify (or select) it and ensure
>   	 * that it represents a valid section of the address space.
>   	 */

Do you need to move this code above:

         if (!(flags & MAP_FIXED))
                 addr = round_hint_to_min(addr);

         /* Careful about overflows.. */
         len = PAGE_ALIGN(len);
         if (!len)
                 return -ENOMEM;

Not doing that might mean the hint address will end up being rounded for 
MAP_FIXED_SAFE which would change the behavior from MAP_FIXED.

--
Khalid
