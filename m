Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 21 Jun 2012 11:55:39 +0200 (CEST)
Received: from mail-ee0-f49.google.com ([74.125.83.49]:34968 "EHLO
        mail-ee0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903644Ab2FUJzf (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 21 Jun 2012 11:55:35 +0200
Received: by eekd17 with SMTP id d17so128367eek.36
        for <multiple recipients>; Thu, 21 Jun 2012 02:55:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:organization:user-agent
         :in-reply-to:references:mime-version:content-transfer-encoding
         :content-type;
        bh=tJF9kinegGtGw6EXUMpANJJ6Mbc/u+ScpTiY4ZQoZEg=;
        b=KDDqfU4WIBEOL5x2A9aW4EkIvgEM/imNpyWejxocwk8BA9+3hgHADpocZSqxZf71Bh
         +EJwNud3Fyno9pOTdwJc6lJpoTHDwan4du1pFBtUYLvKjjJVaDn/PNrhMc/GIdMHlvEO
         tVqSy0i8zp3ldUD1RU0UiK832wzy3MCqdRZcJ0EYD7xVSId6UCv0lalb21+aKBKaIOoe
         0q8irp6JGpl+USQWnYq6El4czHUor/6M4x7mF/A1QHGux18DIiTCKF7ks5bNaLE1Eo9R
         jv3cX4aamnbnSHT8JY6Gf/uKcBlSsUK+KzP2fbBZbPMVcfnRQ8UOCfe7jStI/2u1sKkb
         bjUg==
Received: by 10.14.28.71 with SMTP id f47mr6080034eea.65.1340272529621;
        Thu, 21 Jun 2012 02:55:29 -0700 (PDT)
Received: from flexo.localnet (freebox.vlq16.iliad.fr. [213.36.7.13])
        by mx.google.com with ESMTPS id o16sm101012568eeb.13.2012.06.21.02.55.27
        (version=SSLv3 cipher=OTHER);
        Thu, 21 Jun 2012 02:55:27 -0700 (PDT)
From:   Florian Fainelli <florian@openwrt.org>
To:     Kelvin Cheung <keguang.zhang@gmail.com>
Cc:     linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>,
        wuzhangjin@gmail.com, zhzhl555@gmail.com
Subject: Re: [PATCH V7 2/4] MIPS: Add board support for Loongson1B
Date:   Thu, 21 Jun 2012 11:52:59 +0200
Message-ID: <2804040.40WPNaPH7R@flexo>
Organization: OpenWrt
User-Agent: KMail/4.8.3 (Linux/3.2.0-24-generic; KDE/4.8.3; x86_64; ; )
In-Reply-To: <CAJhJPsVaK4dRbxhB_3QKhrgF3=tYXWwOcppH9V=a871UMRxRew@mail.gmail.com>
References: <1339757617-2187-1-git-send-email-keguang.zhang@gmail.com> <5405989.s3J3Yyxttn@flexo> <CAJhJPsVaK4dRbxhB_3QKhrgF3=tYXWwOcppH9V=a871UMRxRew@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
X-archive-position: 33754
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

On Thursday 21 June 2012 17:11:04 Kelvin Cheung wrote:
> 2012/6/21 Florian Fainelli <florian@openwrt.org>
> 
> > On Thursday 21 June 2012 15:34:54 Kelvin Cheung wrote:
> > > 2012/6/21 Ralf Baechle <ralf@linux-mips.org>
> > [snip]
> > > >
> > > > And the final plug - take a look at FDT for a future revision of this
> > > > code :)
> > > >
> > > >
> > > Yes, I am aware that the FDT is the final target.
> > > But PMON which is the bootloader of Loongson CPU does not support FDT at
> > > present.
> > > I will remember this.
> >
> > Your bootloader does not need to support FDT, as long as you can provide a
> > FDT
> > by other means, such as appending a FDT at the end of your kernel.
> >
> 
> But how can I verify these code without support of bootloader?

Since you will be appending a DTB at the end of your kernel, you can start 
adding some properties to your DTS file and let the kernel parse them and make 
sure everything is correctly represented using device tree, then start 
removing your platform devices etc ...
--
Florian
