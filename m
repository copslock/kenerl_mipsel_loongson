Return-Path: <SRS0=5/jd=PN=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3709C43387
	for <linux-mips@archiver.kernel.org>; Sat,  5 Jan 2019 00:26:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8EA720874
	for <linux-mips@archiver.kernel.org>; Sat,  5 Jan 2019 00:26:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726094AbfAEA0s convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@archiver.kernel.org>);
        Fri, 4 Jan 2019 19:26:48 -0500
Received: from mail-pl1-f173.google.com ([209.85.214.173]:37544 "EHLO
        mail-pl1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725862AbfAEA0s (ORCPT
        <rfc822;linux-mips@vger.kernel.org>); Fri, 4 Jan 2019 19:26:48 -0500
Received: by mail-pl1-f173.google.com with SMTP id b5so18104748plr.4
        for <linux-mips@vger.kernel.org>; Fri, 04 Jan 2019 16:26:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=CM1QkohDTOGCRR1No38+d7vx50pb8W63o1Vopl/ie7g=;
        b=QMVC0/BZnk9dv62j7H0rksdwiw/6S3Zu5zfRikBWoFjibGE/I2ndvVQsKFXtf98Zyo
         q+YdseBUGLqD1L38igPs3npoXtyOBrv9FGS7NKc/rlnE929TWpYWspjy4Innts0GD+hX
         MLhWpWJeoKLRSUecFQas2gtPaZJ0TjHjp10g8P45AdpU3xVr5GurwdymfguFFlDRbFPU
         KYayEUQyCe/HDaEf8Mzf8fUm/2/IFmBNiOQTLInpVfXTtgpPiP8/p3y9A6XFtsDk5RVX
         mloza2zoocBIoicAHv9Bj0TVvRQciTqc2OSV6Oyz/qT69O4CD8N2j9UiMubDs4pq9ZDd
         YlHQ==
X-Gm-Message-State: AJcUukeRGp7tc0ovrwatuMl7Drzd40p8bWksLtXZfguJszkzEhQmsyYK
        PMZwv6RBWKWxaJSjlSC5w8ZmhOEJPkEXbbfETnZC1YMh
X-Google-Smtp-Source: ALg8bN7lJUpeo3lx+yOidLR9cRhIdMDQyMBrtzBk4X8/uXC2h+L80PesKRvtt1vVtvczZpuZqcqLXV8//R2kPmf67Lc=
X-Received: by 2002:a17:902:9a41:: with SMTP id x1mr52327024plv.126.1546648007573;
 Fri, 04 Jan 2019 16:26:47 -0800 (PST)
MIME-Version: 1.0
References: <CAKcpw6X_Q0iighiBXYvikNT8UDXME1F2wkEjzWHHDGK2_RNuGw@mail.gmail.com>
 <20190104194539.GJ27785@darkstar.musicnaut.iki.fi>
In-Reply-To: <20190104194539.GJ27785@darkstar.musicnaut.iki.fi>
From:   YunQiang Su <syq@debian.org>
Date:   Sat, 5 Jan 2019 08:26:37 +0800
Message-ID: <CAKcpw6Uf=_f4T1ZBLnp9gWrp1rjwuLfpF0h865-U4BOpuFLiiw@mail.gmail.com>
Subject: =?UTF-8?Q?Re=3A_=5BBUG=5D_Data_Bus_Erorr_on_Ubiquiti_Networks_=2D_Edge?=
        =?UTF-8?Q?Router=E2=84=A2_Infinity?=
To:     Aaro Koskinen <aaro.koskinen@iki.fi>
Cc:     steven.hill@cavium.com, david.daney@cavium.com,
        linux-mips <linux-mips@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

Aaro Koskinen <aaro.koskinen@iki.fi> 于2019年1月5日周六 上午3:45写道：
>
> Hi,
>
> On Tue, Jan 01, 2019 at 04:42:03PM +0800, YunQiang Su wrote:
> > I met a kernel problem for both 4.9 and 4.19 kernel
> >
> > This error happens in pci/pcie-octeon.c, in function
> >    __cvmx_pcie_rc_initialize_gen2
> >
> > ciu_soft_prst.u64 = cvmx_read_csr(CVMX_CIU_SOFT_PRST);
> >
> > When disabble CONFIG_PCI, it won't meet this problem.
>
> Is this CN78XX hardware? Also can you confirm the board does not have
> any PCI Express (check U-Boot and vendor kernel logs)?
>

it is 7360, and its u-boot disables PCI host.

> On EdgeRouter 4 (CN70XX) kernel misdetects PCIe ports, and there are
> error logs and delays during this, but the board still boots up.
>
> Probably nobody has any OCTEON III board with working PCIe running
> mainline kernel, so we should just make the setup fail early.
>
Sure, we should make it fail early.

> A.
