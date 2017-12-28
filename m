Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 28 Dec 2017 19:39:54 +0100 (CET)
Received: from smtp.codeaurora.org ([198.145.29.96]:35240 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23990633AbdL1Sjpo9FfO (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 28 Dec 2017 19:39:45 +0100
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 4853F60858; Thu, 28 Dec 2017 18:39:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1514486381;
        bh=8rxL9hDPsAm4uGaEJQZsNcpJbGX7JVbRfGH8v04XyBI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nhQuzSDw3+lQ7Q3VwA9QDPKOksKbLi/byY69uZ85DI8uFCMUlZOefx/1qh7u1mRI9
         GrNoEnYTJZ40KcavDVazpjtbNhPS59l+DkNASB1GArwaRFiA7k6ZPOcfd/UI7Y1l65
         ge6VnBtqBTLl8mrf7BdbXXwbtGTwPWTqJFDVSdJ0=
Received: from localhost (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: sboyd@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id C40F56071B;
        Thu, 28 Dec 2017 18:39:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1514486380;
        bh=8rxL9hDPsAm4uGaEJQZsNcpJbGX7JVbRfGH8v04XyBI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=khHT+UZ0ClgFZzVnqt9RWjKgi4LucQGzeibf888k2db5zle5R/1Fnl9FSsSNLKhWz
         71MWsZVdWlncLGpvGjflHnESP3CXFbGITS6O7dmojuYIxbsJqeq+eEo3Wf+4/FHFNM
         WjdX2sUhOa3I6BoGDMTFDsgLYWRNnfJEm3iOE4rk=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org C40F56071B
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=sboyd@codeaurora.org
Date:   Thu, 28 Dec 2017 10:39:40 -0800
From:   Stephen Boyd <sboyd@codeaurora.org>
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Rob Herring <robh+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Maarten ter Huurne <maarten@treewalker.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mips@linux-mips.org, linux-clk@vger.kernel.org
Subject: Re: [PATCH v4 04/15] clk: ingenic: Add code to enable/disable PLLs
Message-ID: <20171228183940.GM7997@codeaurora.org>
References: <20170702163016.6714-2-paul@crapouillou.net>
 <20171228135634.30000-1-paul@crapouillou.net>
 <20171228135634.30000-5-paul@crapouillou.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171228135634.30000-5-paul@crapouillou.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <sboyd@codeaurora.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61685
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
> This commit permits the PLLs to be dynamically enabled and disabled when
> their children clocks are enabled and disabled.
> 
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> ---

Acked-by: Stephen Boyd <sboyd@codeaurora.org>

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
