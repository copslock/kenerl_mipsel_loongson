Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 21 Jun 2017 23:50:48 +0200 (CEST)
Received: from smtp.codeaurora.org ([198.145.29.96]:38262 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23993897AbdFUVumJ9aRv (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 21 Jun 2017 23:50:42 +0200
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 70A8360A05; Wed, 21 Jun 2017 21:50:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1498081840;
        bh=2eTbAnDfJhVEjFMLNuMjecEXAanBiH9VzamBcRQChvw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Cd3cU3Im2b1Ho4yVLvGjSHfUkOoddtwTceAfei1bl1wpWAbnXRO68+kqDRw2P4tLP
         LmGBcTCelABzhVjNgLATR1uYbo5NtqyzoAqXBDpwOyNWmbh8KDmuydcRLlgphUI6iM
         qTk28wYGxT0N1vGwiLx/SeSH0MJgIMNaOWx5r2l0=
Received: from localhost (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: sboyd@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id B0B2160312;
        Wed, 21 Jun 2017 21:50:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1498081839;
        bh=2eTbAnDfJhVEjFMLNuMjecEXAanBiH9VzamBcRQChvw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Cq4q4DmeFgw0xzCw/0COzcBHZKDaXtQd8tSyYyQY26+5d78DE7z+Ks3ajBwRmiWN4
         Pe7FAOyIfNOLmVDlcnIH/cZ4o00VpPTYaPpZv9Vk3JF1RIBOFUaG6P4miW5GcAaphc
         hA0mqKHGnLXJUsysLpTmymDKoIhohrtPiuUfvCpk=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org B0B2160312
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=sboyd@codeaurora.org
Date:   Wed, 21 Jun 2017 14:50:38 -0700
From:   Stephen Boyd <sboyd@codeaurora.org>
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Paul Burton <paul.burton@imgtec.com>,
        Maarten ter Huurne <maarten@treewalker.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mips@linux-mips.org, linux-clk@vger.kernel.org
Subject: Re: [PATCH v2 01/17] clk: ingenic: Use const pointer to clk_ops in
 struct
Message-ID: <20170621215038.GG4493@codeaurora.org>
References: <20170607200439.24450-2-paul@crapouillou.net>
 <20170620151855.19399-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170620151855.19399-1-paul@crapouillou.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <sboyd@codeaurora.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58738
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

On 06/20, Paul Cercueil wrote:
> The CGU common code does not modify the pointed clk_ops structure, so it
> should be marked as const.
> 
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> ---

How did you want to merge this series? I can ack clk patches if
you like, or apply the clk patches to the clk tree.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
