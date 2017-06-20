Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 20 Jun 2017 02:27:01 +0200 (CEST)
Received: from smtp.codeaurora.org ([198.145.29.96]:58074 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23991532AbdFTA0yP056i (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 20 Jun 2017 02:26:54 +0200
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id D5F566072F; Tue, 20 Jun 2017 00:26:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1497918412;
        bh=CLkNpnBfQV2yhBtyzMf1sLclTYr/9H2WzaQHCqqmy8M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=i7YaXc5p1BALl5ny1Mg/+aPs9sygGReE+yQnMi0KV5gDBjOWfcMsqJpDq0VbJvCOT
         Ut0M/EV/pPWVqNiKCHC0w3DgD7Is3M5JM65iZazwtXZcYOgOlDksAZm3rvol5gnkvW
         tZ8eN7upX3Me0nC8LJ9tGL+iujzV3XdGzxph0n/I=
Received: from localhost (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: sboyd@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id DBFAB6072F;
        Tue, 20 Jun 2017 00:26:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1497918412;
        bh=CLkNpnBfQV2yhBtyzMf1sLclTYr/9H2WzaQHCqqmy8M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=i7YaXc5p1BALl5ny1Mg/+aPs9sygGReE+yQnMi0KV5gDBjOWfcMsqJpDq0VbJvCOT
         Ut0M/EV/pPWVqNiKCHC0w3DgD7Is3M5JM65iZazwtXZcYOgOlDksAZm3rvol5gnkvW
         tZ8eN7upX3Me0nC8LJ9tGL+iujzV3XdGzxph0n/I=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org DBFAB6072F
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=sboyd@codeaurora.org
Date:   Mon, 19 Jun 2017 17:26:51 -0700
From:   Stephen Boyd <sboyd@codeaurora.org>
To:     Paul Burton <paul.burton@imgtec.com>
Cc:     linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org
Subject: Re: [PATCH v5 2/4] clk: boston: Add a driver for MIPS Boston board
 clocks
Message-ID: <20170620002651.GY20170@codeaurora.org>
References: <20170617205249.1391-1-paul.burton@imgtec.com>
 <20170617205249.1391-3-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170617205249.1391-3-paul.burton@imgtec.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <sboyd@codeaurora.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58659
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
> Add a driver for the clocks provided by the MIPS Boston board from
> Imagination Technologies. 2 clocks are provided - the system clock & the
> CPU clock - and each is a simple fixed rate clock whose frequency can be
> determined by reading a register provided by the board.
> 
> Signed-off-by: Paul Burton <paul.burton@imgtec.com>
> Cc: Michael Turquette <mturquette@baylibre.com>
> Cc: Ralf Baechle <ralf@linux-mips.org>
> Cc: Stephen Boyd <sboyd@codeaurora.org>
> Cc: linux-clk@vger.kernel.org
> Cc: linux-mips@linux-mips.org
> 
> ---

Acked-by: Stephen Boyd <sboyd@codeaurora.org>

Unless you wanted this to go through the clk tree?

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
