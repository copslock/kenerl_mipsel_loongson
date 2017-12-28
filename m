Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 28 Dec 2017 19:37:07 +0100 (CET)
Received: from smtp.codeaurora.org ([198.145.29.96]:34204 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23990506AbdL1SgtufmtO (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 28 Dec 2017 19:36:49 +0100
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 6961060B17; Thu, 28 Dec 2017 18:36:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1514486206;
        bh=CFv0yChGwm9n8eYgfLiPpnTmltRhwrvTcpJ4U8XnkVc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=P1sE05NeicfKjGubNRNiBer1V35FT4ZJdjN2ISrjS2lTPirFbDVHMXyjrIJMl7nyQ
         sfUqLLyJS3p7zs1u1kUhU9pDOIoDjt5rSMRac5BfzmIDgSsm/kquVeqG8vFyO2746c
         qEtVNBWM5V6/HosKdnOJPCPgXrsqQlRr1r3/M+P8=
Received: from localhost (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: sboyd@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id B5AFB6079C;
        Thu, 28 Dec 2017 18:36:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1514486205;
        bh=CFv0yChGwm9n8eYgfLiPpnTmltRhwrvTcpJ4U8XnkVc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=D9mkpJGYSs2WvAiLQqe3SYmIIsavOURVBuZKlyJFx3/jyFZqb77IYm38l7MtUBOIt
         vF7i+DuguXx+g+rU0+fDkoffK5v7FNVkwVgrCxVHBosUD1oKfM92UeEMagY9ypH0Lk
         v/x2kN1v+Tt3rqEKogBOdlnc9GgrY8suVirolbcE=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org B5AFB6079C
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=sboyd@codeaurora.org
Date:   Thu, 28 Dec 2017 10:36:45 -0800
From:   Stephen Boyd <sboyd@codeaurora.org>
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Rob Herring <robh+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Maarten ter Huurne <maarten@treewalker.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mips@linux-mips.org, linux-clk@vger.kernel.org
Subject: Re: [PATCH v4 05/15] dt-bindings: clock: Add jz4770-cgu.h header
Message-ID: <20171228183645.GK7997@codeaurora.org>
References: <20170702163016.6714-2-paul@crapouillou.net>
 <20171228135634.30000-1-paul@crapouillou.net>
 <20171228135634.30000-6-paul@crapouillou.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171228135634.30000-6-paul@crapouillou.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <sboyd@codeaurora.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61682
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
> This will be used from the devicetree bindings to specify the clocks
> that should be obtained from the jz4770-cgu driver.
> 
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> ---

Acked-by: Stephen Boyd <sboyd@codeaurora.org>

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
