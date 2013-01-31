Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 31 Jan 2013 14:00:24 +0100 (CET)
Received: from nbd.name ([46.4.11.11]:41918 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6824788Ab3AaNATTy-Ae (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 31 Jan 2013 14:00:19 +0100
Message-ID: <510A6A44.8090204@openwrt.org>
Date:   Thu, 31 Jan 2013 13:57:40 +0100
From:   John Crispin <blogic@openwrt.org>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:10.0.7) Gecko/20120922 Icedove/10.0.7
MIME-Version: 1.0
To:     Florian Fainelli <florian@openwrt.org>
CC:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: Re: [PATCH V3 10/10] MIPS: ralink: adds Kbuild files
References: <1359633561-4980-1-git-send-email-blogic@openwrt.org> <1359633561-4980-11-git-send-email-blogic@openwrt.org> <510A6A17.5050003@openwrt.org>
In-Reply-To: <510A6A17.5050003@openwrt.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-archive-position: 35655
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: blogic@openwrt.org
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
Return-Path: <linux-mips-bounce@linux-mips.org>

On 31/01/13 13:56, Florian Fainelli wrote:
> Hello John,
>
> On 01/31/2013 12:59 PM, John Crispin wrote:
> [snip]
>>
>>   config MIPS_L1_CACHE_SHIFT
>>       int
>> -    default "4" if MACH_DECSTATION || MIKROTIK_RB532 || 
>> PMC_MSP4200_EVAL
>> +    default "4" if MACH_DECSTATION || MIKROTIK_RB532 || 
>> PMC_MSP4200_EVAL || RALINK_RT288X
>
> I got slightly confused here because this is actually ok, 
> RALINK_RT288X should have MIPS_L1_CACHE_SHIFT=4, but rt305x and rt3883 
> have MIPS_L1_CACHE_SHIFT=5. So I would drop this hunk until you add 
> support for rt288x.
> -- 
> Florian
>


yes i forgot that bit

     John
