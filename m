Return-Path: <SRS0=2fGM=PS=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6D96C43387
	for <linux-mips@archiver.kernel.org>; Thu, 10 Jan 2019 18:56:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78B0E206B7
	for <linux-mips@archiver.kernel.org>; Thu, 10 Jan 2019 18:56:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729009AbfAJS4F convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@archiver.kernel.org>);
        Thu, 10 Jan 2019 13:56:05 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:45465 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728331AbfAJS4F (ORCPT
        <rfc822;linux-mips@vger.kernel.org>); Thu, 10 Jan 2019 13:56:05 -0500
Received: by mail-pf1-f193.google.com with SMTP id g62so5699277pfd.12
        for <linux-mips@vger.kernel.org>; Thu, 10 Jan 2019 10:56:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=o5diNdXV/6aqLnAW0j3v0mV51bk3WAGfHKTHJJY8oYs=;
        b=LRt/OQO1CgteTZ24B1E1kBzLzj0i1+MNMmX/45YOdyFDe0hIdNdtYGhKKBSbpy/pXa
         /WXPSbLcPnqEfRZrFlBLmzzf5FVUkl+shYh3+05p9rLHmgAVB0ODy4TQU1WT9+hOPkIq
         dy4OG8Mf+suctCIkFCGrVieQEkN6zMCL9KsN7hnE4A6zTXXa96Y/XFM8tCPOUN5Ys4VQ
         ZdGCh7++bRDtEVGm9xHCihHTmDpiAmzXvxI0KnhWlEEb6KGP+JSp01caA8USTJM4sO8d
         qDjpxy8q4WvwzF1EovuT6LDsNtAaOmvSs1OcPPv9XPlyZWmWm4MkikDQzOv4i4PTjEK3
         HxxA==
X-Gm-Message-State: AJcUukfiI5mtLIa2nudYwPEDgY9iOgeAVi5peibPNEazAAShKbfeUKLh
        7lI1ewJl6f3dYSLukbVwfNH5kWjCVLC7gJsQ+2AZDYuRiZqlQQ==
X-Google-Smtp-Source: ALg8bN7El1jYpENpnmj0/HvyLgWtv5KPtXmPcfZox0Ywm8zdjEFn+15frCF8SxaEpTE2mTAjyfeA78B8INgb3Eoeqag=
X-Received: by 2002:a62:4c5:: with SMTP id 188mr11535645pfe.130.1547146564212;
 Thu, 10 Jan 2019 10:56:04 -0800 (PST)
MIME-Version: 1.0
References: <20190108054510.7393-1-syq@debian.org> <20190110182443.dic3trktlnn23ynn@pburton-laptop>
 <D0125B24-7506-48D0-B2A8-D1D1AC75ECC1@wavecomp.com> <20190110184530.7odyys2qyrmfcjkk@pburton-laptop>
In-Reply-To: <20190110184530.7odyys2qyrmfcjkk@pburton-laptop>
From:   YunQiang Su <syq@debian.org>
Date:   Fri, 11 Jan 2019 02:55:52 +0800
Message-ID: <CAKcpw6VBd5qDRx+cAcAOpqRqcLOBKobJPeh=cUDOLJAWA=Ghdg@mail.gmail.com>
Subject: Re: [PATCH v2] Disable MSI also when pcie-octeon.pcie_disable on
To:     Paul Burton <paul.burton@mips.com>
Cc:     Yunqiang Su <ysu@wavecomp.com>, Paul Burton <pburton@wavecomp.com>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
        "aaro.koskinen@iki.fi" <aaro.koskinen@iki.fi>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

Paul Burton <paul.burton@mips.com> 于2019年1月11日周五 上午2:45写道：
>
> Hi Yunqiang,
>
> On Thu, Jan 10, 2019 at 10:35:13AM -0800, Yunqiang Su wrote:
> > > 在 2019年1月11日，上午2:24，Paul Burton <pburton@wavecomp.com> 写道：
> > > Hi YunQiang,
> > >
> > > On Tue, Jan 08, 2019 at 01:45:10PM +0800, YunQiang Su wrote:
> > >> From: YunQiang Su <ysu@wavecomp.com>
> > >>
> > >> Octeon has an boot-time option to disable pcie.
> > >>
> > >> Since MSI depends on PCI-E, we should also disable MSI also with
> > >> this options is on.
> > >
> > > Does this fix a bug you're seeing? Or is it just intended to avoid
> > > redundant work?
> >
> > I have no idea whether this is a bug or new feathers.
> > I get an Cavium machine, which has no PCI at all, and so I have to disable the PCI totally.
> >
> > For me there are 2 ways: disable on build-time or disable on runtime.
> > Since Debian prefer to use a single kernel image.
> > So I need to disable it on runtime.
>
> Let me phrase this another way - if you boot with PCIe disabled, but
> without your patch applied, what happens? Does the system work or does
> it break?

With pcie disabled pcie with pcie-octeon.pcie_disable, and without this patch,
the kernel will fail to boot very early.

On https://elixir.bootlin.com/linux/latest/source/arch/mips/pci/msi-octeon.c#L399
request_irq

>
> You must have written the patch for a reason, I just want to know what
> that reason is.
>
> > > If it fixes a bug then I'll apply it to mips-fixes & copy stable,
> > > otherwise I'll apply it to mips-next & not copy stable.
> >
> > I prefer it to be backported.
>
> Only if it fixes a bug.
>
> Thanks,
>     Paul
