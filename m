Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 21 May 2015 11:32:33 +0200 (CEST)
Received: from mail-ig0-f170.google.com ([209.85.213.170]:37326 "EHLO
        mail-ig0-f170.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27012377AbbEUJcbzEx4N convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 21 May 2015 11:32:31 +0200
Received: by igbsb11 with SMTP id sb11so4167404igb.0
        for <linux-mips@linux-mips.org>; Thu, 21 May 2015 02:32:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=g5D1AM3ZaTpH+5z/54ulTEMVn/iQMAmZscoemEhPeHI=;
        b=CE/54M16pu4LWmjUFDq+H6iYB6aKwU4dQJ7MjI5vMsEplRNtKVCKifSzqyg4XM5YJH
         1iY9Fis2K5YCxrMMcjHa6GTr5QsNm/yucuZXIyC/S/3Znip/TA+N413jcqQocwvlyCX7
         GUuLYB3YT0v52Q0FvERALEgJ7W4FKqBMZLg1MgSu3uHu+5U5VSUCgYVVRr+SWu7dxce/
         dXHco8H3WGgdnzfaf8sDwsnuZ1Nt5jqOW6i5SvW7d9AuxHiMVbKIz1Yw8WiKyTl6D8JA
         Kc+QnJaRIL6dqcf8U8O7UUaBvmN1EoDTq3PhCSi/wpVRwU4sPgJqzlQNIDi0T8c512r6
         21pA==
MIME-Version: 1.0
X-Received: by 10.107.31.134 with SMTP id f128mr2131190iof.19.1432200748776;
 Thu, 21 May 2015 02:32:28 -0700 (PDT)
Received: by 10.107.36.73 with HTTP; Thu, 21 May 2015 02:32:28 -0700 (PDT)
In-Reply-To: <555DA529.6000901@broadcom.com>
References: <1432123792-4155-1-git-send-email-arend@broadcom.com>
        <1432123792-4155-7-git-send-email-arend@broadcom.com>
        <CACna6ryt5uNkBXAk8chFyMEQVJLdHELLdA_V5TrLcaAikrTZeg@mail.gmail.com>
        <CACna6ryCgOwkj_nt6Gd1+r826OJu-suPk50YAS1eRVW+kkR7fQ@mail.gmail.com>
        <555DA529.6000901@broadcom.com>
Date:   Thu, 21 May 2015 11:32:28 +0200
Message-ID: <CACna6rzEepucsrvZYecztOWKzMCV6YAmycWMS4jOBdaT4UJWDw@mail.gmail.com>
Subject: Re: [PATCH 6/6] brcmfmac: Add support for host platform NVRAM loading.
From:   =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
To:     Arend van Spriel <arend@broadcom.com>
Cc:     Kalle Valo <kvalo@codeaurora.org>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        Hante Meuleman <meuleman@broadcom.com>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        Hauke Mehrtens <hauke@hauke-m.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-Path: <zajec5@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47510
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: zajec5@gmail.com
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

On 21 May 2015 at 11:28, Arend van Spriel <arend@broadcom.com> wrote:
> On 05/21/15 10:28, Rafał Miłecki wrote:
>>
>> On 20 May 2015 at 16:33, Rafał Miłecki<zajec5@gmail.com>  wrote:
>>>
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
>>
>> One more note.
>> This of course will lead to conflict at some point, but I believe
>> Linus will handle it.
>
>
> I prefer to avoid tricks so I will ask to drop this patch and wait for it to
> land in the next kernel, ie. 4.2, and resubmit this patch for 4.3. I am not
> in a hurry.

OK :)

-- 
Rafał
