Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 23 Oct 2012 10:53:24 +0200 (CEST)
Received: from mail-bk0-f49.google.com ([209.85.214.49]:56313 "EHLO
        mail-bk0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6815793Ab2JWIxXZsxgv (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 23 Oct 2012 10:53:23 +0200
Received: by mail-bk0-f49.google.com with SMTP id j4so1141030bkw.36
        for <multiple recipients>; Tue, 23 Oct 2012 01:53:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:organization:user-agent
         :in-reply-to:references:mime-version:content-transfer-encoding
         :content-type;
        bh=zI0RIrzFu/P70S7+RVmxv2DxAt1dZwHqpIDK0J+8IDY=;
        b=iCpcuW44xFCLExjWdvrnqV1bW1opdqElqYg/ptZcHIASpyfyjhm/zI5yR99eReSfqo
         ZofnnzhuFukMzJV0HhZy1ks+BsA5cNARDlxtgJpsTKUwYkvRh1Q1TECSALdQatRa5Dyn
         q/QMq3SjkXqSVD62sZxhSqfA6AYyslzaq3p+pElyHyOb03LvowKNqlcpob3kxVesGvp5
         KJfo+HrMxKmbyucp/hQ5aaybtQ+u4FpEUYpx8CnkBXtqcA8n4sHzQx3GntCh/Hsy6gS8
         0NAYtQhrfpYL6JX+31WDbC1dTjGbdcFb+9EFZQ0dxhvC1LkAD7vn8+FE3VarP9abwKY5
         fqyA==
Received: by 10.204.0.74 with SMTP id 10mr3553707bka.83.1350982398017;
        Tue, 23 Oct 2012 01:53:18 -0700 (PDT)
Received: from flexo.localnet (freebox.vlq16.iliad.fr. [213.36.7.13])
        by mx.google.com with ESMTPS id z22sm5005027bkw.2.2012.10.23.01.53.16
        (version=SSLv3 cipher=OTHER);
        Tue, 23 Oct 2012 01:53:17 -0700 (PDT)
From:   Florian Fainelli <florian@openwrt.org>
To:     Kelvin Cheung <keguang.zhang@gmail.com>
Cc:     stern@rowland.harvard.edu, linux-usb@vger.kernel.org,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 03/32 v4] MIPS: Loongson 1B: use ehci-platform instead of ehci-ls1x.
Date:   Tue, 23 Oct 2012 01:53:17 -0700 (PDT)
Message-ID: <10090450.q3VbTvBDPg@flexo>
Organization: OpenWrt
User-Agent: KMail/4.8.5 (Linux/3.2.0-24-generic; KDE/4.8.5; x86_64; ; )
In-Reply-To: <36521520.iGJ91Agxac@flexo>
References: <1349701906-16481-1-git-send-email-florian@openwrt.org> <CAJhJPsV5mFmOgU38ZpnYqUTNuOPmvRXjsf31XdFUqNOzsd_Edg@mail.gmail.com> <36521520.iGJ91Agxac@flexo>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
X-archive-position: 34745
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

On Tuesday 23 October 2012 10:46:50 Florian Fainelli wrote:
> Hi Kelvin,
> 
> On Tuesday 23 October 2012 16:13:01 Kelvin Cheung wrote:
> > Thank Florian.
> > It looks great.
> > However, you forget to remove corresponding section in
> > drivers/usb/host/ehci-hcd.c
> > ...
> > #ifdef CONFIG_MACH_LOONGSON1
> > #include "ehci-ls1x.c"
> > #define PLATFORM_DRIVER         ehci_ls1x_driver
> > #endif
> 
> Indeed, my bad I will follow up with some fixes for this patchset anyway.
> Thank you!

Looks like I hit reply too quickly, the patch entitled
"USB: EHCI: remove Loongson 1B EHCI driver" actually removes this bit from
ehci-hcd.c.
--
Florian
