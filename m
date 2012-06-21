Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 21 Jun 2012 10:20:57 +0200 (CEST)
Received: from mail-ee0-f49.google.com ([74.125.83.49]:62502 "EHLO
        mail-ee0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903613Ab2FUIUv (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 21 Jun 2012 10:20:51 +0200
Received: by eekd17 with SMTP id d17so89511eek.36
        for <multiple recipients>; Thu, 21 Jun 2012 01:20:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:organization:user-agent
         :in-reply-to:references:mime-version:content-transfer-encoding
         :content-type;
        bh=8za/3Lxtn+3MJH9kmcOUZ4E5IutQtZh05Lu/rcpQzVY=;
        b=zfbdi4B1xwQse/vFVp/dG7ahXeAH9hLbbTMfe6udnmnJgF92xWzAUzAJqDkkAuf/0I
         2qgA+iUlcXnhBeFTRFnqx7oZkJtd0STCWmL9fOUujceYLi47uDGWup6Vvd3xObwC86P+
         psJ+m3hKNE7xABKkYR62EWlcKyJkLIDUz2jn1jYXJ4QVNVwaNnGsPhyFU+deU80Vwl6y
         /3cPEc+jkeM03WvnTG0ldMHfVXBPU1NfyELHdMbBSm5RUeijRP/DAJ91IrdMByGihoz0
         Sm0OLv2KbIg4+N3fIe0O6nBcBVLS2u4zkQE+w/PhSEwm7+7hBPT60+VV0mZPYBnbdQqW
         4TRw==
Received: by 10.14.99.79 with SMTP id w55mr5727208eef.59.1340266846006;
        Thu, 21 Jun 2012 01:20:46 -0700 (PDT)
Received: from flexo.localnet (freebox.vlq16.iliad.fr. [213.36.7.13])
        by mx.google.com with ESMTPS id g46sm100184319eea.14.2012.06.21.01.20.42
        (version=SSLv3 cipher=OTHER);
        Thu, 21 Jun 2012 01:20:43 -0700 (PDT)
From:   Florian Fainelli <florian@openwrt.org>
To:     linux-mips@linux-mips.org
Cc:     Kelvin Cheung <keguang.zhang@gmail.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        linux-kernel@vger.kernel.org, wuzhangjin@gmail.com,
        zhzhl555@gmail.com
Subject: Re: [PATCH V7 2/4] MIPS: Add board support for Loongson1B
Date:   Thu, 21 Jun 2012 10:18:16 +0200
Message-ID: <5405989.s3J3Yyxttn@flexo>
Organization: OpenWrt
User-Agent: KMail/4.8.3 (Linux/3.2.0-24-generic; KDE/4.8.3; x86_64; ; )
In-Reply-To: <CAJhJPsV2D3xVbA93OpaB8mN6Vs64EmWjxhCbpCMBA5r+wx8mnQ@mail.gmail.com>
References: <1339757617-2187-1-git-send-email-keguang.zhang@gmail.com> <20120620192551.GC29446@linux-mips.org> <CAJhJPsV2D3xVbA93OpaB8mN6Vs64EmWjxhCbpCMBA5r+wx8mnQ@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
X-archive-position: 33752
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian@openwrt.org
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
Return-Path: <linux-mips-bounce@linux-mips.org>

On Thursday 21 June 2012 15:34:54 Kelvin Cheung wrote:
> 2012/6/21 Ralf Baechle <ralf@linux-mips.org>
[snip]
> >
> > And the final plug - take a look at FDT for a future revision of this
> > code :)
> >
> >
> Yes, I am aware that the FDT is the final target.
> But PMON which is the bootloader of Loongson CPU does not support FDT at
> present.
> I will remember this.

Your bootloader does not need to support FDT, as long as you can provide a FDT 
by other means, such as appending a FDT at the end of your kernel.
--
Florian
