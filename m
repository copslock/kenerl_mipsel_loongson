Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 02 Jun 2017 19:49:20 +0200 (CEST)
Received: from smtp.codeaurora.org ([198.145.29.96]:46964 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23991955AbdFBRtOS0ieo (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 2 Jun 2017 19:49:14 +0200
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id A7A98608D4; Fri,  2 Jun 2017 17:49:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1496425752;
        bh=kJrrJDg6dTbmLjvKp+ZmweZPpWlfEMc+4iM+5h0Y48Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=C0yMLUM3GKTFRtvGKBJ9rQZ/58Sbw+y2HR3CjV5fJYthns+I26ZD//JjnhXUDKP4S
         lLj1as0uuSpU2pTmR+9ptrHVECMVKhDULsZSAKrNCd7NoXx7zoI1hPGIigJGAaQ4gn
         TmgE/E8i0IoDVCnsBhIE77G/94TrWgsloKYbI3r8=
Received: from localhost (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: sboyd@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id CF32C608D4;
        Fri,  2 Jun 2017 17:49:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1496425751;
        bh=kJrrJDg6dTbmLjvKp+ZmweZPpWlfEMc+4iM+5h0Y48Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UUVaC4S6fbRT3Vcw2KWj0qWo55rb/UMfRb8yxHU5/dfsmz7Zt2B1JaVJWBClHf4Uf
         Pg7MRYwm1OCEP4oU8anxdIS0tr6vCisBfGTVfE5rDw+1K1kCsf415W0tqcJcfDa/O3
         uhrcLYiC6OuMRES9u0RuI4sqQlely7ilaJfTMRr8=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org CF32C608D4
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=sboyd@codeaurora.org
Date:   Fri, 2 Jun 2017 10:49:11 -0700
From:   Stephen Boyd <sboyd@codeaurora.org>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Russell King <linux@armlinux.org.uk>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        John Crispin <john@phrozen.org>,
        Ralf Baechle <ralf@linux-mips.org>, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] clk: Provide dummy of_clk_get_from_provider() for
 compile-testing
Message-ID: <20170602174911.GK20170@codeaurora.org>
References: <1493384933-31297-1-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1493384933-31297-1-git-send-email-geert+renesas@glider.be>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <sboyd@codeaurora.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58135
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

On 04/28, Geert Uytterhoeven wrote:
> When CONFIG_ON=n, dummies are provided for of_clk_get() and
> of_clk_get_by_name(), but not for of_clk_get_from_provider().
> 
> Provide a dummy for the latter, to improve the ability to do
> compile-testing.  This requires removing the existing dummy in the
> Lantiq clock code.
> 
> Fixes: 766e6a4ec602d0c1 ("clk: add DT clock binding support")
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---

Applied to clk-next

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
