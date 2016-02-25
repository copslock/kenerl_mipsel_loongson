Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 25 Feb 2016 13:53:27 +0100 (CET)
Received: from mail-wm0-f45.google.com ([74.125.82.45]:32962 "EHLO
        mail-wm0-f45.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011059AbcBYMxVNBlo- (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 25 Feb 2016 13:53:21 +0100
Received: by mail-wm0-f45.google.com with SMTP id g62so30563589wme.0;
        Thu, 25 Feb 2016 04:53:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc;
        bh=JcrqncSD1ngZRn8Ltu2YRGR0+0B5vt1NjZesnHEMcWc=;
        b=qsJbbeRbsYEPAIlNJ950ZNdnuzP2ZsrG1XWMyZghghZps1g8j02q+M9K5M/KiMOCE+
         dAChAjGle3IglQhMeE0yTPITt//RzRHFpZt0wB1aJl/VsEqPbA256Y4Rkk1IJI7yJtOp
         fWwBH4vBNhVwoCdAYP80+DriNEpKpMYAfPN21L1CsuzaVFmtWFBpab73+HIGYxkP7yFG
         7MHbwALv9qwW7NTTPpmER4+FTcLO3OSPeHwvqvLUV14erQ+xTjnlNEVOu1ykzm9cg2i3
         PhQ6kQQmhgEMll406MrT2PYyhQ8OjeDdBIuSWrR4hbrT2YJ9cxbgbO9FTZFbcUR1q6V0
         tqvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=JcrqncSD1ngZRn8Ltu2YRGR0+0B5vt1NjZesnHEMcWc=;
        b=AU9bJ3HPZxo9wExY9cciSiS3tXkhiAtMudFTO6ndmMXz/g4FtMySEiquUiDZp6VoZI
         bbXuPx5WdekE5JUu8WWx71Sf/5vbPleJ81Nf+8EH/o6GNR5SzqSS7g80ldnocwblpR4V
         3tcxdvnpJMqe8T4EBo72Tj6A9zcrARd8ZAAdKuBMiMaW9oigj2b3Qh2Q2KBpn84JS3wo
         HAZ4/ryuloFo2XTCIQ0AKMEtgd8gtabWYKQMmYnO+i/lNMZ9CWTxGYDqlrYvCbsaDCJp
         cPQSvIAb2qCmFrRhxmfRnuBY2CXCAJvDeVd17XPj/ABL2FvFzGMYafRrdmRevx+9afJ2
         zzYg==
X-Gm-Message-State: AG10YORZih14ruz1HaMWPHOFYI3+/uc0OJYaDDX6b1jWH8QcWhVQUSiIe5sK1PHZKOq949tmAfpKEq8P22Z1NA==
MIME-Version: 1.0
X-Received: by 10.28.30.198 with SMTP id e189mr3293622wme.60.1456404795973;
 Thu, 25 Feb 2016 04:53:15 -0800 (PST)
Received: by 10.27.13.9 with HTTP; Thu, 25 Feb 2016 04:53:15 -0800 (PST)
In-Reply-To: <alpine.DEB.2.00.1602251116010.15885@tp.orcam.me.uk>
References: <1456324384-18118-1-git-send-email-chenhc@lemote.com>
        <1456324384-18118-3-git-send-email-chenhc@lemote.com>
        <alpine.DEB.2.00.1602250050170.15885@tp.orcam.me.uk>
        <CAAhV-H5NW7NG0C9OU-qjCzPO-CB+pWmsh0RC0ZmKKmUx0U75=Q@mail.gmail.com>
        <alpine.DEB.2.00.1602251116010.15885@tp.orcam.me.uk>
Date:   Thu, 25 Feb 2016 20:53:15 +0800
X-Google-Sender-Auth: swa1x8n1AGQRwKozAzLPC-929gg
Message-ID: <CAAhV-H4nc_z1OWF2JLJ2bfwTcCkYXRZ8CTc1kh3zRs5WHQKKQw@mail.gmail.com>
Subject: Re: [PATCH] MIPS: Introduce cpu_has_coherent_cache feature
From:   Huacai Chen <chenhc@lemote.com>
To:     "Maciej W. Rozycki" <macro@imgtec.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Aurelien Jarno <aurelien@aurel32.net>,
        "Steven J . Hill" <Steven.Hill@imgtec.com>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        "Maciej W. Rozycki" <macro@linux-mips.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <chenhuacai@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52260
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: chenhc@lemote.com
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

OK, thanks. I will consider setting the relevant handlers to
cache_noop in r4k_cache_init().

On Thu, Feb 25, 2016 at 7:16 PM, Maciej W. Rozycki <macro@imgtec.com> wrote:
> On Thu, 25 Feb 2016, Huacai Chen wrote:
>
>> Joshua Kinard suggest me to split the patch, which you can see here:
>> https://patchwork.linux-mips.org/patch/12324/
>> If it is better to not split, please see my V2 patchset.
>
>  Splitting is the correct action, however please answer my questions as
> well.
>
>   Maciej
>
