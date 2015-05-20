Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 20 May 2015 17:02:11 +0200 (CEST)
Received: from mail-ig0-f175.google.com ([209.85.213.175]:35945 "EHLO
        mail-ig0-f175.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27026450AbbETPCKJEWff (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 20 May 2015 17:02:10 +0200
Received: by igbpi8 with SMTP id pi8so104589742igb.1
        for <linux-mips@linux-mips.org>; Wed, 20 May 2015 08:02:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=gghg0wRH09gf/h19f9G8hR78ZJrSWviRsG86UmJ0QJE=;
        b=nrCc6HJDQ047updTS6LFfKFbJqVd8Sw+/V0kibJTPjteW+2h/SuiIRsTEA3OXUxy+8
         Yt7Pq4yw4Tn0u2YQrKZ4280XXdHMRYj5L0eRh1ZbB/R4hMQffIIP6ZDUz50Fxh/1RbL4
         5snHGloq3Fnekhr6RXHroECmvXXqURZgs2gZVVYCwIMHfumo2PMWsP+cePMkP1QvVaUs
         d4LbcwwF2IajS2lqL0v4WlLKkzkZK9jWfGDO4Riqm9wtJzgrIQdrU64dQcYAI2iXhQsK
         e4L8Nsb601NmYeDz+TGJy3JyEf1HrIsIp6C5eIUJnQMCnDHNfMVasBk2XfDbj7NGg7Vf
         Iy2A==
MIME-Version: 1.0
X-Received: by 10.107.31.134 with SMTP id f128mr6264448iof.19.1432134125764;
 Wed, 20 May 2015 08:02:05 -0700 (PDT)
Received: by 10.107.36.73 with HTTP; Wed, 20 May 2015 08:02:05 -0700 (PDT)
In-Reply-To: <1432123792-4155-7-git-send-email-arend@broadcom.com>
References: <1432123792-4155-1-git-send-email-arend@broadcom.com>
        <1432123792-4155-7-git-send-email-arend@broadcom.com>
Date:   Wed, 20 May 2015 17:02:05 +0200
Message-ID: <CACna6rx_bBogPXZoa24JTqLED4GsGhezjVLZL_De=2uTqevsPA@mail.gmail.com>
Subject: Re: [PATCH 6/6] brcmfmac: Add support for host platform NVRAM loading.
From:   =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
To:     Arend van Spriel <arend@broadcom.com>
Cc:     Kalle Valo <kvalo@codeaurora.org>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        Hante Meuleman <meuleman@broadcom.com>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <zajec5@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47499
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

On 20 May 2015 at 14:09, Arend van Spriel <arend@broadcom.com> wrote:
> @@ -139,11 +165,11 @@ brcmf_nvram_handle_value(struct nvram_parser *nvp)
>         char *ekv;
>         u32 cplen;
>
> -       c = nvp->fwnv->data[nvp->pos];
> -       if (!is_nvram_char(c)) {
> +       c = nvp->data[nvp->pos];
> +       if (!is_nvram_char(c) && (c != ' ')) {

Don't smuggle behavior changes in patches doing something else!


> @@ -406,19 +434,34 @@ static void brcmf_fw_request_nvram_done(const struct firmware *fw, void *ctx)
>         struct brcmf_fw *fwctx = ctx;
>         u32 nvram_length = 0;
>         void *nvram = NULL;
> +       u8 *data = NULL;
> +       size_t data_len;
> +       bool raw_nvram;
>
>         brcmf_dbg(TRACE, "enter: dev=%s\n", dev_name(fwctx->dev));
> -       if (!fw && !(fwctx->flags & BRCMF_FW_REQ_NV_OPTIONAL))
> -               goto fail;
> +       if ((fw) && (fw->data)) {

if (fw && fw->data)
will work just fine, I'm surprised checkpatch doesn't complain.
