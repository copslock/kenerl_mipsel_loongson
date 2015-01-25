Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 25 Jan 2015 11:13:50 +0100 (CET)
Received: from mail-lb0-f177.google.com ([209.85.217.177]:54222 "EHLO
        mail-lb0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27010794AbbAYKNsReTNs (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 25 Jan 2015 11:13:48 +0100
Received: by mail-lb0-f177.google.com with SMTP id p9so3723620lbv.8;
        Sun, 25 Jan 2015 02:13:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=mNAxTi+TrVcBJRa0jQTrm8t9cPIGcZ4Ot4X4tv/SxIo=;
        b=qJ+qftrRGoEclPjCjLo2OY/n/bolHo+3iny4bROG+HX/UCBD/lS3N347EBwHdJqNFB
         XnCkmLqlmWWRf48AvB+5bBkhJQBT6NEHBVT3t6DWMBKQAx4DuIRAgQW/ial3f9C8c+rN
         0avidjyaKy/QGzCdNMHWO7ype1j8N8K1vT1VwQCg4sCux6IDphRe2nsm8v28rvavdq6w
         hcrPqW9uzopZVGeug1mzz+qfJzXpbsMQx+ZjXwIHymQ1H1OFFqfF+J7TRDfAcn6H90m2
         Px3ZAZHQVZ/xBLiVw4xu0DXHx7tTFov3tt7Il9sIxnN7aCWyDBAMfuZQdE2FJwfgiixs
         Lrog==
MIME-Version: 1.0
X-Received: by 10.112.156.169 with SMTP id wf9mr15897624lbb.85.1422180822836;
 Sun, 25 Jan 2015 02:13:42 -0800 (PST)
Received: by 10.152.29.33 with HTTP; Sun, 25 Jan 2015 02:13:42 -0800 (PST)
In-Reply-To: <alpine.DEB.2.11.1501241851090.5526@nanos>
References: <1415342669-30640-1-git-send-email-cernekee@gmail.com>
        <1415342669-30640-2-git-send-email-cernekee@gmail.com>
        <CAMuHMdW+L8YbE8Z8jrtnm8xWk63sRGaFdM7TPM6MmrDg9XwHuQ@mail.gmail.com>
        <20141114163843.GH29662@linux-mips.org>
        <20141114170525.GL3698@titan.lakedaemon.net>
        <CAMuHMdXMsxhcD9C079YPc6Toxdo0e23oqM_9KeSG=NrFa4auRQ@mail.gmail.com>
        <CAMuHMdUpxURV4ztpa3x0TORsSWtxiKxe6_EDO5QsO_vhedip0A@mail.gmail.com>
        <alpine.DEB.2.11.1501241851090.5526@nanos>
Date:   Sun, 25 Jan 2015 11:13:42 +0100
X-Google-Sender-Auth: IpMSbe7qTV1H6obYQGgV3A5b1xE
Message-ID: <CAMuHMdWQWVv+RJhhae59b+GEv_Gfgn0UQpWgFQ2Q7y+KGjTrEg@mail.gmail.com>
Subject: Re: [PATCH V4 01/14] sh: Eliminate unused irq_reg_{readl,writel} accessors
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Jason Cooper <jason@lakedaemon.net>,
        Ralf Baechle <ralf@linux-mips.org>,
        Kevin Cernekee <cernekee@gmail.com>,
        Linux-sh list <linux-sh@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Maxime Bizon <mbizon@freebox.fr>,
        Jonas Gorski <jogo@openwrt.org>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <geert.uytterhoeven@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45464
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

On Sat, Jan 24, 2015 at 6:51 PM, Thomas Gleixner <tglx@linutronix.de> wrote:
> On Mon, 19 Jan 2015, Geert Uytterhoeven wrote:
>> Will you still do so, or shall I forward the patch to Andrew Morton?
>
> akpm please.

Forwarded with build failure descriptions added.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
