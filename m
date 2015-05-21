Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 21 May 2015 10:28:34 +0200 (CEST)
Received: from mail-ig0-f178.google.com ([209.85.213.178]:36504 "EHLO
        mail-ig0-f178.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011608AbbEUI2cxDWUP convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 21 May 2015 10:28:32 +0200
Received: by igbpi8 with SMTP id pi8so4014996igb.1
        for <linux-mips@linux-mips.org>; Thu, 21 May 2015 01:28:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=Soru/grKlevOI4IeXPRRO0kRNTHl4iW4XEu5XZRE1K4=;
        b=oNMDQdf4DWrKwk2esvsemYPw1kxfYsvyya+dK7ZHwsHIDPUdWXHyfQwoNKLQbkhhni
         QqyIcNvoLua8mn+9T9cugJ1rZwA/LUcevDFIkf9aeT1jXMABSdskX8j8PFNHdWdmtD3i
         QNpfOeiulLI8NZhx4TBG89EDBYk8hewn0TGVazKfglQNKZzsmUKc58C0TcLS1GL0PFhD
         VaH1ib8WtqHUq5IQvwW8dNBkxeFmDtcPTCIxD68uJmab6DuxYHmx/R2jBVCBDXTJWB9n
         oOxfUhG2ajOJdQDrgfSoCmvsYZwpXnuasrs/9pp4dyLB3OZzGb5pwYxNm+y2vrgYP/gq
         Z06Q==
MIME-Version: 1.0
X-Received: by 10.107.158.15 with SMTP id h15mr1972645ioe.14.1432196909515;
 Thu, 21 May 2015 01:28:29 -0700 (PDT)
Received: by 10.107.36.73 with HTTP; Thu, 21 May 2015 01:28:29 -0700 (PDT)
In-Reply-To: <CACna6ryt5uNkBXAk8chFyMEQVJLdHELLdA_V5TrLcaAikrTZeg@mail.gmail.com>
References: <1432123792-4155-1-git-send-email-arend@broadcom.com>
        <1432123792-4155-7-git-send-email-arend@broadcom.com>
        <CACna6ryt5uNkBXAk8chFyMEQVJLdHELLdA_V5TrLcaAikrTZeg@mail.gmail.com>
Date:   Thu, 21 May 2015 10:28:29 +0200
Message-ID: <CACna6ryCgOwkj_nt6Gd1+r826OJu-suPk50YAS1eRVW+kkR7fQ@mail.gmail.com>
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
X-archive-position: 47506
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

On 20 May 2015 at 16:33, Rafał Miłecki <zajec5@gmail.com> wrote:
> I think the best way for achieving this is to rework your patch to
> modify include/linux/bcm47xx_nvram.h. You could modify it the same way
> you did in your patch for MIPS tree, except for
> bcm47xx_nvram_get_contents. Don't implement this function for real (in
> .c file), but instead make in dummy inline in a bcm47xx_nvram.h like:
> static inline char *bcm47xx_nvram_get_contents(size_t *val_len)
> {
>         /* TODO: Implement in .c file */
>         return NULL;
> }

One more note.
This of course will lead to conflict at some point, but I believe
Linus will handle it.

-- 
Rafał
