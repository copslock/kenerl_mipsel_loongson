Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 14 Jan 2016 09:45:51 +0100 (CET)
Received: from mail-io0-f180.google.com ([209.85.223.180]:36215 "EHLO
        mail-io0-f180.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27007755AbcANIpt71hBm (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 14 Jan 2016 09:45:49 +0100
Received: by mail-io0-f180.google.com with SMTP id g73so251532251ioe.3
        for <linux-mips@linux-mips.org>; Thu, 14 Jan 2016 00:45:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=DH6by+zxdcqdZx7FKPQ2PkcJrSQl2NRGtS5+2S5mSgE=;
        b=aoaWdcrapc7JJzuVGE8dprB4idbyAyE0EscwfXuTKZrepb5QoG8Lm8oSpkR/Ki7qOk
         Zw/86t08KaAEdVss+rXU5ZtW3BIgtfW6uao0cQLV6SJZAY6782CFnUxJKa0ihsSHmdPi
         WU00ZQso6Vl7HOhiIS9kAyQDhbzCFc8C+wGuVptQz97230ZDiBoxpOEhWgNdvvzcogBa
         KacOQVrSUIHCAk+zMdjDDZeDTj/Dn6Z+QTh6SoTjC9rO+GaMZGbB/vqjXvFkOydzEJrF
         MtQCx5YGunwnuX2EqC7EmcXksoq5VnGltHIBJuk7sOgKx0IgAgtP2glvVsH2tNk9BoyR
         M4jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=DH6by+zxdcqdZx7FKPQ2PkcJrSQl2NRGtS5+2S5mSgE=;
        b=mGbJ4nfokhnMd/JhTtN0V2JTmGQdMMDKDPtY26ByEAp62KW93PkTiMrlYgHr/XyaHl
         rNp/V+N5TixRLfPZZnx2IAWvxi0q4l54NKvnMoR+6dpTF5CTZq86f9KfY82SkvMmVyzS
         Sel4/dwgiwJGQTlpl3HMfWjRO2qZjpoCUHsz+utuzQ4koDd6dCvc6a96yBjo/kUA/hFf
         qOGAUFZuz4ADDNHyQEjR0VWBClNrNS24UFz+ap5pmjxwYBKdbSt9JxJgWRsVAOeVxKAM
         Qa2QMk7ayXXCd2Ubat90jZOhJojxTYrr+rXIOu7z7b8gsGDx3/WA8Eg/W8j60tL9WOeA
         Ci4w==
X-Gm-Message-State: ALoCoQnxo+6zVRQ9/Vk26m0ITNCDqLdhqhQvh3tcBbbrdQqb7JXpt/UUFCLyHsFohepYc834AYbjTsF2nxC9AoQxARsuPqoXcw==
MIME-Version: 1.0
X-Received: by 10.107.168.203 with SMTP id e72mr3512254ioj.96.1452761144181;
 Thu, 14 Jan 2016 00:45:44 -0800 (PST)
Received: by 10.107.149.16 with HTTP; Thu, 14 Jan 2016 00:45:44 -0800 (PST)
In-Reply-To: <8128014.DbbgBtKY3z@wuerfel>
References: <8128014.DbbgBtKY3z@wuerfel>
Date:   Thu, 14 Jan 2016 09:45:44 +0100
Message-ID: <CACna6rwAUh+LTBAepMTy1ZT7QhRYFPFmP5wPxyyQVb29gFwQYg@mail.gmail.com>
Subject: Re: [PATCH] ssb: host_soc depends on sprom
From:   =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Kalle Valo <kvalo@codeaurora.org>,
        Hauke Mehrtens <hauke@hauke-m.de>, Michael Buesch <m@bues.ch>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Network Development <netdev@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <zajec5@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51114
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

On 13 January 2016 at 23:51, Arnd Bergmann <arnd@arndb.de> wrote:
> Drivers that use the SSB sprom functionality typically 'select SSB_SPROM'
> from Kconfig, but CONFIG_SSB_HOST_SOC misses this, which results in
> a build failure unless at least one of the other drivers that selects
> it is enabled:
>
> drivers/built-in.o: In function `ssb_host_soc_get_invariants':
> (.text+0x459494): undefined reference to `ssb_fill_sprom_with_fallback'
>
> This adds the same select statement that is used elsewhere.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Fixes: 541c9a84cd85 ("ssb: pick SoC invariants code from MIPS BCM47xx arch")

I missed this dependency, thanks, patch looks OK.
