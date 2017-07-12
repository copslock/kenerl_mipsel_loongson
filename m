Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 13 Jul 2017 01:20:54 +0200 (CEST)
Received: from smtp.codeaurora.org ([198.145.29.96]:42172 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23991058AbdGLXUpwRjw2 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 13 Jul 2017 01:20:45 +0200
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 4565661286; Wed, 12 Jul 2017 23:20:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1499901639;
        bh=OO6hcq3zhKLyIzfVz/ceNOVg8GzXvkKegQUtNaTx5No=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AQ4pdT0qhBk/IoxlV0kg8udcPuyFJoeb3pXkoE+fzxCudpvvhBQTzwAJKuThcn1Pq
         yMu7Vd8SatJI7PQQQt4egn2Scy5v2yKsI8FjVOK+e9Gx6zZHcimOaszixXgclTDDa+
         V5goJH0rhYp5wGh/1TB5fBYDd2WhqyWVKBriQ950=
Received: from localhost (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: sboyd@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 46B6A61201;
        Wed, 12 Jul 2017 23:20:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1499901638;
        bh=OO6hcq3zhKLyIzfVz/ceNOVg8GzXvkKegQUtNaTx5No=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VtgeYvK9fAOlG2AYH1U8DnKDMXuXJRJifLIaHm/avYKcDJM5P6fkxc5kU5qCM2R3n
         2WXmcYZq0FjJ3IkMXmMQQ101PYY4XWYJhg/hkwu3aF/9ZPtFCJapDAoJafq3+yeFWz
         q3HphMRH2uoG8Yojfw6GiakXH5CXm38/bjwP7PE8=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 46B6A61201
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=sboyd@codeaurora.org
Date:   Wed, 12 Jul 2017 16:20:37 -0700
From:   Stephen Boyd <sboyd@codeaurora.org>
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Paul Burton <paul.burton@imgtec.com>,
        Maarten ter Huurne <maarten@treewalker.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mips@linux-mips.org, linux-clk@vger.kernel.org
Subject: Re: [PATCH v3 01/18] clk: ingenic: Use const pointer to clk_ops in
 struct
Message-ID: <20170712232037.GR22780@codeaurora.org>
References: <20170607200439.24450-2-paul@crapouillou.net>
 <20170702163016.6714-1-paul@crapouillou.net>
 <20170702163016.6714-2-paul@crapouillou.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170702163016.6714-2-paul@crapouillou.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <sboyd@codeaurora.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59102
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

On 07/02, Paul Cercueil wrote:
> The CGU common code does not modify the pointed clk_ops structure, so it
> should be marked as const.
> 
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> ---

Sorry I forgot, did you want an ack for these clk patches or for
me to take them through clk tree. If it's the ack case,

Acked-by: Stephen Boyd <sboyd@codeaurora.org>

for patches 1 through 6.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
