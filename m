Return-Path: <SRS0=Eolf=YJ=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8167C4360C
	for <linux-mips@archiver.kernel.org>; Wed, 16 Oct 2019 09:46:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3ED420640
	for <linux-mips@archiver.kernel.org>; Wed, 16 Oct 2019 09:46:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726689AbfJPJqU (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Wed, 16 Oct 2019 05:46:20 -0400
Received: from eddie.linux-mips.org ([148.251.95.138]:40628 "EHLO
        cvs.linux-mips.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389894AbfJPJqU (ORCPT
        <rfc822;linux-mips@vger.kernel.org>); Wed, 16 Oct 2019 05:46:20 -0400
Received: (from localhost user: 'macro', uid#1010) by eddie.linux-mips.org
        with ESMTP id S23990850AbfJPJqQlFWSP (ORCPT
        <rfc822;stable@vger.kernel.org> + 1 other);
        Wed, 16 Oct 2019 11:46:16 +0200
Date:   Wed, 16 Oct 2019 10:46:16 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@linux-mips.org>
To:     Jiaxun Yang <jiaxun.yang@flygoat.com>
cc:     Paul Burton <paul.burton@mips.com>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
        Meng Zhuo <mengzhuo1203@gmail.com>,
        Paul Burton <pburton@wavecomp.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH v1] MIPS: elf_hwcap: Export userspace ASEs
In-Reply-To: <d1d4cff7-ac3e-a9ab-ecee-cc941b0895e7@flygoat.com>
Message-ID: <alpine.LFD.2.21.1910161030560.25496@eddie.linux-mips.org>
References: <20191010150157.17075-1-jiaxun.yang@flygoat.com> <MWHPR2201MB127715CCA6D7B8CCBCCC2683C1940@MWHPR2201MB1277.namprd22.prod.outlook.com> <alpine.LFD.2.21.1910160023280.25496@eddie.linux-mips.org> <d1d4cff7-ac3e-a9ab-ecee-cc941b0895e7@flygoat.com>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

On Wed, 16 Oct 2019, Jiaxun Yang wrote:

> >   This makes a part of the user ABI, so I would advise discussing this with
> > libc folks.  Also you probably want to report microMIPS support too.
> 
> How can hwcap advance libc? I know that Arm world is using it to probe SIMD
> extensions in high-level programs like ffmpeg.

 Auxiliary vector entries do get used by libc, including HWCAP, so if you 
introduce new stuff, then you want to consult its potential users.  And 
this is a part of the ABI, so once there it's cast in stone forever.

> microMIPS binary can't be applied at runtime, so userspace programs shouldn't
> aware that.

 Mixing regular MIPS and microMIPS software is fully supported at load 
time as indirect calls made through the GOT (or PLTGOT) are ISA-agnostic, 
i.e. you can use a microMIPS DSO with a regular MIPS executable and vice 
versa.  This is something the dynamic loader can take advantage of, e.g. 
choosing a smaller microMIPS DSO where supported by hardware over a 
corresponding regular MIPS one will usually have a performance advantage 
due to a smaller cache footprint.

 Actually regular MIPS ISA support should be reported these days too, as 
you can have a pure microMIPS CPU with no regular MIPS ISA implemented.

>  Should I Cc this discussion to libc-alpha or other lists?

 For the GNU C Library <libc-alpha@sourceware.org> is indeed the right 
place; I can't speak for other libc implementations (uClibc, musl, etc.).

  Maciej
