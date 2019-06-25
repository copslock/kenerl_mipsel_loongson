Return-Path: <SRS0=yIBi=UY=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35C0EC48BD7
	for <linux-mips@archiver.kernel.org>; Tue, 25 Jun 2019 22:48:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A10320645
	for <linux-mips@archiver.kernel.org>; Tue, 25 Jun 2019 22:48:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561502932;
	bh=NDYFkLEooqfnuNkcMLlYIiHK+GztzIF7WjriV25gxbo=;
	h=In-Reply-To:References:To:From:Subject:Cc:Date:List-ID:From;
	b=N/BfwmyGjN0zsvKfHnwKQZB3huAeKAYBndhB0Z0fWrGVpRc9/rkaj43qhzKfFtXtS
	 DEfN/vzZRv6Ofxo3vrYxmByFbGFt4asiXvLLUdoXmCf1Jrte68hmzMqO9b1IhB+9KG
	 cgr8tvcAzFj9SRx10fVHb0iFr3Y5+Cl82URpM1Tk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726463AbfFYWsl (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Tue, 25 Jun 2019 18:48:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:44988 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726450AbfFYWsk (ORCPT <rfc822;linux-mips@vger.kernel.org>);
        Tue, 25 Jun 2019 18:48:40 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 55F63208E3;
        Tue, 25 Jun 2019 22:48:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561502920;
        bh=NDYFkLEooqfnuNkcMLlYIiHK+GztzIF7WjriV25gxbo=;
        h=In-Reply-To:References:To:From:Subject:Cc:Date:From;
        b=GHYx9ame88Q6qeIBdaST/WA+KS0wl7fo9s2ofQ7i4CpBSgxDxI95MbSnYrOOTBVVw
         rFS4JjI1bmf6NJtmh4kgkD2SBL3jCUCEx3hBaID2JqEk0eEKq+tHD1B8oQP4XWfpIP
         Hob5vVcZzEU9jocAZOIkRGc2SfzDbtWe8LuTIBV8=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190611180757.32299-4-paul@crapouillou.net>
References: <20190611180757.32299-1-paul@crapouillou.net> <20190611180757.32299-4-paul@crapouillou.net>
To:     James Hogan <jhogan@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Paul Burton <paul.burton@mips.com>,
        Paul Cercueil <paul@crapouillou.net>,
        Ralf Baechle <ralf@linux-mips.org>
From:   Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH v2 4/5] clk: ingenic: Remove unused functions
Cc:     od@zcrc.me, linux-mips@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Paul Cercueil <paul@crapouillou.net>
User-Agent: alot/0.8.1
Date:   Tue, 25 Jun 2019 15:48:39 -0700
Message-Id: <20190625224840.55F63208E3@mail.kernel.org>
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

Quoting Paul Cercueil (2019-06-11 11:07:56)
> These functions are not called anywhere anymore, they can safely be
> removed.
>=20
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> ---

Applied to clk-next

