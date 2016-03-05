Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 05 Mar 2016 05:32:02 +0100 (CET)
Received: from mail.kernel.org ([198.145.29.136]:45486 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27006663AbcCEEbnut9Z- (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sat, 5 Mar 2016 05:31:43 +0100
Received: from mail.kernel.org (localhost [127.0.0.1])
        by mail.kernel.org (Postfix) with ESMTP id 5B08120254;
        Sat,  5 Mar 2016 04:31:42 +0000 (UTC)
Received: from rob-hp-laptop (unknown [216.9.110.15])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7546420125;
        Sat,  5 Mar 2016 04:31:40 +0000 (UTC)
Date:   Fri, 4 Mar 2016 22:31:37 -0600
From:   Rob Herring <robh@kernel.org>
To:     Govindraj Raja <Govindraj.Raja@imgtec.com>
Cc:     linux-gpio@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        devicetree@vger.kernel.org,
        Andrew Bresticker <abrestic@chromium.org>,
        linux-mips@linux-mips.org,
        James Hartley <James.Hartley@imgtec.com>,
        stable@vger.kernel.org
Subject: Re: [PATCH] pinctrl: pistachio: fix mfio84-89 function description
 and pinmux.
Message-ID: <20160305043137.GJ13525@rob-hp-laptop>
References: <1457105302-15070-1-git-send-email-Govindraj.Raja@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1457105302-15070-1-git-send-email-Govindraj.Raja@imgtec.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Virus-Scanned: ClamAV using ClamSMTP
Return-Path: <robh@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52462
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: robh@kernel.org
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

On Fri, Mar 04, 2016 at 03:28:22PM +0000, Govindraj Raja wrote:
> mfio 84 to 89 are described wrongly, fix it to describe
> the right pin and add them to right pin-mux group.
> 
> The correct order is:
> 	pll1_lock => mips_pll	-- MFIO_83
> 	pll2_lock => audio_pll	-- MFIO_84
> 	pll3_lock => rpu_v_pll	-- MFIO_85
> 	pll4_lock => rpu_l_pll	-- MFIO_86
> 	pll5_lock => sys_pll	-- MFIO_87
> 	pll6_lock => wifi_pll	-- MFIO_88
> 	pll7_lock => bt_pll	-- MFIO_89
> 
> Fixes: cefc03e5995e("pinctrl: Add Pistachio SoC pin control driver")
> Signed-off-by: Govindraj Raja <Govindraj.Raja@imgtec.com>
> Cc: linux-gpio@vger.kernel.org
> Cc: devicetree@vger.kernel.org
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Andrew Bresticker <abrestic@chromium.org>
> Cc: linux-mips@linux-mips.org
> Cc: James Hartley <James.Hartley@imgtec.com>
> Cc: <stable@vger.kernel.org> # v4.2+
> ---
> Do I need to split this patch into dt & pinctrl?
> Or can it be picked up through pinctrl subsystem with dt maintainers Ack?

Yes.

Acked-by: Rob Herring <robh@kernel.org>
