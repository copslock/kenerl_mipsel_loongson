Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 14 Mar 2016 02:54:04 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:41850 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27008450AbcCNByCz5rsk (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 14 Mar 2016 02:54:02 +0100
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.15.2/8.14.8) with ESMTP id u2E1ruJA030191;
        Mon, 14 Mar 2016 02:53:56 +0100
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.15.2/8.15.2/Submit) id u2E1rrCb030190;
        Mon, 14 Mar 2016 02:53:53 +0100
Date:   Mon, 14 Mar 2016 02:53:53 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Alexandre Belloni <alexandre.belloni@free-electrons.com>,
        Rob Herring <robh+dt@kernel.org>,
        Pawel Moll <pawel.moll@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        Kumar Gala <galak@codeaurora.org>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Paul Burton <paul.burton@imgtec.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mips@linux-mips.org, rtc-linux@googlegroups.com
Subject: Re: [PATCH 5/5] MIPS: jz4740: Use the jz4740-rtc driver as the power
 controller
Message-ID: <20160314015353.GB29020@linux-mips.org>
References: <1457217531-26064-1-git-send-email-paul@crapouillou.net>
 <1457217531-26064-5-git-send-email-paul@crapouillou.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1457217531-26064-5-git-send-email-paul@crapouillou.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52576
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
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

On Sat, Mar 05, 2016 at 11:38:51PM +0100, Paul Cercueil wrote:

> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> ---
>  arch/mips/boot/dts/ingenic/jz4740.dtsi |  2 ++
>  arch/mips/jz4740/reset.c               | 64 ----------------------------------

Acked-by: Ralf Baechle <ralf@linux-mips.org>

Feel free to funnel this patch upstream through the RTC tree.  Or I can
carry the whole series, just lemme know.

  Ralf
