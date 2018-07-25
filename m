Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 26 Jul 2018 01:43:41 +0200 (CEST)
Received: from mail.kernel.org ([198.145.29.99]:53046 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23992960AbeGYXnhbf463 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 26 Jul 2018 01:43:37 +0200
Received: from localhost (unknown [104.132.1.75])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DC04020843;
        Wed, 25 Jul 2018 23:43:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1532562211;
        bh=Xpz05yOHXuOaXz5yICYb5lLz8DSVKMe03Lva9oeOe5M=;
        h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
        b=nJd2VZNLobe2r9v75BPM13p8i84y7EdzDV/JWBLTDOHGesWCqXSVPjcWgNyrHKQMn
         0lX+HwtdDHPw6iTQegnVY+xamKH7AWSOnr1nRKU9RD0UDL90uTMFWiPLbYJVn1e/rU
         XT0F8q1rxV7D1WwZ+TTpzr7OkGJbXt29+O5SMNAg=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
To:     =?utf-8?q?Andreas_F=C3=A4rber?= <afaerber@suse.de>,
        linux-mips@linux-mips.org
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <20180722212010.3979-16-afaerber@suse.de>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>, linux-kernel@vger.kernel.org,
        Govindraj Raja <Govindraj.Raja@imgtec.com>,
        =?utf-8?q?Andreas_F=C3=A4rber?= <afaerber@suse.de>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20180722212010.3979-1-afaerber@suse.de>
 <20180722212010.3979-16-afaerber@suse.de>
Message-ID: <153256221029.48062.5074371246522411479@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH 15/15] clk: pistachio: Fix wrong SDHost card speed
Date:   Wed, 25 Jul 2018 16:43:30 -0700
Return-Path: <sboyd@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 65149
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sboyd@kernel.org
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

Quoting Andreas Färber (2018-07-22 14:20:10)
> From: Govindraj Raja <Govindraj.Raja@imgtec.com>
> 
> The SDHost currently clocks the card 4x slower than it
> should do, because there is a fixed divide by 4 in the
> sdhost wrapper that is not present in the clock tree.
> To model this, add a fixed divide by 4 clock node in
> the SDHost clock path.
> 
> This will ensure the right clock frequency is selected when
> the mmc driver tries to configure frequency on card insert.
> 
> Signed-off-by: Govindraj Raja <Govindraj.Raja@imgtec.com>
> Signed-off-by: Andreas Färber <afaerber@suse.de>
> ---

Acked-by: Stephen Boyd <sboyd@kernel.org>
