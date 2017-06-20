Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 20 Jun 2017 02:27:24 +0200 (CEST)
Received: from smtp.codeaurora.org ([198.145.29.96]:58164 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992100AbdFTA1DWtt8i (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 20 Jun 2017 02:27:03 +0200
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 72B9D607A0; Tue, 20 Jun 2017 00:27:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1497918422;
        bh=wP7cwpDx1tj2nS8/REt1knHHG8Zv+r6dz8XP4W3irK8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=S+uJkjQ+d7/3gg5EKv7oljsOt2qMGVnMMa1CwV8GTC2iPFvXZzZSX8+rJ1xh5tYxL
         LvBxgvE0tJhMuHUKVexJwDYf7ItSv/Dxml+5dWhim310wx77YxNac8O/DfsigyAeA/
         /HJLA4IulA/PmHTZ63qBMZoQnjAHsR+yILjiPdPI=
Received: from localhost (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: sboyd@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id B1D6E605BD;
        Tue, 20 Jun 2017 00:27:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1497918421;
        bh=wP7cwpDx1tj2nS8/REt1knHHG8Zv+r6dz8XP4W3irK8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fUkmy/wIhm/FDYV0cf318ihYQZJSA/5m8amRnspgcHZgVWmUZHx8w2XF9vait+MGw
         IgFQlgdUOSscvAlWvnae1Qa1eZSDLjAqgkUqt2mJ30LXI3s5gr+rJRZ/yvpSWrEecJ
         dGLkX0bNM10dl3ZV0l/GG3a8NIuqZHCCmP+gzpc8=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org B1D6E605BD
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=sboyd@codeaurora.org
Date:   Mon, 19 Jun 2017 17:27:01 -0700
From:   Stephen Boyd <sboyd@codeaurora.org>
To:     Paul Burton <paul.burton@imgtec.com>
Cc:     linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-clk@vger.kernel.org
Subject: Re: [PATCH v5 1/4] dt-bindings: Document img,boston-clock binding
Message-ID: <20170620002701.GZ20170@codeaurora.org>
References: <20170617205249.1391-1-paul.burton@imgtec.com>
 <20170617205249.1391-2-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170617205249.1391-2-paul.burton@imgtec.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <sboyd@codeaurora.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58660
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

On 06/17, Paul Burton wrote:
> Add device tree binding documentation for the clocks provided by the
> MIPS Boston development board from Imagination Technologies, and a
> header file describing the available clocks for use by device trees &
> driver.
> 
> Signed-off-by: Paul Burton <paul.burton@imgtec.com>
> Cc: Frank Rowand <frowand.list@gmail.com>
> Cc: Michael Turquette <mturquette@baylibre.com>
> Cc: Ralf Baechle <ralf@linux-mips.org>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Stephen Boyd <sboyd@codeaurora.org>
> Cc: devicetree@vger.kernel.org
> Cc: linux-clk@vger.kernel.org
> Cc: linux-mips@linux-mips.org
> 
> ---

Acked-by: Stephen Boyd <sboyd@codeaurora.org>

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
