Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 21 May 2015 12:16:26 +0200 (CEST)
Received: from smtp.codeaurora.org ([198.145.29.96]:35727 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27012377AbbEUKQYNbCRq convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 21 May 2015 12:16:24 +0200
Received: from smtp.codeaurora.org (localhost [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id 0468C140FD7;
        Thu, 21 May 2015 10:16:24 +0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 486)
        id C8B98140FCD; Thu, 21 May 2015 10:16:23 +0000 (UTC)
Received: from potku.adurom.net (a88-115-185-251.elisa-laajakaista.fi [88.115.185.251])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 80943140FCD;
        Thu, 21 May 2015 10:16:21 +0000 (UTC)
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Arend van Spriel <arend@broadcom.com>
Cc:     =?utf-8?Q?Rafa=C5=82_Mi=C5=82ecki?= <zajec5@gmail.com>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        Hante Meuleman <meuleman@broadcom.com>,
        "linux-mips\@linux-mips.org" <linux-mips@linux-mips.org>,
        Hauke Mehrtens <hauke@hauke-m.de>
Subject: Re: [PATCH 6/6] brcmfmac: Add support for host platform NVRAM loading.
References: <1432123792-4155-1-git-send-email-arend@broadcom.com>
        <1432123792-4155-7-git-send-email-arend@broadcom.com>
        <CACna6ryt5uNkBXAk8chFyMEQVJLdHELLdA_V5TrLcaAikrTZeg@mail.gmail.com>
        <CACna6ryCgOwkj_nt6Gd1+r826OJu-suPk50YAS1eRVW+kkR7fQ@mail.gmail.com>
        <555DA529.6000901@broadcom.com>
Date:   Thu, 21 May 2015 13:16:15 +0300
In-Reply-To: <555DA529.6000901@broadcom.com> (Arend van Spriel's message of
        "Thu, 21 May 2015 11:28:09 +0200")
Message-ID: <87vbfm6xsg.fsf@kamboji.qca.qualcomm.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Virus-Scanned: ClamAV using ClamSMTP
Return-Path: <kvalo@codeaurora.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47511
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kvalo@codeaurora.org
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

Arend van Spriel <arend@broadcom.com> writes:

> On 05/21/15 10:28, Rafał Miłecki wrote:
>> On 20 May 2015 at 16:33, Rafał Miłecki<zajec5@gmail.com>  wrote:
>>> I think the best way for achieving this is to rework your patch to
>>> modify include/linux/bcm47xx_nvram.h. You could modify it the same way
>>> you did in your patch for MIPS tree, except for
>>> bcm47xx_nvram_get_contents. Don't implement this function for real (in
>>> .c file), but instead make in dummy inline in a bcm47xx_nvram.h like:
>>> static inline char *bcm47xx_nvram_get_contents(size_t *val_len)
>>> {
>>>          /* TODO: Implement in .c file */
>>>          return NULL;
>>> }
>>
>> One more note.
>> This of course will lead to conflict at some point, but I believe
>> Linus will handle it.
>
> I prefer to avoid tricks so I will ask to drop this patch and wait for
> it to land in the next kernel, ie. 4.2, and resubmit this patch for
> 4.3. I am not in a hurry.

Yes, please :) Let's try to avoid conflicts as much as possible.

-- 
Kalle Valo
