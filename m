Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 17 Mar 2016 13:22:34 +0100 (CET)
Received: from down.free-electrons.com ([37.187.137.238]:53496 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S27014217AbcCQMWc60tvr (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 17 Mar 2016 13:22:32 +0100
Received: by mail.free-electrons.com (Postfix, from userid 110)
        id 7924F17D8; Thu, 17 Mar 2016 13:22:25 +0100 (CET)
Received: from localhost (unknown [88.191.26.124])
        by mail.free-electrons.com (Postfix) with ESMTPSA id 45829AA9;
        Thu, 17 Mar 2016 13:22:25 +0100 (CET)
Date:   Thu, 17 Mar 2016 13:22:25 +0100
From:   Alexandre Belloni <alexandre.belloni@free-electrons.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Paul Cercueil <paul@crapouillou.net>,
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
Message-ID: <20160317122225.GF3362@piout.net>
References: <1457217531-26064-1-git-send-email-paul@crapouillou.net>
 <1457217531-26064-5-git-send-email-paul@crapouillou.net>
 <20160314015353.GB29020@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20160314015353.GB29020@linux-mips.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Return-Path: <alexandre.belloni@free-electrons.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52640
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

Hi,

On 14/03/2016 at 02:53:53 +0100, Ralf Baechle wrote :
> On Sat, Mar 05, 2016 at 11:38:51PM +0100, Paul Cercueil wrote:
> 
> > Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> > ---
> >  arch/mips/boot/dts/ingenic/jz4740.dtsi |  2 ++
> >  arch/mips/jz4740/reset.c               | 64 ----------------------------------
> 
> Acked-by: Ralf Baechle <ralf@linux-mips.org>
> 
> Feel free to funnel this patch upstream through the RTC tree.  Or I can
> carry the whole series, just lemme know.
> 

I made a few minor comments. I'll take the series once it has been
resent.

-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
