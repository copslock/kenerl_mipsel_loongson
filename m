Return-Path: <SRS0=yIBi=UY=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73D40C48BD8
	for <linux-mips@archiver.kernel.org>; Tue, 25 Jun 2019 22:17:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 476C820883
	for <linux-mips@archiver.kernel.org>; Tue, 25 Jun 2019 22:17:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561501063;
	bh=HQ27fxr0ZnCr/zXy05lhsA8/iiTCNB/xaDEjAfuRrro=;
	h=In-Reply-To:References:To:Cc:Subject:From:Date:List-ID:From;
	b=XVCj70DYQwxdw1/TGbXFCFdwmfFRls6adY6qXIF547I6DHzWChCILKWDGqrzVrUhM
	 HctjliezrroeiibxF4a43gDpM0gsnr8in96jTUqJ/8guw2dFdwNowAtV6HVBpgs/6N
	 sl8YiajeXKNvIyNWqO7GKPPccCpUQ1TDNAbcH46Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726331AbfFYWRh (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Tue, 25 Jun 2019 18:17:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:58180 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725914AbfFYWRh (ORCPT <rfc822;linux-mips@vger.kernel.org>);
        Tue, 25 Jun 2019 18:17:37 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 853892086D;
        Tue, 25 Jun 2019 22:17:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561501056;
        bh=HQ27fxr0ZnCr/zXy05lhsA8/iiTCNB/xaDEjAfuRrro=;
        h=In-Reply-To:References:To:Cc:Subject:From:Date:From;
        b=n79BUbixZSY08kOmfpVsAsuUWP2HiIMOwm0Y5SZEZqQH3cJsb0dMSLNOCJh1KNvCV
         OzxzQ7LRTkwFiSb8TeZkzAAk1foGrXfAoLmmTdtGKSDYkJXnBgqfwKVERoJ1pC53u1
         J6dzbYKJH1bCIMHEBXTOdDMbK0BdWB9HV5+XUJC0=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190611180757.32299-1-paul@crapouillou.net>
References: <20190611180757.32299-1-paul@crapouillou.net>
To:     James Hogan <jhogan@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Paul Burton <paul.burton@mips.com>,
        Paul Cercueil <paul@crapouillou.net>,
        Ralf Baechle <ralf@linux-mips.org>
Cc:     od@zcrc.me, linux-mips@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH v2 1/5] clk: ingenic: Add missing header in cgu.h
From:   Stephen Boyd <sboyd@kernel.org>
User-Agent: alot/0.8.1
Date:   Tue, 25 Jun 2019 15:17:35 -0700
Message-Id: <20190625221736.853892086D@mail.kernel.org>
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

Quoting Paul Cercueil (2019-06-11 11:07:53)
> The cgu.h has structures that contain 'clk_onecell_data' and 'clk_hw'
> structures (no pointers), so the <linux/clk-provider.h> header should be
> included.
>=20
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> ---
>=20
> Notes:
>     v2: Rebase on v5.2-rc4

You seemed to miss my review comments on patch set #1.

https://lkml.kernel.org/r/155726035790.14659.7321778387595703949@swboyd.mtv=
.corp.google.com

