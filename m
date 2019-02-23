Return-Path: <SRS0=1Pqs=Q6=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9F8DC43381
	for <linux-mips@archiver.kernel.org>; Sat, 23 Feb 2019 15:30:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7CB220665
	for <linux-mips@archiver.kernel.org>; Sat, 23 Feb 2019 15:30:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725920AbfBWPan (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Sat, 23 Feb 2019 10:30:43 -0500
Received: from emh03.mail.saunalahti.fi ([62.142.5.109]:58248 "EHLO
        emh03.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725859AbfBWPan (ORCPT
        <rfc822;linux-mips@vger.kernel.org>); Sat, 23 Feb 2019 10:30:43 -0500
Received: from darkstar.musicnaut.iki.fi (85-76-65-82-nat.elisa-mobile.fi [85.76.65.82])
        by emh03.mail.saunalahti.fi (Postfix) with ESMTP id 1CD4C400CF;
        Sat, 23 Feb 2019 17:30:41 +0200 (EET)
Date:   Sat, 23 Feb 2019 17:30:40 +0200
From:   Aaro Koskinen <aaro.koskinen@iki.fi>
To:     Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc:     Tom Li <tomli@tomli.me>, Alexandre Oliva <lxoliva@fsfla.org>,
        James Hogan <jhogan@kernel.org>,
        Huacai Chen <chenhc@lemote.com>,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@vger.kernel.org
Subject: Re: CS5536 Spurious Interrupt Problem on Loongson2
Message-ID: <20190223153040.GB26495@darkstar.musicnaut.iki.fi>
References: <ora7in8tfs.fsf@lxoliva.fsfla.org>
 <20190223015650.GA8616@localhost.localdomain>
 <e57f51ad-4065-b652-ef0e-d93b084d938f@flygoat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e57f51ad-4065-b652-ef0e-d93b084d938f@flygoat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

Hi,

On Sat, Feb 23, 2019 at 02:08:38PM +0800, Jiaxun Yang wrote:
> 在 2019/2/23 9:56, Tom Li 写道:
> >On Fri, Feb 22, 2019 at 09:43:43PM +0200, Aaro Koskinen wrote:
> >>Mini-PC does not have any EC. PMON is:
> >>Version: PMON2000 2.1 (Bonito) #121: Mon Jan  5 14:19:11 CST 2009.
> 
> Check "env" variables in PMON shell. There night be some information such as
> version or build date.

It has:

   Version = LM6004-1.3.2
 BuildTime = "Jan  5 2009 14:18:56"

A.
