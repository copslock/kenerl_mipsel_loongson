Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 30 Nov 2012 14:11:41 +0100 (CET)
Received: from mail-wi0-f169.google.com ([209.85.212.169]:37440 "EHLO
        mail-wi0-f169.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6816553Ab2K3NLkpab1Z convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 30 Nov 2012 14:11:40 +0100
Received: by mail-wi0-f169.google.com with SMTP id hq12so5585496wib.0
        for <multiple recipients>; Fri, 30 Nov 2012 05:11:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=oVBXBVnyE3l1e2mL7pS3fo3am3zsei5NLyqxp+FrZoI=;
        b=vm13EJhneTwvZ7Xy2yfUbSpGLcG+RFJEZVUBXdoMKZXRwPvxE6C4wNYnr5P9I7QsYo
         lhBOD2dYmlLOmu93sLkq6rmlhLTZbEGmBxw+RApVSo0qu/dEH5wjaQmnDh+H3Nxg6n1x
         QU0UUpJcK0ap1/+fZKtdQV7aoi8VBSg4Jj4AIsHwPcVWKLyB/Bmx5fdHngtpFdBts1ro
         lSjw0P0NAANe+LJGF5aeasC2CbkR96nlxRRhNKMA1L7GwRpG6opxNCWjIVbkguj05ypm
         FCaoLdv7E203re8cH+noDxM2qlSYOA5RrPwFtpLeVoZ6s3IDTxzLt/JsHTikwZ6ffYcM
         sxJQ==
MIME-Version: 1.0
Received: by 10.181.11.234 with SMTP id el10mr15717943wid.7.1354281095367;
 Fri, 30 Nov 2012 05:11:35 -0800 (PST)
Received: by 10.216.21.8 with HTTP; Fri, 30 Nov 2012 05:11:35 -0800 (PST)
In-Reply-To: <1353453874-523-1-git-send-email-hauke@hauke-m.de>
References: <1353453874-523-1-git-send-email-hauke@hauke-m.de>
Date:   Fri, 30 Nov 2012 14:11:35 +0100
Message-ID: <CACna6rzGE=CaD_9yAaTDkR6CuUy1HqRq1-v+fAd-Zg-uMmH2bQ@mail.gmail.com>
Subject: Re: [PATCH v3 0/8] bcma/ssb/BCM47XX: add GPIO driver to ssb/bcma
From:   =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
To:     Hauke Mehrtens <hauke@hauke-m.de>
Cc:     john@phrozen.org, ralf@linux-mips.org, linux-mips@linux-mips.org,
        linux-wireless@vger.kernel.org, florian@openwrt.org, m@bues.ch
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-archive-position: 35158
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
Return-Path: <linux-mips-bounce@linux-mips.org>

2012/11/21 Hauke Mehrtens <hauke@hauke-m.de>:
> This is a complete rewrote of the original patch "MIPS: BCM47xx: use
> gpiolib"
> Instead of providing the GPIO driver in the arch code it is now moved
> into ssb and bcma and could also be used by other systems. The GPIO
> functions in drivers/ssb/embedded.c are still used by arch/mips/bcm47xx
> /wgt634u.c, but I am planing to write some code for baord detection and
> a driver for LED and the buttons, after that wgt634u.c could be removed.
>
> This is based on mips/master tree.

Is this patches supposed to appear in
http://git.kernel.org/?p=linux/kernel/git/ralf/linux.git;a=summary
? Just so I can know where to look for it.

-- 
Rafał
