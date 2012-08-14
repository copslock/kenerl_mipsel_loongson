Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 14 Aug 2012 14:29:55 +0200 (CEST)
Received: from arrakis.dune.hu ([78.24.191.176]:51493 "EHLO arrakis.dune.hu"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1903553Ab2HNM3t (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 14 Aug 2012 14:29:49 +0200
X-Virus-Scanned: at arrakis.dune.hu
Received: from [192.168.254.129] (catvpool-576570d8.szarvasnet.hu [87.101.112.216])
        by arrakis.dune.hu (Postfix) with ESMTPSA id AB10B23C0072;
        Tue, 14 Aug 2012 14:29:46 +0200 (CEST)
Message-ID: <502A44B9.6010708@openwrt.org>
Date:   Tue, 14 Aug 2012 14:29:45 +0200
From:   Gabor Juhos <juhosg@openwrt.org>
MIME-Version: 1.0
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     linux-mips@linux-mips.org
Subject: Re: [PATCH v3 4/4] MIPS: ath79: don't override CPU ASE features
References: <1344096087-25044-1-git-send-email-juhosg@openwrt.org> <1344096087-25044-5-git-send-email-juhosg@openwrt.org> <20120814095923.GD28466@linux-mips.org>
In-Reply-To: <20120814095923.GD28466@linux-mips.org>
X-Enigmail-Version: 1.4.3
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
X-archive-position: 34149
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: juhosg@openwrt.org
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

2012.08.14. 11:59 keltezéssel, Ralf Baechle írta:
> On Sat, Aug 04, 2012 at 06:01:27PM +0200, Gabor Juhos wrote:
> 
>> The ath79 platform covers various SoCs which are based on
>> the 24Kc and 74Kc cores. Currently various ASEs are disabled
>> explicitely by the cpu-feature-overrides header, even those
>> which are present in the 74Kc core.
>>
>> The kernel is able to detect the available ASEs, so remove
>> the overrides.
>>
>> Signed-off-by: Gabor Juhos <juhosg@openwrt.org>
>> ---
>>  arch/mips/include/asm/mach-ath79/cpu-feature-overrides.h |    8 --------
>>  1 file changed, 8 deletions(-)
>>
>> diff --git a/arch/mips/include/asm/mach-ath79/cpu-feature-overrides.h b/arch/mips/include/asm/mach-ath79/cpu-feature-overrides.h
>> index 4476fa0..edbf23e 100644
>> --- a/arch/mips/include/asm/mach-ath79/cpu-feature-overrides.h
>> +++ b/arch/mips/include/asm/mach-ath79/cpu-feature-overrides.h
>> @@ -32,19 +32,11 @@
>>  #define cpu_has_ejtag		1
>>  #define cpu_has_llsc		1
>>  
>> -#define cpu_has_mips16		1
> 
> Both 24K and 74K always implement MIPS16, so leave this defined to 1.
> 
>> -#define cpu_has_mdmx		0
>> -#define cpu_has_mips3d		0
> 
> Neither the 24K nor he 74K implement MIPS-3D or MDMX, so best leave these
> defined to 0.
> 
>> -#define cpu_has_smartmips	0
> 
> Neither the 24K nor he 74K implement SmartMIPS, so best leave this defined
> to 0.

Ok, I will keep these lines.

> 
>>  #define cpu_has_mips32r1	1
>>  #define cpu_has_mips32r2	1
>>  #define cpu_has_mips64r1	0
>>  #define cpu_has_mips64r2	0
>>  
>> -#define cpu_has_dsp		0
> 
> 24K has no DSP extension, 24KE has DSP extensions (version 1 afair).  74K
> implements DSP ASE version 2.  So if you have a plain 24K (or 24Kc or
> 24Kf or other non-24KE based 24K variant), wire this to 0.  If you have
> a 24KE family core then removing the definition is the right thing.

The AR71xx/AR724x/AR913x/AR933x SoCs are using the 24Kc core, but the AR934x
SoCs are using 74K. The ath79 platform code can support all of these SoCs within
a single kernel, so removing the definition seems to be the right thing.
Although it would be possible to optimize things if only the 24K or the 74K
based SoCs are selected, but that would require ugly ifdef statements.

> 
>> -#define cpu_has_mipsmt		0
> 
> Neither implements the MT ASE, so best leave these defined to 0.

Ok.

> Generally, hardwire whatever you can.  This will make gcc eleminate lots
> of dead code and result in a significantly smaller and also faster kernel.

I will send an updated patch. Thank you for the review!

-Gabor
