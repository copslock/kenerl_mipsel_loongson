Return-Path: <SRS0=tVub=Q5=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C490C43381
	for <linux-mips@archiver.kernel.org>; Fri, 22 Feb 2019 19:43:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31717206C0
	for <linux-mips@archiver.kernel.org>; Fri, 22 Feb 2019 19:43:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726213AbfBVTnq (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Fri, 22 Feb 2019 14:43:46 -0500
Received: from emh02.mail.saunalahti.fi ([62.142.5.108]:52796 "EHLO
        emh02.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725917AbfBVTnq (ORCPT
        <rfc822;linux-mips@vger.kernel.org>); Fri, 22 Feb 2019 14:43:46 -0500
Received: from darkstar.musicnaut.iki.fi (85-76-65-82-nat.elisa-mobile.fi [85.76.65.82])
        by emh02.mail.saunalahti.fi (Postfix) with ESMTP id 1898C20091;
        Fri, 22 Feb 2019 21:43:43 +0200 (EET)
Date:   Fri, 22 Feb 2019 21:43:43 +0200
From:   Aaro Koskinen <aaro.koskinen@iki.fi>
To:     Tom Li <tomli@tomli.me>
Cc:     James Hogan <jhogan@kernel.org>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Huacai Chen <chenhc@lemote.com>,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@vger.kernel.org
Subject: Re: CS5536 Spurious Interrupt Problem on Loongson2
Message-ID: <20190222194343.GA26495@darkstar.musicnaut.iki.fi>
References: <20190222143710.GA8504@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190222143710.GA8504@localhost.localdomain>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

Hi,

On Fri, Feb 22, 2019 at 10:37:11PM +0800, Tom Li wrote:
> Continue replying the original thread is off-topic and
> difficult to follow, so here I start a new thread for this problem.

The proper thread is here:
https://lore.kernel.org/linux-mips/20190106124607.GK27785@darkstar.musicnaut.iki.fi/#r

> Therefore, I'm suspicious that this problem is related to a specific firmware/
> hardware revision, or a probabilistic issue. PMON/EC version may be the first
> thing we need to confirm.
> 
> My system is,
> 
> $ cat /proc/cmdline
> PMON_VER=LM8089-1.4.9a EC_VER=PQ1D28 machtype=lemote-yeeloong-2f-8.9inches

Mini-PC does not have any EC. PMON is:
Version: PMON2000 2.1 (Bonito) #121: Mon Jan  5 14:19:11 CST 2009.

But firmware upgrade is not an option for me.

> Interrupts have no problem at all.

You should check "/proc/irq/14/spurious". Anyway, it well may be that some
machines work fine.

A.
