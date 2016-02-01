Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 01 Feb 2016 10:59:03 +0100 (CET)
Received: from mail-ig0-f179.google.com ([209.85.213.179]:33998 "EHLO
        mail-ig0-f179.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27008545AbcBAJ7BocRar (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 1 Feb 2016 10:59:01 +0100
Received: by mail-ig0-f179.google.com with SMTP id ik10so31969320igb.1
        for <linux-mips@linux-mips.org>; Mon, 01 Feb 2016 01:59:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=thkgbWPHR+ufsvLX4+lrAtasVD7aIm9z+I7wGzBB6Q4=;
        b=fkbnCbWR6yv29OhbyCNK5Rj1kmVostaFV9x5k7UWN1uJsaLQQbFz75+6LASfIzB5SM
         KklQfekStcNZYrVJFqlGenUhA8rILPvjxLr03gx12HkfU86WkLotUeOjqK4OTdADn/00
         JITFhEcYL00/E/F3uUDwCUEFH90BsKJjpHw4mxSbZ7MVn15O0eznNj8HN/EJ907hNARd
         pD1HAZVDFUaA8MHoRcyOI7EPTMHH2g8Sj9XpLAYJcMJNi8ueDvTjlCF9auysLsdPJCxA
         V4YmaEBwnex3hcxabex+PTK692mux1sOApCT97RMs+A0i9FDOqIlRzSjrs+uYztpqOUC
         b2cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=thkgbWPHR+ufsvLX4+lrAtasVD7aIm9z+I7wGzBB6Q4=;
        b=Vrks7g9AdfyCGVk1plPD98xg2Fmt078vXPiakor3nUSQ/DkY/wyP6Wwng1hmTQydE+
         hiyk7e42cyhRaxRhV9DxDklXMhFOFPmFZq0rTyT9gvntiPOv2bm2hMeKxBjO1lhyt+ZU
         8xtkYLlRzcCMHDZ9T5TAk/49A7k4lf7v/sezl/hMJXLqibGiTgpFJkVd19ao0Q6REDc3
         5t6lfVfdlUSNmTM7DGZdyNcYhfw8mwM5a4Zm5mLyVxrRaTdn/rw9ayj32JGJwcjg/kfo
         XXvYYE+5VRXbc04YHSU67fuNKjRqMp/abl5F2N4NbUOYOugsv6QQRcgyNaJIWG9FZPEk
         VDMw==
X-Gm-Message-State: AG10YOTjItpN9YJSwVehNvMrTs8q876KLW5nNL0rZDS449i9qwaEGnDEIDJw7ioozukAPbbmJppnl3jdXOz4EA==
MIME-Version: 1.0
X-Received: by 10.50.20.133 with SMTP id n5mr10561534ige.31.1454320735873;
 Mon, 01 Feb 2016 01:58:55 -0800 (PST)
Received: by 10.107.9.97 with HTTP; Mon, 1 Feb 2016 01:58:55 -0800 (PST)
In-Reply-To: <1454320556-9141-1-git-send-email-geert@linux-m68k.org>
References: <1454320556-9141-1-git-send-email-geert@linux-m68k.org>
Date:   Mon, 1 Feb 2016 10:58:55 +0100
X-Google-Sender-Auth: up-Hm-qVXSXFHZy1lNost4YhAHU
Message-ID: <CAMuHMdXtza8WKWqtrSA=mf5BRzKxgoAcf+eA19Dyd6XjgHH3iA@mail.gmail.com>
Subject: Re: Build regressions/improvements in v4.5-rc2
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     Linux MIPS Mailing List <linux-mips@linux-mips.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <geert.uytterhoeven@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51579
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: geert@linux-m68k.org
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

On Mon, Feb 1, 2016 at 10:55 AM, Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
> JFYI, when comparing v4.5-rc2[1] to v4.5-rc1[3], the summaries are:
>   - build errors: +11/-14

  + /home/kisskb/slave/src/include/linux/workqueue.h: error:
dereferencing type-punned pointer will break strict-aliasing rules
[-Werror=strict-aliasing]:  => 186:2

mips-allmodconfig (reported before)

  + /tmp/cc1QBZQq.s: Error: can't resolve `_start' {*UND* section} -
`L0^A' {.text section}:  => 43
  + /tmp/cc8ZbZGS.s: Error: can't resolve `_start' {*UND* section} -
`L0^A' {.text section}:  => 366, 49
  + /tmp/ccFjnXEZ.s: Error: can't resolve `_start' {*UND* section} -
`L0^A' {.text section}:  => 329, 50
  + /tmp/ccKewrem.s: Error: can't resolve `_start' {*UND* section} -
`L0^A' {.text section}:  => 378, 49
  + /tmp/ccWo9QOz.s: Error: can't resolve `_start' {*UND* section} -
`L0^A' {.text section}:  => 43
  + /tmp/ccXxR9ys.s: Error: can't resolve `_start' {*UND* section} -
`L0^A' {.text section}:  => 43
  + /tmp/ccjk8gwa.s: Error: can't resolve `_start' {*UND* section} -
`L0^A' {.text section}:  => 49, 366
  + /tmp/ccrL6L9s.s: Error: can't resolve `_start' {*UND* section} -
`L0^A' {.text section}:  => 326, 50

Various mips, not really new but shifting shape on every build

> [1] http://kisskb.ellerman.id.au/kisskb/head/9870/ (all 261 configs)
> [3] http://kisskb.ellerman.id.au/kisskb/head/9841/ (all 261 configs)

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
