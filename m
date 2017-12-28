Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 28 Dec 2017 19:38:55 +0100 (CET)
Received: from smtp.codeaurora.org ([198.145.29.96]:34930 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23990633AbdL1SihXbu7O (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 28 Dec 2017 19:38:37 +0100
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id F2FD56079C; Thu, 28 Dec 2017 18:38:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1514486316;
        bh=pCek1Z9atUFj0HH5XFTyLvrYS03hjjiXowjgDXXThbE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jEn40lzJdHXk6wBk5rdJ1U3GYT3LV14LF0LIvCF5GZNYK7Vml5Ps1sFc5AXvc9IZn
         QUIHDDGoRXRExf65zgdenEvrJF59/OqogM4b0yDkxlHW7dZ067kKHvLfbI9Zh1rUMh
         j5OWaM2vlDGpbOtf3+5i2fh2IdM0sZBVjGzhiSJM=
Received: from localhost (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: sboyd@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 5693D6071B;
        Thu, 28 Dec 2017 18:38:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1514486315;
        bh=pCek1Z9atUFj0HH5XFTyLvrYS03hjjiXowjgDXXThbE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=otpz8j+PLMXxDqMA83H9SQe+tSvfyWamZ3UZdB2unCkTpMYa4lWkd3vj3nnArT1lO
         AnzWsuxmwveaUMqZI7YDbTfM2UP7oGHWub/IhGSQbwx+v9QCNntqxFAM6neqJyCNzV
         6+KDRVtOZHQbIBR1PDf6IJZx8qGad50dh9Vgf9/I=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 5693D6071B
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=sboyd@codeaurora.org
Date:   Thu, 28 Dec 2017 10:38:34 -0800
From:   Stephen Boyd <sboyd@codeaurora.org>
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Rob Herring <robh+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Maarten ter Huurne <maarten@treewalker.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mips@linux-mips.org, linux-clk@vger.kernel.org
Subject: Re: [PATCH v4 06/15] clk: Add Ingenic jz4770 CGU driver
Message-ID: <20171228183834.GL7997@codeaurora.org>
References: <20170702163016.6714-2-paul@crapouillou.net>
 <20171228135634.30000-1-paul@crapouillou.net>
 <20171228135634.30000-7-paul@crapouillou.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171228135634.30000-7-paul@crapouillou.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <sboyd@codeaurora.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61684
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

On 12/28, Paul Cercueil wrote:
> Add support for the clocks provided by the CGU in the Ingenic JZ4770
> SoC.
> 
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> Signed-off-by: Maarten ter Huurne <maarten@treewalker.org>
> ---

Acked-by: Stephen Boyd <sboyd@codeaurora.org>

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
