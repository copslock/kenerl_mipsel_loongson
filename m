Return-Path: <SRS0=2fGM=PS=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFEFAC43387
	for <linux-mips@archiver.kernel.org>; Thu, 10 Jan 2019 18:50:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA2BB206B7
	for <linux-mips@archiver.kernel.org>; Thu, 10 Jan 2019 18:50:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727846AbfAJSuK convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@archiver.kernel.org>);
        Thu, 10 Jan 2019 13:50:10 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:36257 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727000AbfAJSuK (ORCPT
        <rfc822;linux-mips@vger.kernel.org>); Thu, 10 Jan 2019 13:50:10 -0500
Received: by mail-pl1-f196.google.com with SMTP id g9so5574933plo.3
        for <linux-mips@vger.kernel.org>; Thu, 10 Jan 2019 10:50:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=IIpCW1vH8UNUGopI0wIG9UyyaU26OEXf1JrSBBlIMk8=;
        b=AWaGBBxaN/GfmVuT8lOlj47V9Z1Xrq7GiMHPwqLbpVt6fAwbNHEUzgEfjUyQFpWnAN
         xGuq5RgUJZ/yEzqXLiQut4Zz+I0dSRu5ulkeC/2xyEs5d7nK/YRXjbu46xlc9gslsZQR
         fKYXlPD6/QgdqtSBdiZ57E0QoiICtqNfVyQdPZntl5zNHCLkYk8KsnpfU95Zt5DrTFOa
         QuYkMI0kCAWpLW+HaF/2+MBiYCYLNVDeuDRJ+QCt+ci/b7hcI/lpPm7wAzSCJyiOHUYy
         DPXdP7kJK+FNxN8pjzCfa3HTuTg7DWc8/5aTeFoJs5Sc+8XxT+eIyWzV+/B7xBRrEXgI
         O9xA==
X-Gm-Message-State: AJcUukeYPR+1GF0OiSfd7rOGq2Aw6Shp1ix5aTlzlpy//hyOHQ4Ndq/t
        VKt7Jh7JDUPkVfJdtbxIq1CGJdKE47Pk7gTlNn0=
X-Google-Smtp-Source: ALg8bN4PaYPeX+z/yYi5QcJVDHju+JfeBT3Y8zyPBgXF3FqEos73dv4Uj+UJcmIbv74V70f7WYtbUGdMnPx2sNnlN4Y=
X-Received: by 2002:a17:902:7c82:: with SMTP id y2mr11265549pll.33.1547146209682;
 Thu, 10 Jan 2019 10:50:09 -0800 (PST)
MIME-Version: 1.0
References: <20190108054510.7393-1-syq@debian.org> <20190110182443.dic3trktlnn23ynn@pburton-laptop>
 <D0125B24-7506-48D0-B2A8-D1D1AC75ECC1@wavecomp.com> <20190110184530.7odyys2qyrmfcjkk@pburton-laptop>
In-Reply-To: <20190110184530.7odyys2qyrmfcjkk@pburton-laptop>
From:   YunQiang Su <syq@debian.org>
Date:   Fri, 11 Jan 2019 02:49:58 +0800
Message-ID: <CAKcpw6XEZeL4AbtzWNRvn=jEOZijPRbk-U8PZ7T+Y2-MAfO_vQ@mail.gmail.com>
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
>
Yes. I think it is another bug.
https://lore.kernel.org/linux-mips/CAKcpw6Uf=_f4T1ZBLnp9gWrp1rjwuLfpF0h865-U4BOpuFLiiw@mail.gmail.com/T/#t

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
