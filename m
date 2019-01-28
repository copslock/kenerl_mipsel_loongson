Return-Path: <SRS0=zZS8=QE=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6A75C282C8
	for <linux-mips@archiver.kernel.org>; Mon, 28 Jan 2019 16:45:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87DE32084C
	for <linux-mips@archiver.kernel.org>; Mon, 28 Jan 2019 16:45:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548693959;
	bh=FMrWkSfoQ36S6a8jaQ6xFndjDmQPsKtgVeyw0HL1gAM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=jXlhVyW9+j8RvvxXt1VzMSeHcS0ASoqngSZr2MEmP602SR3AZhbEuPYQbYzWDIcm7
	 eC46X/Z7p0D60ZMwwjIbKUaMbRdH/cD4TOyOu8b00KAsS/4La/ONd/2vPFGBx9hrHW
	 q39L+rDTq0ITF+cMID1OeE4uIbdWmyu+eqIYl7SM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389272AbfA1QWs (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Mon, 28 Jan 2019 11:22:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:58856 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388709AbfA1QWs (ORCPT <rfc822;linux-mips@vger.kernel.org>);
        Mon, 28 Jan 2019 11:22:48 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DF3E92084A;
        Mon, 28 Jan 2019 16:22:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548692567;
        bh=FMrWkSfoQ36S6a8jaQ6xFndjDmQPsKtgVeyw0HL1gAM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GLVKIxMTLz6Pw4gjjAmFcYxIUvxSnGFqcNY3AztdjIOJGsGF5ihb+Jb8pqm1AkhHz
         RWShgWQInw9dAFydMPXYGj7F8xLuYp4LQVIJHMSo8jF01wQAX7fwhYa5Q3UxfuLz//
         Xji2LvJlE1HBF83YhO6Th2GlVOwQr0UWxkoTUKqg=
Date:   Mon, 28 Jan 2019 17:22:45 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Zhou Yanjie <zhouyanjie@zoho.com>
Cc:     linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        robh+dt@kernel.org, paul.burton@mips.com, jslaby@suse.com,
        mark.rutland@arm.com, syq@debian.org, jiaxun.yang@flygoat.com,
        772753199@qq.com
Subject: Re: [PATCH v2 1/2] Serial: Ingenic: Add X1000 suppor for the UART
 driver.
Message-ID: <20190128162245.GA25853@kroah.com>
References: <1548667176-119830-1-git-send-email-zhouyanjie@zoho.com>
 <1548683821-120924-1-git-send-email-zhouyanjie@zoho.com>
 <1548683821-120924-2-git-send-email-zhouyanjie@zoho.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1548683821-120924-2-git-send-email-zhouyanjie@zoho.com>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

On Mon, Jan 28, 2019 at 09:57:00PM +0800, Zhou Yanjie wrote:
> Add support for probing the 8250_ingenic driver on the
> X1000 Soc from Ingenic.
> 
> Signed-off-by: Zhou Yanjie <zhouyanjie@zoho.com>
> ---
>  drivers/tty/serial/8250/8250_ingenic.c | 13 +++++++++----
>  1 file changed, 9 insertions(+), 4 deletions(-)

Your subject lines are still identical for both patches :(
