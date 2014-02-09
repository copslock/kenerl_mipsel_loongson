Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 09 Feb 2014 17:27:25 +0100 (CET)
Received: from 0.mx.nanl.de ([217.115.11.12]:50164 "EHLO mail.nanl.de"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6822672AbaBIQ1XWjK-1 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sun, 9 Feb 2014 17:27:23 +0100
Received: from mail-qa0-f51.google.com (mail-qa0-f51.google.com [209.85.216.51])
        by mail.nanl.de (Postfix) with ESMTPSA id CF46A4609D;
        Sun,  9 Feb 2014 16:25:30 +0000 (UTC)
Received: by mail-qa0-f51.google.com with SMTP id f11so8126774qae.38
        for <multiple recipients>; Sun, 09 Feb 2014 08:27:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=MlXkbHsxFNCmIvulamFu/WXQWm2NvUvPb3TJx8YpkkQ=;
        b=BQYqnbVZAVdzx8NJxElGCspTdywgOFnR2yf8/Uij+GEIihxxZmoiDQ6g41dDzEwcG4
         lMlUSYZJ5O2FEw2yyO6eSOmBusvJDZcqVZwWD80aCelAswGHPJG4tZandjp3ggzm6y7P
         OH3qurdR2UlwE4kOx7XnSWHdxBvy4XHq+Zru26r7p4ss2aCd+G+s5w0+r0px756h3YYW
         muLM/fzSVkc1u6o+iAE/H/auW/VVJL9TS9Su702nZ6ng7+SY0DT6O/yUFefI3EH0P6Wi
         +Pree0uKfBWPVsfrAfHw/2MhNA4iy+4eeN2AxoLpik/ywegYGhoNftvaNnymTWfMM9Vj
         r4oQ==
X-Received: by 10.224.62.14 with SMTP id v14mr1685223qah.79.1391963239126;
 Sun, 09 Feb 2014 08:27:19 -0800 (PST)
MIME-Version: 1.0
Received: by 10.140.106.228 with HTTP; Sun, 9 Feb 2014 08:26:59 -0800 (PST)
In-Reply-To: <1391952745.25424.6.camel@x220>
References: <1391952745.25424.6.camel@x220>
From:   Jonas Gorski <jogo@openwrt.org>
Date:   Sun, 9 Feb 2014 17:26:59 +0100
Message-ID: <CAOiHx=mi3sW7C0ZGwAhobRryikMs=Hj0UL19ENuUMECqk0EW5g@mail.gmail.com>
Subject: Re: [PATCH] MIPS: Replace CONFIG_MIPS64 and CONFIG_MIPS32_R2
To:     Paul Bolle <pebolle@tiscali.nl>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        MIPS Mailing List <linux-mips@linux-mips.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <jogo@openwrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39254
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jogo@openwrt.org
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

On Sun, Feb 9, 2014 at 2:32 PM, Paul Bolle <pebolle@tiscali.nl> wrote:
> Commit 597ce1723e0f ("MIPS: Support for 64-bit FP with O32 binaries")
> introduced references to two undefined Kconfig macros. CONFIG_MIPS32_R2
> should clearly be replaced with CONFIG_CPU_MIPS32_R2. And CONFIG_MIPS64
> should apparently be replaced with CONFIG_64BIT.

While I agree about the CONFIG_MIPS64 => CONFIG_64BIT replacement, I
wonder if CONFIG_MIPS32_R2 shouldn't rather be CONFIG_CPU_MIPSR2
(maybe even the existing CONFIG_CPU_MIPS32_R2 are wrong here).
CPU_XLP selects CPU_MIPSR2, and CPU_LONGSOON1 selects CPU_MIPS32 and
CPU_MIPSR2, so they should probably be treated the same way as
CPU_MIPS32_R2 (for e.g. the di/ei availability), but since all three
are choice values, there can't be CPU_MIPS32_R2 selected if
CPU_LONGSOON1 or CPU_XLP is chosen.


Regards
Jonas
