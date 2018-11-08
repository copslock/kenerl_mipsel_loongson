Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 08 Nov 2018 19:20:11 +0100 (CET)
Received: from mail.kernel.org ([198.145.29.99]:39688 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23990429AbeKHSTbwzgN8 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 8 Nov 2018 19:19:31 +0100
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3438720825;
        Thu,  8 Nov 2018 18:19:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541701170;
        bh=hyuGyPWsjoFKYyWOu9UL+k0JbgP06pF32daBf9nnD20=;
        h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
        b=hvVRi1byTfQYvkp8D+ScGxNZwK0svBIhfeqlMRyshXbg7YsnajjCXTmx8BBDFkd83
         TnO+96v/Q2rMEr5f4ge3YfBnmcU5d1Pkn65I1kmepxrdCQnBv9pJkx3EMf5Y+XnXej
         G1/FNbE1Y9u10H02vZf+EvtMZCXrzndWvFhjOmTI=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
To:     Yi Wang <wang.yi59@zte.com.cn>, paul.burton@mips.com
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <1540971702-3133-2-git-send-email-wang.yi59@zte.com.cn>
Cc:     mturquette@baylibre.com, linux-mips@linux-mips.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        zhong.weidong@zte.com.cn, Yi Wang <wang.yi59@zte.com.cn>
References: <1540971702-3133-1-git-send-email-wang.yi59@zte.com.cn>
 <1540971702-3133-2-git-send-email-wang.yi59@zte.com.cn>
Message-ID: <154170116960.88331.164103375264551287@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH v3 1/2] clk: boston: fix possible memory leak in
 clk_boston_setup()
Date:   Thu, 08 Nov 2018 10:19:29 -0800
Return-Path: <sboyd@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 67176
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

Quoting Yi Wang (2018-10-31 00:41:41)
> Smatch report warnings:
> drivers/clk/imgtec/clk-boston.c:76 clk_boston_setup() warn: possible memory leak of 'onecell'
> drivers/clk/imgtec/clk-boston.c:83 clk_boston_setup() warn: possible memory leak of 'onecell'
> drivers/clk/imgtec/clk-boston.c:90 clk_boston_setup() warn: possible memory leak of 'onecell'
> 
> 'onecell' is malloced in clk_boston_setup(), but not be freed
> before leaving from the error handling cases.
> 
> Signed-off-by: Yi Wang <wang.yi59@zte.com.cn>
> ---

Applied to clk-next
