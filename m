Return-Path: <SRS0=HboV=W5=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BE72C3A59E
	for <linux-mips@archiver.kernel.org>; Mon,  2 Sep 2019 17:47:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D75D208E4
	for <linux-mips@archiver.kernel.org>; Mon,  2 Sep 2019 17:47:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726518AbfIBRrh (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Mon, 2 Sep 2019 13:47:37 -0400
Received: from emh02.mail.saunalahti.fi ([62.142.5.108]:51060 "EHLO
        emh02.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725781AbfIBRrh (ORCPT
        <rfc822;linux-mips@vger.kernel.org>); Mon, 2 Sep 2019 13:47:37 -0400
Received: from darkstar.musicnaut.iki.fi (85-76-83-161-nat.elisa-mobile.fi [85.76.83.161])
        by emh02.mail.saunalahti.fi (Postfix) with ESMTP id 78BEE207D8;
        Mon,  2 Sep 2019 20:47:35 +0300 (EEST)
Date:   Mon, 2 Sep 2019 20:47:35 +0300
From:   Aaro Koskinen <aaro.koskinen@iki.fi>
To:     Fredrik Noring <noring@nocrew.org>
Cc:     Jiaxun Yang <jiaxun.yang@flygoat.com>, linux-mips@vger.kernel.org
Subject: Re: [PATCH 094/120] MIPS: PS2: FB: Frame buffer driver for the
 PlayStation 2
Message-ID: <20190902174735.GA4339@darkstar.musicnaut.iki.fi>
References: <cover.1567326213.git.noring@nocrew.org>
 <4927c42fb3401c42c4c5a077f272331ac79d80b1.1567326213.git.noring@nocrew.org>
 <1003c9cc-c30e-00a7-7494-4f1cb4862e88@flygoat.com>
 <20190902144007.GA2479@sx9>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190902144007.GA2479@sx9>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

Hi,

On Mon, Sep 02, 2019 at 04:40:07PM +0200, Fredrik Noring wrote:
> Hi Jiaxun Yang,
> 
> > According to kernel policy[1] no more new FBDev driver would be accepted.
> > 
> > Please refactor it to DRM.
> 
> I had the impression that the DRM does not support a kernel console?

DRM drivers do provide FB console.

A.
