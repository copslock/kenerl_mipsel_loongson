Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 18 Jan 2017 14:51:34 +0100 (CET)
Received: from nbd.name ([IPv6:2a01:4f8:131:30e2::2]:48418 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23991955AbdARNv1t2ae7 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 18 Jan 2017 14:51:27 +0100
Subject: Re: [PATCH] mtd: maps: lantiq-flash: Check if the EBU endianness swap
 is enabled
To:     Seb <sebtx452@gmail.com>
References: <1484741452-27141-1-git-send-email-sebtx452@gmail.com>
 <e5bb2245-a0d0-5b66-2c75-9af26c6ea846@phrozen.org>
 <CA+hF=GeD0dhBUkR+wR_35pSXgSnU0kW6EfYWa9h2QrGOTReMnA@mail.gmail.com>
Cc:     linux-mtd@lists.infradead.org, linux-mips@linux-mips.org
From:   John Crispin <john@phrozen.org>
Message-ID: <845374ff-62b0-983b-b399-4965421a9066@phrozen.org>
Date:   Wed, 18 Jan 2017 14:51:25 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.10; rv:45.0)
 Gecko/20100101 Thunderbird/45.6.0
MIME-Version: 1.0
In-Reply-To: <CA+hF=GeD0dhBUkR+wR_35pSXgSnU0kW6EfYWa9h2QrGOTReMnA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-Path: <john@phrozen.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56394
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



On 18/01/2017 14:48, Seb wrote:
> Hi John,
> 
> 
>>>
>>>       ltq_mtd->map->map_priv_1 = LTQ_NOR_PROBING;
>>
>> this line should be dropped
> 
> Yes, I noticed this mistake. I fixed it but forgotten to add thix fix
> to my commit -_-
> 
>>> +     /* We swap the addresses only if the EBU endianness swap is disabled */
>>> +     if (ltq_ebu_r32(LTQ_EBU_BUSCON0) & BIT(30))
>>
>> add a define for BIT(30) please and we should really check if this a
>> v1.2 or newer. if my memory is correct this was a silicon bug inside
>> v1.0 and v1.1
> 
> In my kernel (OpenWrt) boot log I have :
> 
> [    0.000000] Linux version 4.4.14 (qa@serveurQA) (gcc version 5.3.0
> (OpenWrt GCC 5.3.0 50020) ) #150 SMP Tue Jan 17 09:18:24 UTC 2017
> [    0.000000] SoC: xRX200 rev 1.2
> [    0.000000] bootconsole [early0] enabled
> [    0.000000] CPU0 revision is: 00019556 (MIPS 34Kc)
> 
> It would be better to ensure that the SoC version is >= 1.2 (as this
> bug was fixed in this version).

the bug is also fixed on the 300 and 500 series chips, so we would want
to check for that aswell.

	John




> You can get more informations in my OpenWrt pull request :
> 
> https://github.com/openwrt/openwrt/pull/321
> 
> 
> Regards,
> 
> Sebastien.
> 
