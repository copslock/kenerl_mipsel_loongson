Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 08 Mar 2018 17:26:51 +0100 (CET)
Received: from conssluserg-01.nifty.com ([210.131.2.80]:57416 "EHLO
        conssluserg-01.nifty.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994754AbeCHQ0lui87A (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 8 Mar 2018 17:26:41 +0100
Received: from mail-vk0-f52.google.com (mail-vk0-f52.google.com [209.85.213.52]) (authenticated)
        by conssluserg-01.nifty.com with ESMTP id w28GPx60020836;
        Fri, 9 Mar 2018 01:26:00 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-01.nifty.com w28GPx60020836
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1520526360;
        bh=sYN8yyZMd+s4oQ3KWeLjJtovCobZzWv7+i7S6s7bkyI=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=cS2yT2LJoGUZFitXeTaQRUc68qsHABaszi7S3ed/P/XMbAW+R8d+pvzMx5i9iR6lc
         CKSkaHnPdaw3Djty8cCxgnUtmhWWpPdPHWNmzu+/644gfImPxfhVHb0IXGYuk7e/wI
         +fWkZMjqGybN0nqvbRgke6W6QW+uPFoHZFpNCVGoP/ntQ8lapo9FKccOTZedg67Erk
         AtAuvSr9q/MZAzsb9rQWtcm34bPQtkL9vU37aRC3Wg6BBo4mYNG5vTECeDLGS7V7rb
         dHZru59P9wq7DBEXFDIfYk1GKR6r/9r8PISe/vBXC505BCjIG5VUXEHhyBc4fY0ECF
         sm296dp5gMzKw==
X-Nifty-SrcIP: [209.85.213.52]
Received: by mail-vk0-f52.google.com with SMTP id z190so185452vkg.1;
        Thu, 08 Mar 2018 08:26:00 -0800 (PST)
X-Gm-Message-State: APf1xPCY5YeF8cbzLVWk0ReVtqaMk3T04sUKT9jwwM/fmO4rgBjIOYbC
        JxTlbKxHyYbct8m9qgXgUclxGCcTdNOvlQxTOeg=
X-Google-Smtp-Source: AG47ELtACDFC8CbKLB5qCtxxfMmYIBBYi+aVRDSVfHRmOmgdYDP3y6iLD1uMxktuAsvUWrQIl7ZA8jIBHLNoIaq9b9k=
X-Received: by 10.31.201.70 with SMTP id z67mr18982925vkf.154.1520526358913;
 Thu, 08 Mar 2018 08:25:58 -0800 (PST)
MIME-Version: 1.0
Received: by 10.176.32.138 with HTTP; Thu, 8 Mar 2018 08:25:18 -0800 (PST)
In-Reply-To: <20180308110246.16639-1-jhogan@kernel.org>
References: <CAK7LNARfTxxb0_RNEPvBzuEqP_g-cajZGpaGSuMJBUwDW66yww@mail.gmail.com>
 <20180308110246.16639-1-jhogan@kernel.org>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Fri, 9 Mar 2018 01:25:18 +0900
X-Gmail-Original-Message-ID: <CAK7LNASk1wzziCHtNY4jo8GO_aXTwrAh1bY-CyLiOSmBKm=BMg@mail.gmail.com>
Message-ID: <CAK7LNASk1wzziCHtNY4jo8GO_aXTwrAh1bY-CyLiOSmBKm=BMg@mail.gmail.com>
Subject: Re: [PATCH v2] kbuild: Handle builtin dtb file names containing hyphens
To:     James Hogan <jhogan@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Ralf Baechle <ralf@linux-mips.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Kevin Cernekee <cernekee@gmail.com>,
        devicetree@vger.kernel.org,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux-MIPS <linux-mips@linux-mips.org>,
        stable <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Return-Path: <yamada.masahiro@socionext.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62858
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yamada.masahiro@socionext.com
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

2018-03-08 20:02 GMT+09:00 James Hogan <jhogan@kernel.org>:
> cmd_dt_S_dtb constructs the assembly source to incorporate a devicetree
> FDT (that is, the .dtb file) as binary data in the kernel image. This
> assembly source contains labels before and after the binary data. The
> label names incorporate the file name of the corresponding .dtb file.
> Hyphens are not legal characters in labels, so .dtb files built into the
> kernel with hyphens in the file name result in errors like the
> following:
>
> bcm3368-netgear-cvg834g.dtb.S: Assembler messages:
> bcm3368-netgear-cvg834g.dtb.S:5: Error: : no such section
> bcm3368-netgear-cvg834g.dtb.S:5: Error: junk at end of line, first unrecognized character is `-'
> bcm3368-netgear-cvg834g.dtb.S:6: Error: unrecognized opcode `__dtb_bcm3368-netgear-cvg834g_begin:'
> bcm3368-netgear-cvg834g.dtb.S:8: Error: unrecognized opcode `__dtb_bcm3368-netgear-cvg834g_end:'
> bcm3368-netgear-cvg834g.dtb.S:9: Error: : no such section
> bcm3368-netgear-cvg834g.dtb.S:9: Error: junk at end of line, first unrecognized character is `-'
>
> Fix this by updating cmd_dt_S_dtb to transform all hyphens from the file
> name to underscores when constructing the labels.
>
> As of v4.16-rc2, 1139 .dts files across ARM64, ARM, MIPS and PowerPC
> contain hyphens in their names, but the issue only currently manifests
> on Broadcom MIPS platforms, as that is the only place where such files
> are built into the kernel. For example when CONFIG_DT_NETGEAR_CVG834G=y,
> or on BMIPS kernels when the dtbs target is used (in the latter case it
> admittedly shouldn't really build all the dtb.o files, but thats a
> separate issue).
>
> Fixes: 695835511f96 ("MIPS: BMIPS: rename bcm96358nb4ser to bcm6358-neufbox4-sercom")
> Signed-off-by: James Hogan <jhogan@kernel.org>
> Reviewed-by: Frank Rowand <frowand.list@gmail.com>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
> Cc: Michal Marek <michal.lkml@markovi.net>
> Cc: Ralf Baechle <ralf@linux-mips.org>
> Cc: Florian Fainelli <f.fainelli@gmail.com>
> Cc: Kevin Cernekee <cernekee@gmail.com>
> Cc: devicetree@vger.kernel.org
> Cc: linux-kbuild@vger.kernel.org
> Cc: linux-mips@linux-mips.org
> Cc: <stable@vger.kernel.org> # 4.9+
> ---
> Changes in v2:
>  - Rewrite commit message (thanks Frank for some improved wording).
>  - Add Franks' reviewed-by.

Applied to linux-kbuild/fixes.  Thanks!

-- 
Best Regards
Masahiro Yamada
