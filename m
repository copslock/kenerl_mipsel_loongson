Return-Path: <SRS0=/SDL=PM=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37E4EC43387
	for <linux-mips@archiver.kernel.org>; Fri,  4 Jan 2019 19:45:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 079BC218D3
	for <linux-mips@archiver.kernel.org>; Fri,  4 Jan 2019 19:45:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725936AbfADTpm (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Fri, 4 Jan 2019 14:45:42 -0500
Received: from emh01.mail.saunalahti.fi ([62.142.5.107]:55060 "EHLO
        emh01.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725930AbfADTpm (ORCPT
        <rfc822;linux-mips@vger.kernel.org>); Fri, 4 Jan 2019 14:45:42 -0500
Received: from darkstar.musicnaut.iki.fi (85-76-74-23-nat.elisa-mobile.fi [85.76.74.23])
        by emh01.mail.saunalahti.fi (Postfix) with ESMTP id 2A5BD200C2;
        Fri,  4 Jan 2019 21:45:39 +0200 (EET)
Date:   Fri, 4 Jan 2019 21:45:39 +0200
From:   Aaro Koskinen <aaro.koskinen@iki.fi>
To:     YunQiang Su <syq@debian.org>
Cc:     steven.hill@cavium.com, david.daney@cavium.com,
        linux-mips <linux-mips@vger.kernel.org>
Subject: Re: [BUG] Data Bus Erorr on =?utf-8?Q?Ubiq?=
 =?utf-8?Q?uiti_Networks_-_EdgeRouter=E2=84=A2?= Infinity
Message-ID: <20190104194539.GJ27785@darkstar.musicnaut.iki.fi>
References: <CAKcpw6X_Q0iighiBXYvikNT8UDXME1F2wkEjzWHHDGK2_RNuGw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKcpw6X_Q0iighiBXYvikNT8UDXME1F2wkEjzWHHDGK2_RNuGw@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

Hi,

On Tue, Jan 01, 2019 at 04:42:03PM +0800, YunQiang Su wrote:
> I met a kernel problem for both 4.9 and 4.19 kernel
> 
> This error happens in pci/pcie-octeon.c, in function
>    __cvmx_pcie_rc_initialize_gen2
> 
> ciu_soft_prst.u64 = cvmx_read_csr(CVMX_CIU_SOFT_PRST);
> 
> When disabble CONFIG_PCI, it won't meet this problem.

Is this CN78XX hardware? Also can you confirm the board does not have
any PCI Express (check U-Boot and vendor kernel logs)?

On EdgeRouter 4 (CN70XX) kernel misdetects PCIe ports, and there are
error logs and delays during this, but the board still boots up.

Probably nobody has any OCTEON III board with working PCIe running
mainline kernel, so we should just make the setup fail early.

A.
