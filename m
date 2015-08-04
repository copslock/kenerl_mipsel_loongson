Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 04 Aug 2015 10:48:07 +0200 (CEST)
Received: from metis.ext.pengutronix.de ([92.198.50.35]:51898 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011733AbbHDIsFa5j0R (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 4 Aug 2015 10:48:05 +0200
Received: from paszta.hi.pengutronix.de ([2001:67c:670:100:96de:80ff:fec2:9969] helo=paszta)
        by metis.ext.pengutronix.de with esmtp (Exim 4.80)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1ZMW20-0004rQ-E1; Tue, 04 Aug 2015 08:49:00 +0200
Message-ID: <1438678077.3793.25.camel@pengutronix.de>
Subject: Re: [PATCH 3/3] MIPS: ath79: Add the reset controller to the AR9132
 dtsi
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Alban Bedel <albeu@free.fr>, Rob Herring <robh+dt@kernel.org>,
        Pawel Moll <pawel.moll@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        Kumar Gala <galak@codeaurora.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mips@linux-mips.org
Date:   Tue, 04 Aug 2015 10:47:57 +0200
In-Reply-To: <20150803182336.GH2843@linux-mips.org>
References: <1438622633-9407-1-git-send-email-albeu@free.fr>
         <1438622633-9407-4-git-send-email-albeu@free.fr>
         <20150803182336.GH2843@linux-mips.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.12.9-1+b1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:96de:80ff:fec2:9969
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-mips@linux-mips.org
Return-Path: <p.zabel@pengutronix.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48560
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: p.zabel@pengutronix.de
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

Am Montag, den 03.08.2015, 20:23 +0200 schrieb Ralf Baechle:
> On Mon, Aug 03, 2015 at 07:23:53PM +0200, Alban Bedel wrote:
> 
> Acked-by: Ralf Baechle <ralf@linux-mips.org>t
> 
> Philipp,
> 
> Feel free to take this through the reset tree.  Or I can carry this in
> the MIPS tree which is probably better for testing.  Just lemme know.
> 
>   Ralf

How about I put this on a branch for you to pull? That way I can already
resolve the (trivial) merge conflict in drivers/reset/Makefile

    git://git.pengutronix.de/git/pza/linux.git reset/ath79

regards
Philipp
