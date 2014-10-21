Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 21 Oct 2014 23:34:00 +0200 (CEST)
Received: from smtp.codeaurora.org ([198.145.11.231]:47236 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27012079AbaJUVd6AWaNV (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 21 Oct 2014 23:33:58 +0200
Received: from smtp.codeaurora.org (localhost [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id DE2F313FD91;
        Tue, 21 Oct 2014 21:33:50 +0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 486)
        id CDF9A13FD97; Tue, 21 Oct 2014 21:33:50 +0000 (UTC)
Received: from [10.46.167.8] (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: sboyd@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id C408B13FD91;
        Tue, 21 Oct 2014 21:33:49 +0000 (UTC)
Message-ID: <5446D13C.5020402@codeaurora.org>
Date:   Tue, 21 Oct 2014 14:33:48 -0700
From:   Stephen Boyd <sboyd@codeaurora.org>
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.2.0
MIME-Version: 1.0
To:     Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Mike Turquette <mturquette@linaro.org>
CC:     Javier Martinez Canillas <javier.martinez@collabora.co.uk>,
        Jonathan Corbet <corbet@lwn.net>,
        Ralf Baechle <ralf@linux-mips.org>,
        Boris Brezillon <boris.brezillon@free-electrons.com>,
        =?windows-1252?Q?Emilio_L=F3pez?= <emilio@elopez.com.ar>,
        Maxime Ripard <maxime.ripard@free-electrons.com>,
        Manuel Lauss <manuel.lauss@gmail.com>,
        Alex Elder <elder@linaro.org>,
        Matt Porter <mporter@linaro.org>,
        Tim Kryger <tim.kryger@linaro.org>,
        Haojian Zhuang <haojian.zhuang@linaro.org>,
        Zhangfei Gao <zhangfei.gao@linaro.org>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Arnd Bergmann <arnd@arndb.de>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v4 6/8] clk: Change clk_ops->determine_rate to return
 a clk_hw as the best parent
References: <1413812442-24956-1-git-send-email-tomeu.vizoso@collabora.com> <1413812442-24956-7-git-send-email-tomeu.vizoso@collabora.com>
In-Reply-To: <1413812442-24956-7-git-send-email-tomeu.vizoso@collabora.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: ClamAV using ClamSMTP
Return-Path: <sboyd@codeaurora.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43434
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sboyd@codeaurora.org
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

On 10/20/2014 06:40 AM, Tomeu Vizoso wrote:
> This is in preparation for clock providers to not have to deal with struct clk.
>
> Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
>
>

Reviewed-by: Stephen Boyd <sboyd@codeaurora.org>

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
