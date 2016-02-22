Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 22 Feb 2016 10:32:16 +0100 (CET)
Received: from mail-io0-f180.google.com ([209.85.223.180]:34398 "EHLO
        mail-io0-f180.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27010609AbcBVJcPUzUhA (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 22 Feb 2016 10:32:15 +0100
Received: by mail-io0-f180.google.com with SMTP id 9so172353323iom.1;
        Mon, 22 Feb 2016 01:32:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=SudOAhfqugGa64m8wVQHE/rEw/MidBfll/E7mS6mZaE=;
        b=XI5reK6Wn/a9R1a8CbrHCsGG9gIL7UhRk6sfvXq+iTlumESUI4YXj2MiYLazt2huZn
         Ouy0RDgXEDciVA3aT3i/ORXKhVXZjdKi1p2A1WSAYc7ID0TI8ryfugc7kuxwInyNmZ06
         nX1sfB+szmlZPEcM/A9EdZ76iF2T7jFHNl3Awu7rY0Jr+rB9T/C3pP6rakBTgLbY16zE
         sadXaYB4u6vNqrT4oGC5iPxAWCA7y/QaAgo8Nc1i5b3ylenw+M82n4IpjMLIasdfstOk
         t1L/sedJLtYu90bGOLAaSSafDtagAMKrRxjaefE4dGoetLhpXaczwnJMA6raxuFW0XcQ
         zZSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=SudOAhfqugGa64m8wVQHE/rEw/MidBfll/E7mS6mZaE=;
        b=OEx64lssn230s/Ceg3PxCxJNLj3wGmlXfYJgRghOu3uxKJ0lkjJWnxdep03n624cCX
         3FW/Hgmj9S7ubqGeltHz9g8ZsA+28ePzbLW3BNmgO/vFl5HGxPiyW7OAd/mWVHWLmGel
         LMnx3Azqti+H9OyQL/yutAF/tApb/GqB59olqNLud4/Q2CYQXS5FasIGRoVW0Udy7c8k
         Lh2BDVxTORgkkN33vE7tApPfaaXJS9amXNeOT/grmaxKJSQFEl6iP7kIeaO24E65Ew7a
         e6pbOy5Itb6XCdEZ5ltdIrDMSgfNSNlz535Jtm/PGl4vyixGBNvwQEaXYGvCi5qz41DB
         PnTg==
X-Gm-Message-State: AG10YOTM0vAGGTWrdTGSV5CQ9Tkud2nkGOLMi/+T/ZLfMScYfqgPTAlixolj5wG8hhTFfR1p6H9zk/9BLQg0QA==
MIME-Version: 1.0
X-Received: by 10.107.26.203 with SMTP id a194mr32342341ioa.115.1456133529460;
 Mon, 22 Feb 2016 01:32:09 -0800 (PST)
Received: by 10.107.132.222 with HTTP; Mon, 22 Feb 2016 01:32:09 -0800 (PST)
In-Reply-To: <1456133420-3937-1-git-send-email-geert@linux-m68k.org>
References: <1456133420-3937-1-git-send-email-geert@linux-m68k.org>
Date:   Mon, 22 Feb 2016 10:32:09 +0100
X-Google-Sender-Auth: I4EOmJd73WfDhRsjwoZosHUvbA8
Message-ID: <CAMuHMdXuZY5cffYwPuPabG1FjeOjzaTwyt7UHwTWTKXzJ3rFvw@mail.gmail.com>
Subject: Re: Build regressions/improvements in v4.5-rc5
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <geert.uytterhoeven@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52152
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

On Mon, Feb 22, 2016 at 10:30 AM, Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
> JFYI, when comparing v4.5-rc5[1] to v4.5-rc4[3], the summaries are:
>   - build errors: +22/-17

  + /home/kisskb/slave/src/include/linux/workqueue.h: error:
dereferencing type-punned pointer will break strict-aliasing rules
[-Werror=strict-aliasing]:  => 186:2

mips-allmodconfig

> [1] http://kisskb.ellerman.id.au/kisskb/head/9944/ (all 262 configs)
> [3] http://kisskb.ellerman.id.au/kisskb/head/9916/ (all 262 configs)

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
