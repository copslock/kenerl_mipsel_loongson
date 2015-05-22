Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 22 May 2015 11:05:25 +0200 (CEST)
Received: from mail-ie0-f176.google.com ([209.85.223.176]:35891 "EHLO
        mail-ie0-f176.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27006608AbbEVJFXr1n0C convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 22 May 2015 11:05:23 +0200
Received: by iepj10 with SMTP id j10so26787858iep.3
        for <linux-mips@linux-mips.org>; Fri, 22 May 2015 02:05:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=Q+5QB+rDoGFD0q75MGcgxhd29Y7CoYdZOlh66WBesxo=;
        b=LFlavFNvKJ9SsRr4/V50/jMov5wAINoa7zMD+9loWEDk7mkzrn2J+gaFzLBkWbiycT
         pZOwfinSfPF3DEYihaemt2JZS6Lx16GIWlJsLy45zsl5lseTTCOHT6oPglpPL6bh2JN/
         zKmninqp65pEvgqhUSLm8jHArJZhOMF4DNUaCfpUTDgPyVoC+xSW0drE5zFxE32/mkj3
         AjMPD9XiGDTqD+tnnUQisigD4xw/xlz8Sf2C9OMgoiPJ+J5N2OoErQTZIe2zIZastft5
         Ntj6KuHQ4LWzB/lJsRILamQYpkEvxCNDl1tAT/GzFMIJZ6R1/OakRAm6t2170qyWjkQT
         PbUg==
MIME-Version: 1.0
X-Received: by 10.50.138.74 with SMTP id qo10mr4163054igb.39.1432285520351;
 Fri, 22 May 2015 02:05:20 -0700 (PDT)
Received: by 10.107.36.73 with HTTP; Fri, 22 May 2015 02:05:20 -0700 (PDT)
In-Reply-To: <555EE972.7040801@broadcom.com>
References: <1432123792-4155-1-git-send-email-arend@broadcom.com>
        <1432123792-4155-7-git-send-email-arend@broadcom.com>
        <CACna6rx_bBogPXZoa24JTqLED4GsGhezjVLZL_De=2uTqevsPA@mail.gmail.com>
        <555EE972.7040801@broadcom.com>
Date:   Fri, 22 May 2015 11:05:20 +0200
Message-ID: <CACna6rx3PK9SH44BUDqKTWcWkvpVeGSfbL5Jm31Zj26O=8KK-Q@mail.gmail.com>
Subject: Re: [PATCH 6/6] brcmfmac: Add support for host platform NVRAM loading.
From:   =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
To:     Arend van Spriel <arend@broadcom.com>
Cc:     Kalle Valo <kvalo@codeaurora.org>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        Hante Meuleman <meuleman@broadcom.com>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-Path: <zajec5@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47548
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

On 22 May 2015 at 10:31, Arend van Spriel <arend@broadcom.com> wrote:
> On 05/20/15 17:02, Rafał Miłecki wrote:
>>
>> On 20 May 2015 at 14:09, Arend van Spriel<arend@broadcom.com>  wrote:
>>>
>>> @@ -139,11 +165,11 @@ brcmf_nvram_handle_value(struct nvram_parser *nvp)
>>>          char *ekv;
>>>          u32 cplen;
>>>
>>> -       c = nvp->fwnv->data[nvp->pos];
>>> -       if (!is_nvram_char(c)) {
>>> +       c = nvp->data[nvp->pos];
>>> +       if (!is_nvram_char(c)&&  (c != ' ')) {
>>
>>
>> Don't smuggle behavior changes in patches doing something else!
>
>
> The subject is "Add support for host platform NVRAM loading" and guess what.
> That type of NVRAM turned out to have spaces in the entries so in my opinion
> it is related to this patch. I can split it up if you feel strongly about
> this.

I'd expect such patch to just implement *loading* from different
source and nothing else. If there are additional changes needed, I
think they should go in separated patch if possible.

I noticed the same problem with parsing NVRAM values and sent
[PATCH] brcmfmac: allow NVRAM values to contain space and '#' chars
, so you should be able to drop this patch of your patch anyway.
You may give me an Ack if you have a moment :)


>>> @@ -406,19 +434,34 @@ static void brcmf_fw_request_nvram_done(const
>>> struct firmware *fw, void *ctx)
>>>          struct brcmf_fw *fwctx = ctx;
>>>          u32 nvram_length = 0;
>>>          void *nvram = NULL;
>>> +       u8 *data = NULL;
>>> +       size_t data_len;
>>> +       bool raw_nvram;
>>>
>>>          brcmf_dbg(TRACE, "enter: dev=%s\n", dev_name(fwctx->dev));
>>> -       if (!fw&&  !(fwctx->flags&  BRCMF_FW_REQ_NV_OPTIONAL))
>>> -               goto fail;
>>> +       if ((fw)&&  (fw->data)) {
>>
>>
>> if (fw&&  fw->data)
>> will work just fine, I'm surprised checkpatch doesn't complain.
>
> I ran checkpatch.pl --strict and did not get complaint about this change.

I know, it's weird. Maybe I'll report this an improvement idea to
checkpatch maintainer.

-- 
Rafał
