Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 05 Nov 2016 00:08:21 +0100 (CET)
Received: from up.free-electrons.com ([163.172.77.33]:33236 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S23993107AbcKDXIOIVPvz (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 5 Nov 2016 00:08:14 +0100
Received: by mail.free-electrons.com (Postfix, from userid 110)
        id 9B98B20C75; Sat,  5 Nov 2016 00:08:08 +0100 (CET)
Received: from localhost (unknown [88.191.26.124])
        by mail.free-electrons.com (Postfix) with ESMTPSA id 7423820C30;
        Sat,  5 Nov 2016 00:08:08 +0100 (CET)
Date:   Sat, 5 Nov 2016 00:08:08 +0100
From:   Alexandre Belloni <alexandre.belloni@free-electrons.com>
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     rtc-linux@googlegroups.com,
        Alessandro Zummo <a.zummo@towertech.it>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Maarten ter Huurne <maarten@treewalker.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mips@linux-mips.org
Subject: Re: [PATCH v3 1/7] rtc: rtc-jz4740: Add support for the RTC in the
 jz4780 SoC
Message-ID: <20161104230808.gulyxjzezczx44jh@piout.net>
References: <20161030230247.20538-1-paul@crapouillou.net>
 <20161031203951.5444-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20161031203951.5444-1-paul@crapouillou.net>
User-Agent: NeoMutt/20161014 (1.7.1)
Return-Path: <alexandre.belloni@free-electrons.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55678
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

On 31/10/2016 at 21:39:45 +0100, Paul Cercueil wrote :
> The RTC unit present in the JZ4780 works mostly the same as the one in
> the JZ4740. The major difference is that register writes need to be
> explicitly enabled, by writing a magic code (0xA55A) to a "write
> enable" register before each access.
> 
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> Acked-by: Maarten ter Huurne <maarten@treewalker.org>
> ---
>  drivers/rtc/Kconfig      |  6 +++---
>  drivers/rtc/rtc-jz4740.c | 50 ++++++++++++++++++++++++++++++++++++++++++++++--
>  2 files changed, 51 insertions(+), 5 deletions(-)
> 
> v2: No change
> v3: No change
> 

All applied, thanks


-- 
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
