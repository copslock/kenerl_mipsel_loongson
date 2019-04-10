Return-Path: <SRS0=erdp=SM=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC01DC10F11
	for <linux-mips@archiver.kernel.org>; Wed, 10 Apr 2019 09:42:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1D042083E
	for <linux-mips@archiver.kernel.org>; Wed, 10 Apr 2019 09:42:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TWtVO52D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728743AbfDJJmH (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Wed, 10 Apr 2019 05:42:07 -0400
Received: from mail-ot1-f42.google.com ([209.85.210.42]:41198 "EHLO
        mail-ot1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726699AbfDJJmH (ORCPT
        <rfc822;linux-mips@vger.kernel.org>); Wed, 10 Apr 2019 05:42:07 -0400
Received: by mail-ot1-f42.google.com with SMTP id 64so1317337otb.8
        for <linux-mips@vger.kernel.org>; Wed, 10 Apr 2019 02:42:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=JWm5zHXx0kIEn9hiBSIpsH4dIGujforKX5qE5IH+PYc=;
        b=TWtVO52DzjJGny8sJEMFTqCDlTsHIG/bTzp1XyBu+z6tMgIe/9nzilUvsvIeBRta2+
         eynt3qWwzXw1uUgHTYjEaNOtVzx1DMfKouzmjpgp/dGkAoYK0kUEn4zx8uU1hWVgVpVs
         wrKNOaCXZo7ABI7r8VN53WlZKmlqILLn6lpSO/IQAZjQg0QFmlZQ6s9XIdjCJRoO2ysC
         YtX1OWajQIBzbcA8axIaUMszetOypjeNn1EMHsLRpNV+Ik3eHmFAP52XeYob1rHMvdsT
         OAiR7bd3hrBu/A/6fX4ValjQ/PY6n7YpDD2HLlnVWbjZpY0Knw1mZPxpFXYYTdGjQ6OO
         /TUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=JWm5zHXx0kIEn9hiBSIpsH4dIGujforKX5qE5IH+PYc=;
        b=mUqeriCTg2BPeY0lfmqm7ZoTisiIZurCiW7B6kAGINPeYNXTaMUpBpIo/qiD/aIBiH
         H3SJbNuU3j3wOQOCiwcAd1mzorCmqIxV1EbjEpkP39CNQTVsCTrmb1alTdf+kXzqC4gZ
         Q6c8N7lJ4t6LM7i/KPDYznGF4rjHl7JoSicZGSzLF8SDgiR3iBA88oNQerZj8FVUiy7E
         NnSc+ma8eF6R8pKrHFYEqdXKyi7/QQvylhYeJBGCYk9CNVJKZlCcWt5uvTc1iRkDTWgA
         EjjXBfrO13PF4OOcu/UUOX1Uh3VzfjWFdaYC54Oxn+i3kWPPc7cPVMYTG4D0gDA8rFdi
         HGaw==
X-Gm-Message-State: APjAAAV/qkhM+dVeEfmJo/2eKEivxnQWWA4Yj5bMOgyBMdc2fvuUs7AA
        Jv8xPTDvQz9cLjKRNNo9dFsHpMBb1tHpO/ZOJJGmAQ==
X-Google-Smtp-Source: APXvYqx5vg7mMl4iDmpNyrXVSHU+32/Hrqv0wXQ71W2jHxzsjEFhLIEamanH+73m61psNhVoXdRSwLOqoNRxHA9zJ0Q=
X-Received: by 2002:a9d:459e:: with SMTP id x30mr20303151ote.233.1554889326400;
 Wed, 10 Apr 2019 02:42:06 -0700 (PDT)
MIME-Version: 1.0
References: <20190410081124.Horde.6-W5VZY62-uScLlme86cCYa@www.vdorst.com>
In-Reply-To: <20190410081124.Horde.6-W5VZY62-uScLlme86cCYa@www.vdorst.com>
From:   Chuanhong Guo <gch981213@gmail.com>
Date:   Wed, 10 Apr 2019 17:41:55 +0800
Message-ID: <CAJsYDVJvviz8a2oVmb0XL3OB+=Eecu-3kC9T9vsmxpuC_BqDSA@mail.gmail.com>
Subject: Re: MIPS: ralink: fix cpu clock of mt7621 and add dt clk devices,
 mt7621-clk.h is missing
To:     =?UTF-8?Q?Ren=C3=A9_van_Dorst?= <opensource@vdorst.com>
Cc:     Paul Burton <paul.burton@mips.com>, linux-mips@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

Hi!

On Wed, Apr 10, 2019 at 4:11 PM Ren=C3=A9 van Dorst <opensource@vdorst.com>=
 wrote:
>
> Hi Chuanhong,
>
> I tried your patch but include/dt-bindings/clock/mt7621-clk.h is missing.

Sorry. I forgot to add that into my commit :(
BTW I think that file needs to be in a separate commit and send to
device-tree mailing list instead anyway.

>
> See the original patch.
> https://github.com/lede-project/source/blob/master/target/linux/ramips/pa=
tches-4.14/102-mt7621-fix-cpu-clk-add-clkdev.patch#L205
>
> Can you send an other patch to fix that?

Will do so with some patches for drivers/staging/mt7621-dts when have
some free time.

>
> Greats,
>
> Ren=C3=A9
>
