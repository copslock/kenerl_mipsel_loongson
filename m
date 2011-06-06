Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 06 Jun 2011 12:56:39 +0200 (CEST)
Received: from mms3.broadcom.com ([216.31.210.19]:1989 "EHLO MMS3.broadcom.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1490948Ab1FFK4d convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 6 Jun 2011 12:56:33 +0200
Received: from [10.9.200.133] by MMS3.broadcom.com with ESMTP (Broadcom
 SMTP Relay (Email Firewall v6.3.2)); Mon, 06 Jun 2011 03:59:46 -0700
X-Server-Uuid: B55A25B1-5D7D-41F8-BC53-C57E7AD3C201
Received: from mail-irva-13.broadcom.com (10.11.16.103) by
 IRVEXCHHUB02.corp.ad.broadcom.com (10.9.200.133) with Microsoft SMTP
 Server id 8.2.247.2; Mon, 6 Jun 2011 03:55:40 -0700
Received: from mail-sj1-12.sj.broadcom.com (mail-sj1-12.sj.broadcom.com
 [10.17.16.106]) by mail-irva-13.broadcom.com (Postfix) with ESMTP id
 A740574D03; Mon, 6 Jun 2011 03:55:49 -0700 (PDT)
Received: from [192.168.1.120] (unknown [10.176.68.21]) by
 mail-sj1-12.sj.broadcom.com (Postfix) with ESMTP id 1CD2A20501; Mon, 6
 Jun 2011 03:55:47 -0700 (PDT)
Message-ID: <4DECB232.70308@broadcom.com>
Date:   Mon, 6 Jun 2011 12:55:46 +0200
From:   "Arend van Spriel" <arend@broadcom.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.2.17)
 Gecko/20110424 Thunderbird/3.1.10
MIME-Version: 1.0
To:     =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
cc:     "George Kashperko" <george@znau.edu.ua>,
        "Hauke Mehrtens" <hauke@hauke-m.de>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        "mb@bu3sch.de" <mb@bu3sch.de>,
        "b43-dev@lists.infradead.org" <b43-dev@lists.infradead.org>,
        "bernhardloos@googlemail.com" <bernhardloos@googlemail.com>
Subject: Re: [RFC][PATCH 03/10] bcma: add embedded bus
References: <1307311658-15853-1-git-send-email-hauke@hauke-m.de>
 <1307311658-15853-4-git-send-email-hauke@hauke-m.de>
 <BANLkTi=T6xO9q+vOCk5Fu+2J_nUTwX3dcg@mail.gmail.com>
 <1307356322.28734.11.camel@dev.znau.edu.ua>
 <BANLkTimkKFAEfbKaWo81=uyuDS=gjESHAw@mail.gmail.com>
In-Reply-To: <BANLkTimkKFAEfbKaWo81=uyuDS=gjESHAw@mail.gmail.com>
X-WSS-ID: 61F26CA84NS16627110-01-01
Content-Type: text/plain;
 charset=utf-8;
 format=flowed
Content-Transfer-Encoding: 8BIT
X-archive-position: 30249
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: arend@broadcom.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 4109

On 06/06/2011 12:51 PM, Rafał Miłecki wrote:
> W dniu 6 czerwca 2011 12:32 użytkownik George Kashperko
> <george@znau.edu.ua>  napisał:
>> Hi,
>>
>>> Hauke,
>>>
>>> My idea for naming schema was to use:
>>> bcma_host_TYPE_*
>>>
>>> Like:
>>> bcma_host_pci_*
>>> bcma_host_sdio_*
>>>
>>> You are using:
>>> bcma_host_bcma_*
>>>
>>> What do you think about changing this to:
>>> bcma_host_embedded_*
>>> or just some:
>>> bcma_host_emb_*
>>> ?
>>>
>>> Does it make more sense to you? I was trying to keep names in bcma
>>> really clear, so every first-time-reader can see differences between
>>> hosts, host and driver, etc.
>> how about bcma_host_soc ?
> We get then inconsistency with "BCMA_HOSTTYPE_EMBEDDED". I'd like to
> 1) See something like bcma_host_emb...
> xor
> 2) Use bcma_host_soc_* and BCMA_HOSTTYPE_SOC
>

I would go for option 2). It more clearly says what it is. Embedded is a 
broader term. As an example, a handset is an embedded device, but it may 
use BCMA_HOSTTYPE_SDIO.

Gr. AvS

-- 
Almost nobody dances sober, unless they happen to be insane.
-- H.P. Lovecraft --
