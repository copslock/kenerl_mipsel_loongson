Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 06 Jan 2013 22:14:15 +0100 (CET)
Received: from mms2.broadcom.com ([216.31.210.18]:2338 "EHLO mms2.broadcom.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6816511Ab3AFVOLExitu (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sun, 6 Jan 2013 22:14:11 +0100
Received: from [10.9.200.133] by mms2.broadcom.com with ESMTP (Broadcom
 SMTP Relay (Email Firewall v6.5)); Sun, 06 Jan 2013 13:10:54 -0800
X-Server-Uuid: 4500596E-606A-40F9-852D-14843D8201B2
Received: from mail-irva-13.broadcom.com (10.11.16.103) by
 IRVEXCHHUB02.corp.ad.broadcom.com (10.9.200.133) with Microsoft SMTP
 Server id 8.2.247.2; Sun, 6 Jan 2013 13:13:45 -0800
Received: from [10.0.2.15] (unknown [10.177.252.159]) by
 mail-irva-13.broadcom.com (Postfix) with ESMTP id 0694340FE3; Sun, 6
 Jan 2013 13:13:55 -0800 (PST)
Message-ID: <50E9E914.9030900@broadcom.com>
Date:   Sun, 6 Jan 2013 22:13:56 +0100
From:   "Arend van Spriel" <arend@broadcom.com>
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:17.0) Gecko/17.0
 Thunderbird/17.0
MIME-Version: 1.0
To:     "Sergei Shtylyov" <sshtylyov@mvista.com>
cc:     "Ralf Baechle" <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        "Hauke Mehrtens" <hauke@hauke-m.de>
Subject: Re: [PATCH] mips: bcm47xx: select GPIOLIB for BCMA on bcm47xx
 platform
References: <1357323005-28008-1-git-send-email-arend@broadcom.com>
 <50E80F78.9030901@mvista.com>
In-Reply-To: <50E80F78.9030901@mvista.com>
X-Enigmail-Version: 1.4.6
X-WSS-ID: 7CF737D43Q41305152-01-01
Content-Type: text/plain;
 charset=iso-8859-1
Content-Transfer-Encoding: 7bit
X-archive-position: 35382
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: arend@broadcom.com
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

On 01/05/2013 12:33 PM, Sergei Shtylyov wrote:
> Hello.
> 
> On 04-01-2013 22:10, Arend van Spriel wrote:
> 
>> The Kconfig items BCM47XX_BCMA and BCM47XX_SSB selected
>> respectively BCMA_DRIVER_GPIO and SSB_DRIVER_GPIO. These
>> options depend on GPIOLIB without explicitly selecting it
>> so it results in a warning when GPIOLIB is not set:
> 
>> scripts/kconfig/conf --oldconfig Kconfig
>> warning: (BCM47XX_BCMA) selects BCMA_DRIVER_GPIO ... unmet direct
>>     dependencies (BCMA_POSSIBLE && BCMA && GPIOLIB)
>> warning: (BCM47XX_SSB) selects SSB_DRIVER_GPIO ... unmet direct
>>     dependencies (SSB_POSSIBLE && SSB && GPIOLIB)
> 
>> which subsequently results in compile errors.
> 
>> Cc: Hauke Mehrtens <hauke@hauke-m.de>
>> Signed-off-by: Arend van Spriel <arend@broadcom.com>
>> ---
>> Fixing a Kconfig issue in our nightly Jenkins build.
> 
>> Gr. AvS
>> ---
>>   arch/mips/bcm47xx/Kconfig |    3 +++
>>   1 file changed, 3 insertions(+)
> 
>> diff --git a/arch/mips/bcm47xx/Kconfig b/arch/mips/bcm47xx/Kconfig
>> index d7af29f..ba61192 100644
>> --- a/arch/mips/bcm47xx/Kconfig
>> +++ b/arch/mips/bcm47xx/Kconfig
>> @@ -8,8 +8,10 @@ config BCM47XX_SSB
>>       select SSB_DRIVER_EXTIF
>>       select SSB_EMBEDDED
>>       select SSB_B43_PCI_BRIDGE if PCI
>> +    select SSB_DRIVER_PCICORE if PCI
> 
>    This change doesn';t seem to be documented in your changelog. Maybe
> it's worth another patch?
> 
> WBR, Sergei
> 

Very observant. ;-) Yes. After fixing the other ones I got a warning on
that one. I could resubmit the change with a more generic description or
split it up as you suggest.

Ralf,

Please advice.

Gr. AvS
