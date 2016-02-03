Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 03 Feb 2016 18:45:54 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:56770 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27011683AbcBCRpvcppqz (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 3 Feb 2016 18:45:51 +0100
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Websense Email Security Gateway with ESMTPS id A4E8E9462A3D8;
        Wed,  3 Feb 2016 17:45:42 +0000 (GMT)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 HHMAIL01.hh.imgtec.org (10.100.10.19) with Microsoft SMTP Server (TLS) id
 14.3.266.1; Wed, 3 Feb 2016 17:45:45 +0000
Received: from [192.168.154.45] (192.168.154.45) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.210.2; Wed, 3 Feb
 2016 17:45:44 +0000
Subject: Re: [PATCH] MIPS: Octeon: Add Octeon III CN7XXX interface detection
To:     Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
        <david.daney@cavium.com>
References: <1454412318-27213-1-git-send-email-Zubair.Kakakhel@imgtec.com>
 <56B09528.1030902@cogentembedded.com>
CC:     <janne.huttunen@nokia.com>, <aaro.koskinen@nokia.com>,
        <ralf@linux-mips.org>, <linux-mips@linux-mips.org>,
        <linux-kernel@vger.kernel.org>
From:   Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>
Message-ID: <56B23CB2.5090805@imgtec.com>
Date:   Wed, 3 Feb 2016 17:45:22 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.3.0
MIME-Version: 1.0
In-Reply-To: <56B09528.1030902@cogentembedded.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [192.168.154.45]
Return-Path: <Zubair.Kakakhel@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51706
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Zubair.Kakakhel@imgtec.com
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

Hi,

Thanks for the review. Comments below.

On 02/02/16 11:38, Sergei Shtylyov wrote:
> Hello.
>
> On 2/2/2016 2:25 PM, Zubair Lutfullah Kakakhel wrote:
>
>> Add basic CN7XXX interface detection.
>>
>> This allows the kernel to boot with ethernet working as it initializes
>> the ethernet ports with SGMII instead of defaulting to RGMII routines.
>>
>> Tested on the utm8 from Rhino Labs with a CN7130.
>>
>> Signed-off-by: Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>
>> ---
>>   arch/mips/cavium-octeon/executive/cvmx-helper.c | 41 +++++++++++++++++++++++++
>>   1 file changed, 41 insertions(+)
>>
>> diff --git a/arch/mips/cavium-octeon/executive/cvmx-helper.c b/arch/mips/cavium-octeon/executive/cvmx-helper.c
>> index 376701f..1a28009 100644
>> --- a/arch/mips/cavium-octeon/executive/cvmx-helper.c
>> +++ b/arch/mips/cavium-octeon/executive/cvmx-helper.c
> [...]
>> @@ -260,6 +262,39 @@ static cvmx_helper_interface_mode_t __cvmx_get_mode_octeon2(int interface)
>>   }
>>
>>   /**
>> + * @INTERNAL
>> + * Return interface mode for CN7XXX.
>> + */
>> +static cvmx_helper_interface_mode_t __cvmx_get_mode_cn7xxx(int interface)
>
>     Not *unsigned*?

The rest of the instances in the file don't have unsigned.

Probably because it is an enum..

>
>> +{
>> +    union cvmx_gmxx_inf_mode mode;
>> +
>> +    mode.u64 = cvmx_read_csr(CVMX_GMXX_INF_MODE(interface));
>> +
>> +    if (interface < 2) {        /* SGMII/QSGMII/XAUI */
>> +        switch (mode.cn68xx.mode) {
>> +        case 0:
>> +            return CVMX_HELPER_INTERFACE_MODE_DISABLED;
>> +        case 1:
>> +        case 2:
>> +            return CVMX_HELPER_INTERFACE_MODE_SGMII;
>> +        case 3:
>> +            return CVMX_HELPER_INTERFACE_MODE_XAUI;
>> +        default:
>> +            return CVMX_HELPER_INTERFACE_MODE_SGMII;
>> +        }
>> +    } else if (interface == 2)    /* NPI */
>> +        return CVMX_HELPER_INTERFACE_MODE_NPI;
>> +    else if (interface == 3)    /* LOOP */
>> +        return CVMX_HELPER_INTERFACE_MODE_LOOP;
>> +    else if (interface == 4)    /* RGMII (AGL) */
>> +        return CVMX_HELPER_INTERFACE_MODE_RGMII;
>
>     This is asking to be a *switch* statement.

Ask and you shall receive

(⌐▀͡ ̯ʖ▀)

Thanks
ZubairLK

>
>> +
>> +    return CVMX_HELPER_INTERFACE_MODE_DISABLED;
>> +}
>> +
>> +
>> +/**
>>    * Get the operating mode of an interface. Depending on the Octeon
>>    * chip and configuration, this function returns an enumeration
>>    * of the type of packet I/O supported by an interface.
> [...]
>
> MBR, Sergei
>
>
