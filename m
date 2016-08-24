Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 25 Aug 2016 01:05:59 +0200 (CEST)
Received: from smtp.codeaurora.org ([198.145.29.96]:59266 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992250AbcHXXFbepc4x (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 25 Aug 2016 01:05:31 +0200
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 6FA3461B3F; Wed, 24 Aug 2016 23:05:30 +0000 (UTC)
Received: from localhost (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: sboyd@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 2C8A361B3F;
        Wed, 24 Aug 2016 23:05:29 +0000 (UTC)
Date:   Wed, 24 Aug 2016 16:05:28 -0700
From:   Stephen Boyd <sboyd@codeaurora.org>
To:     Purna Chandra Mandal <purna.mandal@microchip.com>
Cc:     linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
        Ralf Baechle <ralf@linux-mips.org>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org
Subject: Re: [PATCH 02/11] clk: microchip: Initialize SOSC clock rate for
 PIC32MZDA.
Message-ID: <20160824230528.GH19826@codeaurora.org>
References: <1463461560-9629-1-git-send-email-purna.mandal@microchip.com>
 <1463461560-9629-2-git-send-email-purna.mandal@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1463461560-9629-2-git-send-email-purna.mandal@microchip.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <sboyd@codeaurora.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54746
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

On 05/17, Purna Chandra Mandal wrote:
> Optional SOSC is an external fixed clock running at 32768HZ.
> So Initialize SOSC rate as per PIC32MZDA datasheet.
> 
> Signed-off-by: Purna Chandra Mandal <purna.mandal@microchip.com>
> 
> ---

Applied to clk-next

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
