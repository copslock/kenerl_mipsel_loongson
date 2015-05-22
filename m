Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 22 May 2015 11:20:25 +0200 (CEST)
Received: from mail-gw3-out.broadcom.com ([216.31.210.64]:37665 "EHLO
        mail-gw3-out.broadcom.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27026776AbbEVJUX2Z19i (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 22 May 2015 11:20:23 +0200
X-IronPort-AV: E=Sophos;i="5.13,474,1427785200"; 
   d="scan'208";a="65407939"
Received: from irvexchcas08.broadcom.com (HELO IRVEXCHCAS08.corp.ad.broadcom.com) ([10.9.208.57])
  by mail-gw3-out.broadcom.com with ESMTP; 22 May 2015 02:30:32 -0700
Received: from IRVEXCHSMTP2.corp.ad.broadcom.com (10.9.207.52) by
 IRVEXCHCAS08.corp.ad.broadcom.com (10.9.208.57) with Microsoft SMTP Server
 (TLS) id 14.3.235.1; Fri, 22 May 2015 02:20:18 -0700
Received: from mail-sj1-12.sj.broadcom.com (10.10.10.20) by
 IRVEXCHSMTP2.corp.ad.broadcom.com (10.9.207.52) with Microsoft SMTP Server id
 14.3.235.1; Fri, 22 May 2015 02:20:18 -0700
Received: from [10.176.128.60] (xl-bun-02.bun.broadcom.com [10.176.128.60])     by
 mail-sj1-12.sj.broadcom.com (Postfix) with ESMTP id 2726E27A81;        Fri, 22 May
 2015 02:20:16 -0700 (PDT)
Message-ID: <555EF4D0.3070302@broadcom.com>
Date:   Fri, 22 May 2015 11:20:16 +0200
From:   Arend van Spriel <arend@broadcom.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686 (x86_64); en-US; rv:1.9.2.24) Gecko/20111103 Lightning/1.0b2 Thunderbird/3.1.16
MIME-Version: 1.0
To:     =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
CC:     Kalle Valo <kvalo@codeaurora.org>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        Hante Meuleman <meuleman@broadcom.com>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
Subject: Re: [PATCH 6/6] brcmfmac: Add support for host platform NVRAM loading.
References: <1432123792-4155-1-git-send-email-arend@broadcom.com>       <1432123792-4155-7-git-send-email-arend@broadcom.com>   <CACna6rx_bBogPXZoa24JTqLED4GsGhezjVLZL_De=2uTqevsPA@mail.gmail.com>    <555EE972.7040801@broadcom.com> <CACna6rx3PK9SH44BUDqKTWcWkvpVeGSfbL5Jm31Zj26O=8KK-Q@mail.gmail.com>
In-Reply-To: <CACna6rx3PK9SH44BUDqKTWcWkvpVeGSfbL5Jm31Zj26O=8KK-Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
Return-Path: <arend@broadcom.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47549
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

On 05/22/15 11:05, Rafał Miłecki wrote:
> On 22 May 2015 at 10:31, Arend van Spriel<arend@broadcom.com>  wrote:
>> On 05/20/15 17:02, Rafał Miłecki wrote:
>>>
>>> On 20 May 2015 at 14:09, Arend van Spriel<arend@broadcom.com>   wrote:
>>>>
>>>> @@ -139,11 +165,11 @@ brcmf_nvram_handle_value(struct nvram_parser *nvp)
>>>>           char *ekv;
>>>>           u32 cplen;
>>>>
>>>> -       c = nvp->fwnv->data[nvp->pos];
>>>> -       if (!is_nvram_char(c)) {
>>>> +       c = nvp->data[nvp->pos];
>>>> +       if (!is_nvram_char(c)&&   (c != ' ')) {
>>>
>>>
>>> Don't smuggle behavior changes in patches doing something else!
>>
>>
>> The subject is "Add support for host platform NVRAM loading" and guess what.
>> That type of NVRAM turned out to have spaces in the entries so in my opinion
>> it is related to this patch. I can split it up if you feel strongly about
>> this.
>
> I'd expect such patch to just implement *loading* from different
> source and nothing else. If there are additional changes needed, I
> think they should go in separated patch if possible.
>
> I noticed the same problem with parsing NVRAM values and sent
> [PATCH] brcmfmac: allow NVRAM values to contain space and '#' chars
> , so you should be able to drop this patch of your patch anyway.
> You may give me an Ack if you have a moment :)

Whoops. I did not :-p I don't want to deal with '#' in value field as it 
is either invalid or irrelevant to firmware on the device.

Regards,
Arend

>>>> @@ -406,19 +434,34 @@ static void brcmf_fw_request_nvram_done(const
>>>> struct firmware *fw, void *ctx)
>>>>           struct brcmf_fw *fwctx = ctx;
>>>>           u32 nvram_length = 0;
>>>>           void *nvram = NULL;
>>>> +       u8 *data = NULL;
>>>> +       size_t data_len;
>>>> +       bool raw_nvram;
>>>>
>>>>           brcmf_dbg(TRACE, "enter: dev=%s\n", dev_name(fwctx->dev));
>>>> -       if (!fw&&   !(fwctx->flags&   BRCMF_FW_REQ_NV_OPTIONAL))
>>>> -               goto fail;
>>>> +       if ((fw)&&   (fw->data)) {
>>>
>>>
>>> if (fw&&   fw->data)
>>> will work just fine, I'm surprised checkpatch doesn't complain.
>>
>> I ran checkpatch.pl --strict and did not get complaint about this change.
>
> I know, it's weird. Maybe I'll report this an improvement idea to
> checkpatch maintainer.
>
