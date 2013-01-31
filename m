Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 31 Jan 2013 14:16:01 +0100 (CET)
Received: from nbd.name ([46.4.11.11]:40676 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6823555Ab3AaNQArYxLw (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 31 Jan 2013 14:16:00 +0100
Message-ID: <510A6DF2.6000509@phrozen.org>
Date:   Thu, 31 Jan 2013 14:13:22 +0100
From:   John Crispin <john@phrozen.org>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:10.0.7) Gecko/20120922 Icedove/10.0.7
MIME-Version: 1.0
To:     linux-mips@linux-mips.org
Subject: Re: [PATCH V3 09/10] MIPS: ralink: adds rt305x devicetree
References: <1359633561-4980-1-git-send-email-blogic@openwrt.org> <1359633561-4980-10-git-send-email-blogic@openwrt.org> <510A6ABB.2090800@openwrt.org>
In-Reply-To: <510A6ABB.2090800@openwrt.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-archive-position: 35659
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: john@phrozen.org
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


> The specific partition mapping definitively belongs to a rt305x-eval.dts
> file and not a dtsi you would create.

I’ll split this into 2 files

>
>> +};
>> diff --git a/arch/mips/ralink/rt305x.c b/arch/mips/ralink/rt305x.c
>> index 1e24439..f4b2e4d 100644
>> --- a/arch/mips/ralink/rt305x.c
>> +++ b/arch/mips/ralink/rt305x.c
>> @@ -185,8 +185,8 @@ void __init ralink_clk_init(void)
>>
>> void __init ralink_of_remap(void)
>> {
>> - rt_sysc_membase = plat_of_remap_node("ralink,rt305x-sysc");
>> - rt_memc_membase = plat_of_remap_node("ralink,rt305x-memc");
>> + rt_sysc_membase = plat_of_remap_node("ralink,rt3052-sysc");
>> + rt_memc_membase = plat_of_remap_node("ralink,rt3052-memc");
>
> Why are you doing this? If you specify multiple compatible properties,
> such as:
> compatible = "ralink,rt3052-sysc", "ralink,rt305x-sysc" you should be
> good in any case no?


I folded that fix into the wrong patch :-)


using wild cards is discouraged for compatible strings rt3052 was the 
first silicon with this sysc version.

	John
