Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 14 Aug 2015 16:56:06 +0200 (CEST)
Received: from mail-gw1-out.broadcom.com ([216.31.210.62]:49678 "EHLO
        mail-gw1-out.broadcom.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011859AbbHNO4FQFwDF (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 14 Aug 2015 16:56:05 +0200
X-IronPort-AV: E=Sophos;i="5.15,678,1432623600"; 
   d="scan'208";a="72614131"
Received: from irvexchcas06.broadcom.com (HELO IRVEXCHCAS06.corp.ad.broadcom.com) ([10.9.208.53])
  by mail-gw1-out.broadcom.com with ESMTP; 14 Aug 2015 09:17:53 -0700
Received: from IRVEXCHSMTP1.corp.ad.broadcom.com (10.9.207.51) by
 IRVEXCHCAS06.corp.ad.broadcom.com (10.9.208.53) with Microsoft SMTP Server
 (TLS) id 14.3.235.1; Fri, 14 Aug 2015 07:55:55 -0700
Received: from mail-sj1-12.sj.broadcom.com (10.10.10.20) by
 IRVEXCHSMTP1.corp.ad.broadcom.com (10.9.207.51) with Microsoft SMTP Server id
 14.3.235.1; Fri, 14 Aug 2015 07:55:55 -0700
Received: from [10.176.128.83] (bld-bun-01.bun.broadcom.com [10.176.128.83])
        by mail-sj1-12.sj.broadcom.com (Postfix) with ESMTP id 825B127A81;      Fri, 14
 Aug 2015 07:55:54 -0700 (PDT)
Message-ID: <55CE0179.3010205@broadcom.com>
Date:   Fri, 14 Aug 2015 16:55:53 +0200
From:   Arend van Spriel <arend@broadcom.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
MIME-Version: 1.0
To:     "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
CC:     "Maciej W. Rozycki" <macro@linux-mips.org>,
        Florian Fainelli <f.fainelli@gmail.com>
Subject: Re: [4.2-rc4] recurring build issue
References: <55CB03D2.6080404@broadcom.com>
In-Reply-To: <55CB03D2.6080404@broadcom.com>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <arend@broadcom.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48894
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

+ LKML

On 08/12/2015 10:29 AM, Arend van Spriel wrote:
> A while ago we faced a build issue for MIPS architecture (see attached
> config) and someone (forgot who) provided reference to following patch
> which fixed the issue so I applied it in our repo.
>
> commit cd532e6356425fef41f25c31411867cf80d7541b
> Author: Maciej W. Rozycki <macro@linux-mips.org>
> Date:   Sun May 3 10:36:19 2015 +0100
>
>      MIPS: pgtable-bits.h: Correct _PAGE_GLOBAL_SHIFT build failure
>
>      Correct a build failure introduced by be0c37c9 [MIPS: Rearrange PTE
> bits
>      into fixed positions.]:
>
> With a merge of 4.2-rc4 those changes were lost and the build issue was
> back. Is there any chance the patch will be posted upstream in some
> form. For now I reapplied the patch, but would like to get rid of that
> type of maintenance.

Ping? Any reaction from mips community? My knowledge about MIPS 
architecture is next to nil so try to avoid fiddling with it myself.

Regards,
Arend
