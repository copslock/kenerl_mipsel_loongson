Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 25 Aug 2017 10:34:23 +0200 (CEST)
Received: from mail.free-electrons.com ([62.4.15.54]:52173 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993423AbdHYIeP1xKjW (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 25 Aug 2017 10:34:15 +0200
Received: by mail.free-electrons.com (Postfix, from userid 110)
        id 11038209A8; Fri, 25 Aug 2017 10:34:05 +0200 (CEST)
Received: from localhost (unknown [88.191.26.124])
        by mail.free-electrons.com (Postfix) with ESMTPSA id BCF7020977;
        Fri, 25 Aug 2017 10:34:04 +0200 (CEST)
Date:   Fri, 25 Aug 2017 10:34:05 +0200
From:   Alexandre Belloni <alexandre.belloni@free-electrons.com>
To:     Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Cc:     linux-mips@linux-mips.org,
        Miodrag Dinic <miodrag.dinic@imgtec.com>,
        Goran Ferenc <goran.ferenc@imgtec.com>,
        Aleksandar Markovic <aleksandar.markovic@imgtec.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Bo Hu <bohu@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        Douglas Leung <douglas.leung@imgtec.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        James Hogan <james.hogan@imgtec.com>,
        Jin Qian <jinqian@google.com>, linux-kernel@vger.kernel.org,
        linux-rtc@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Paul Burton <paul.burton@imgtec.com>,
        Petar Jovanovic <petar.jovanovic@imgtec.com>,
        Raghu Gandham <raghu.gandham@imgtec.com>,
        Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH v4 2/8] rtc: goldfish: Add RTC driver for Android emulator
Message-ID: <20170825083405.7gy3mllefnwinaoc@piout.net>
References: <1503061833-26563-1-git-send-email-aleksandar.markovic@rt-rk.com>
 <1503061833-26563-3-git-send-email-aleksandar.markovic@rt-rk.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1503061833-26563-3-git-send-email-aleksandar.markovic@rt-rk.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Return-Path: <alexandre.belloni@free-electrons.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59797
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

On 18/08/2017 at 15:08:54 +0200, Aleksandar Markovic wrote:
> From: Miodrag Dinic <miodrag.dinic@imgtec.com>
> 
> Add device driver for a virtual RTC device in Android emulator.
> 
> The compatible string used by OS for binding the driver is defined
> as "google,goldfish-rtc".
> 
> Signed-off-by: Miodrag Dinic <miodrag.dinic@imgtec.com>
> Signed-off-by: Goran Ferenc <goran.ferenc@imgtec.com>
> Signed-off-by: Aleksandar Markovic <aleksandar.markovic@imgtec.com>
> ---
>  MAINTAINERS                |   1 +
>  drivers/rtc/Kconfig        |   8 ++
>  drivers/rtc/Makefile       |   1 +
>  drivers/rtc/rtc-goldfish.c | 237 +++++++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 247 insertions(+)
>  create mode 100644 drivers/rtc/rtc-goldfish.c
> 
Applied, thanks.

-- 
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
