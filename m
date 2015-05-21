Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 21 May 2015 11:28:19 +0200 (CEST)
Received: from mail-gw1-out.broadcom.com ([216.31.210.62]:25103 "EHLO
        mail-gw1-out.broadcom.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27012377AbbEUJ2Q6hiGN (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 21 May 2015 11:28:16 +0200
X-IronPort-AV: E=Sophos;i="5.13,467,1427785200"; 
   d="scan'208";a="65599363"
Received: from irvexchcas08.broadcom.com (HELO IRVEXCHCAS08.corp.ad.broadcom.com) ([10.9.208.57])
  by mail-gw1-out.broadcom.com with ESMTP; 21 May 2015 03:07:37 -0700
Received: from IRVEXCHSMTP2.corp.ad.broadcom.com (10.9.207.52) by
 IRVEXCHCAS08.corp.ad.broadcom.com (10.9.208.57) with Microsoft SMTP Server
 (TLS) id 14.3.235.1; Thu, 21 May 2015 02:28:11 -0700
Received: from mail-sj1-12.sj.broadcom.com (10.10.10.20) by
 IRVEXCHSMTP2.corp.ad.broadcom.com (10.9.207.52) with Microsoft SMTP Server id
 14.3.235.1; Thu, 21 May 2015 02:28:11 -0700
Received: from [10.176.128.60] (xl-bun-02.bun.broadcom.com [10.176.128.60])     by
 mail-sj1-12.sj.broadcom.com (Postfix) with ESMTP id 84F3527A82;        Thu, 21 May
 2015 02:28:10 -0700 (PDT)
Message-ID: <555DA529.6000901@broadcom.com>
Date:   Thu, 21 May 2015 11:28:09 +0200
From:   Arend van Spriel <arend@broadcom.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686 (x86_64); en-US; rv:1.9.2.24) Gecko/20111103 Lightning/1.0b2 Thunderbird/3.1.16
MIME-Version: 1.0
To:     =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
CC:     Kalle Valo <kvalo@codeaurora.org>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        Hante Meuleman <meuleman@broadcom.com>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        Hauke Mehrtens <hauke@hauke-m.de>
Subject: Re: [PATCH 6/6] brcmfmac: Add support for host platform NVRAM loading.
References: <1432123792-4155-1-git-send-email-arend@broadcom.com>       <1432123792-4155-7-git-send-email-arend@broadcom.com>   <CACna6ryt5uNkBXAk8chFyMEQVJLdHELLdA_V5TrLcaAikrTZeg@mail.gmail.com> <CACna6ryCgOwkj_nt6Gd1+r826OJu-suPk50YAS1eRVW+kkR7fQ@mail.gmail.com>
In-Reply-To: <CACna6ryCgOwkj_nt6Gd1+r826OJu-suPk50YAS1eRVW+kkR7fQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
Return-Path: <arend@broadcom.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47508
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

On 05/21/15 10:28, Rafał Miłecki wrote:
> On 20 May 2015 at 16:33, Rafał Miłecki<zajec5@gmail.com>  wrote:
>> I think the best way for achieving this is to rework your patch to
>> modify include/linux/bcm47xx_nvram.h. You could modify it the same way
>> you did in your patch for MIPS tree, except for
>> bcm47xx_nvram_get_contents. Don't implement this function for real (in
>> .c file), but instead make in dummy inline in a bcm47xx_nvram.h like:
>> static inline char *bcm47xx_nvram_get_contents(size_t *val_len)
>> {
>>          /* TODO: Implement in .c file */
>>          return NULL;
>> }
>
> One more note.
> This of course will lead to conflict at some point, but I believe
> Linus will handle it.

I prefer to avoid tricks so I will ask to drop this patch and wait for 
it to land in the next kernel, ie. 4.2, and resubmit this patch for 4.3. 
I am not in a hurry.

Regards,
Arend
