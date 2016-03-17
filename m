Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 17 Mar 2016 13:21:05 +0100 (CET)
Received: from down.free-electrons.com ([37.187.137.238]:53441 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S27007077AbcCQMVEao80r (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 17 Mar 2016 13:21:04 +0100
Received: by mail.free-electrons.com (Postfix, from userid 110)
        id A885E17D7; Thu, 17 Mar 2016 13:20:58 +0100 (CET)
Received: from localhost (unknown [88.191.26.124])
        by mail.free-electrons.com (Postfix) with ESMTPSA id 78E3C468;
        Thu, 17 Mar 2016 13:20:58 +0100 (CET)
Date:   Thu, 17 Mar 2016 13:20:58 +0100
From:   Alexandre Belloni <alexandre.belloni@free-electrons.com>
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        Kumar Gala <galak@codeaurora.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Paul Burton <paul.burton@imgtec.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mips@linux-mips.org, rtc-linux@googlegroups.com
Subject: Re: [PATCH 4/5] rtc: jz4740_rtc: Add support for acting as the
 system power controller
Message-ID: <20160317122058.GE3362@piout.net>
References: <1457217531-26064-1-git-send-email-paul@crapouillou.net>
 <1457217531-26064-4-git-send-email-paul@crapouillou.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1457217531-26064-4-git-send-email-paul@crapouillou.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
Return-Path: <alexandre.belloni@free-electrons.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52639
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: alexandre.belloni@free-electrons.com
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

On 05/03/2016 at 23:38:50 +0100, Paul Cercueil wrote :
> +	if (of_device_is_system_power_controller(pdev->dev.of_node)) {
> +		if (!pm_power_off) {
> +			/* Default: 60ms */
> +			rtc->reset_pin_assert_time = 60;
> +			device_property_read_u32(&pdev->dev,

It is probably more efficient to use of_property_read_u32 directly. Any
particular reason to use device_property_read_u32?

> +		} else {
> +			dev_err(&pdev->dev,
> +					"Poweroff handler already present!\n");

I'm not found of that alignement, it is probably better to let the
string go over 80 chars. checkpatch will not complain.

-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
