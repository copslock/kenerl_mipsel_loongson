Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 20 May 2015 16:17:58 +0200 (CEST)
Received: from mail-gw1-out.broadcom.com ([216.31.210.62]:17234 "EHLO
        mail-gw1-out.broadcom.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27010189AbbETORzlBvrk (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 20 May 2015 16:17:55 +0200
X-IronPort-AV: E=Sophos;i="5.13,464,1427785200"; 
   d="scan'208";a="65506139"
Received: from irvexchcas08.broadcom.com (HELO IRVEXCHCAS08.corp.ad.broadcom.com) ([10.9.208.57])
  by mail-gw1-out.broadcom.com with ESMTP; 20 May 2015 07:56:58 -0700
Received: from IRVEXCHSMTP2.corp.ad.broadcom.com (10.9.207.52) by
 IRVEXCHCAS08.corp.ad.broadcom.com (10.9.208.57) with Microsoft SMTP Server
 (TLS) id 14.3.235.1; Wed, 20 May 2015 07:17:47 -0700
Received: from mail-sj1-12.sj.broadcom.com (10.10.10.20) by
 IRVEXCHSMTP2.corp.ad.broadcom.com (10.9.207.52) with Microsoft SMTP Server id
 14.3.235.1; Wed, 20 May 2015 07:17:47 -0700
Received: from [10.176.128.60] (xl-bun-02.bun.broadcom.com [10.176.128.60])     by
 mail-sj1-12.sj.broadcom.com (Postfix) with ESMTP id 38A6B27A81;        Wed, 20 May
 2015 07:17:46 -0700 (PDT)
Message-ID: <555C9789.9010709@broadcom.com>
Date:   Wed, 20 May 2015 16:17:45 +0200
From:   Arend van Spriel <arend@broadcom.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686 (x86_64); en-US; rv:1.9.2.24) Gecko/20111103 Lightning/1.0b2 Thunderbird/3.1.16
MIME-Version: 1.0
To:     =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        Hante Meuleman <meuleman@broadcom.com>,
        Hauke Mehrtens <hauke@hauke-m.de>
Subject: Re: [PATCH RESEND] mips: bcm47xx: allow retrieval of complete nvram
 contents
References: <1432122655-3224-1-git-send-email-arend@broadcom.com>       <CACna6rxeU0FUiTRNXFgK-xxSDY8WA82h7MLmcPc=7eM5sqMdBw@mail.gmail.com>    <555C83FC.7010701@broadcom.com> <CACna6rw3ZgJSLrR=kNKDNgcLHz7-bZjaObv2zuTgmWWeUtLSUw@mail.gmail.com>
In-Reply-To: <CACna6rw3ZgJSLrR=kNKDNgcLHz7-bZjaObv2zuTgmWWeUtLSUw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
Return-Path: <arend@broadcom.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47496
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

On 05/20/15 15:48, Rafał Miłecki wrote:
> On 20 May 2015 at 14:54, Arend van Spriel<arend@broadcom.com>  wrote:
>> On 05/20/15 14:31, Rafał Miłecki wrote:
>>>
>>> On 20 May 2015 at 13:50, Arend van Spriel<arend@broadcom.com>   wrote:
>>>>
>>>> From: Hante Meuleman<meuleman@broadcom.com>
>>>>
>>>> Host platforms such as routers supported by OpenWRT can
>>>> support NVRAM reading directly from internal NVRAM store.
>>>> The brcmfmac for one requires the complete nvram contents
>>>> to select what needs to be sent to wireless device.
>>>
>>>
>>> First of all, I have to ask you to rebase this patch on top of
>>> upstream-sfr. Mostly because of
>>> MIPS: BCM47XX: Make sure NVRAM buffer ends with \0
>>
>>
>> No idea what upstream-sfr is. I applied the patch on top of the master
>> branch of linux-mips repo [1]. What am I missing here?
>>
>> [1] http://git.linux-mips.org/cgit/ralf/linux.git
>
> Just go a dir higher and you'll find it :)
> http://git.linux-mips.org/cgit/
>
> Its a repo with mips-for-linux-next branch you're looking for.

Thanks. Found it.

Regards,
Arend
