Return-Path: <SRS0=Alo4=OT=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5271C65BAF
	for <linux-mips@archiver.kernel.org>; Mon, 10 Dec 2018 08:05:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B01D2082F
	for <linux-mips@archiver.kernel.org>; Mon, 10 Dec 2018 08:05:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="V/cgfuVC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B01D2082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-mips-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726176AbeLJIFW (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Mon, 10 Dec 2018 03:05:22 -0500
Received: from mail-it1-f196.google.com ([209.85.166.196]:53121 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726592AbeLJIFU (ORCPT
        <rfc822;linux-mips@vger.kernel.org>); Mon, 10 Dec 2018 03:05:20 -0500
Received: by mail-it1-f196.google.com with SMTP id g76so16049173itg.2
        for <linux-mips@vger.kernel.org>; Mon, 10 Dec 2018 00:05:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QeB5TU8dkdrhQ+/voqyCldGbok3k4VlRyRCuw0NXPcA=;
        b=V/cgfuVCA7fcg7myVMup3fWM6xj71RtepV4oUs+DFdOCYVwD15EH/5qQpwUGiiEN/g
         /wiAsfeHwHdu8B2xsH77Q6KhU5sKseYnPRe3mkdVS5+Z3pk1+GVzS8T5zun9GVLN1aJs
         RA9Ni1eD+JrWSaC9GRHGeePCBCRjmK6U6Ufm8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QeB5TU8dkdrhQ+/voqyCldGbok3k4VlRyRCuw0NXPcA=;
        b=YXXcCgqUVYT5KxKT4ynN4ZjKgYDte3uR7iiLT6dlNdZYKV8KkVPP9XP3WTVZLNCHbB
         IX58X01UXMUu0cknjPsXk3ffghixMyNsOvOhFbIcdHOB+EqX5aGkCH4hpc89Icxm5lTR
         uGPM4iW5vGjcBVz27F4tBxEUaZCzUW8rpWgVlgwqxSavjuY2WOlGWFkF82Flh+V9nHW1
         kr7fgpI4JLUEo6qJyPAXMshAldpm9C2npZ4vO6UcJdd4MaSFIjaQnb7AlzKwu6gUYcKI
         CfWi1tCYgfBIB1Kjzf7OPkwGULR7qLNXL5E1uKRXgZPHWhWhNR4p6K5yMo+4lLBa21BV
         0cIQ==
X-Gm-Message-State: AA+aEWbBIp921au/+p167hPWag+qHokAp1yxhKZSNp29fhqelZ1l+uS/
        Y83VT5TyZOS9faKrKTw/Z6n0e2sEdCx1qgm5HaGIO/Vd
X-Google-Smtp-Source: AFSGD/XCrSDTRvnt65FKCFK2/vYfOYPGQHiJjGz5uBPpI4rAHpUDjOqAJOpOHYdVxsB+MaT/pUwW3BsMudNQDrv1Q/I=
X-Received: by 2002:a02:f42:: with SMTP id h63mr10657949jad.133.1544429119298;
 Mon, 10 Dec 2018 00:05:19 -0800 (PST)
MIME-Version: 1.0
References: <1544073508-13720-1-git-send-email-firoz.khan@linaro.org>
 <CALxhOninHsCiB7puVOkU3i6W9gfhGqAA6EDT0kAEC9ZqMZPh7w@mail.gmail.com> <20181210054116.2hq5ykjfh5itcvqk@pburton-laptop>
In-Reply-To: <20181210054116.2hq5ykjfh5itcvqk@pburton-laptop>
From:   Firoz Khan <firoz.khan@linaro.org>
Date:   Mon, 10 Dec 2018 13:35:08 +0530
Message-ID: <CALxhOnjWQRgE3rmoLr=J51Babys48kw5D6QiNF44mw=rY_AkjQ@mail.gmail.com>
Subject: Re: [PATCH v4 0/7] mips: system call table generation support
To:     Paul Burton <paul.burton@mips.com>
Cc:     linux-mips@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        y2038 Mailman List <y2038@lists.linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

On Mon, 10 Dec 2018 at 11:11, Paul Burton <paul.burton@mips.com> wrote:
>
> Hi Firoz,
>
> On Mon, Dec 10, 2018 at 11:05:38AM +0530, Firoz Khan wrote:
> > Please review this patch series and queue it for linux-next.
>
> It's been ~4 days, 2 of which were a weekend. I'll get to it, but
> pinging so often won't help.

Sure.

>
> Thanks,
>     Paul
