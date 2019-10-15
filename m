Return-Path: <SRS0=OYJd=YI=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43116ECE58F
	for <linux-mips@archiver.kernel.org>; Tue, 15 Oct 2019 23:27:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F649214AE
	for <linux-mips@archiver.kernel.org>; Tue, 15 Oct 2019 23:27:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387949AbfJOX1Q (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Tue, 15 Oct 2019 19:27:16 -0400
Received: from eddie.linux-mips.org ([148.251.95.138]:46178 "EHLO
        cvs.linux-mips.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726974AbfJOX1Q (ORCPT
        <rfc822;linux-mips@vger.kernel.org>); Tue, 15 Oct 2019 19:27:16 -0400
Received: (from localhost user: 'macro', uid#1010) by eddie.linux-mips.org
        with ESMTP id S23994554AbfJOX1JicQhA (ORCPT
        <rfc822;linux-mips@vger.kernel.org> + 2 others);
        Wed, 16 Oct 2019 01:27:09 +0200
Date:   Wed, 16 Oct 2019 00:27:09 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@linux-mips.org>
To:     Paul Burton <paul.burton@mips.com>
cc:     Jiaxun Yang <jiaxun.yang@flygoat.com>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
        Meng Zhuo <mengzhuo1203@gmail.com>,
        Paul Burton <pburton@wavecomp.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>
Subject: Re: [PATCH v1] MIPS: elf_hwcap: Export userspace ASEs
In-Reply-To: <MWHPR2201MB127715CCA6D7B8CCBCCC2683C1940@MWHPR2201MB1277.namprd22.prod.outlook.com>
Message-ID: <alpine.LFD.2.21.1910160023280.25496@eddie.linux-mips.org>
References: <20191010150157.17075-1-jiaxun.yang@flygoat.com> <MWHPR2201MB127715CCA6D7B8CCBCCC2683C1940@MWHPR2201MB1277.namprd22.prod.outlook.com>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

On Thu, 10 Oct 2019, Paul Burton wrote:

> > A Golang developer reported MIPS hwcap isn't reflecting instructions
> > that the processor actually supported so programs can't apply optimized
> > code at runtime.
> > 
> > Thus we export the ASEs that can be used in userspace programs.
> 
> Applied to mips-fixes.

 This makes a part of the user ABI, so I would advise discussing this with 
libc folks.  Also you probably want to report microMIPS support too.

  Maciej
