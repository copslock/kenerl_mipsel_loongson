Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 08 Jun 2017 10:40:22 +0200 (CEST)
Received: from relay3-d.mail.gandi.net ([IPv6:2001:4b98:c:538::195]:36391 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990509AbdFHIkMa2NQV (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 8 Jun 2017 10:40:12 +0200
Received: from mfilter29-d.gandi.net (mfilter29-d.gandi.net [217.70.178.160])
        by relay3-d.mail.gandi.net (Postfix) with ESMTP id 19439A8119;
        Thu,  8 Jun 2017 10:40:12 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at mfilter29-d.gandi.net
Received: from relay3-d.mail.gandi.net ([IPv6:::ffff:217.70.183.195])
        by mfilter29-d.gandi.net (mfilter29-d.gandi.net [::ffff:10.0.15.180]) (amavisd-new, port 10024)
        with ESMTP id ILJEwHfOI5MV; Thu,  8 Jun 2017 10:40:10 +0200 (CEST)
X-Originating-IP: 82.168.42.142
Received: from starbug-2.treewalker.org (82-168-42-142.ip.open.net [82.168.42.142])
        (Authenticated sender: relay@treewalker.org)
        by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id 75473A813B;
        Thu,  8 Jun 2017 10:40:05 +0200 (CEST)
Received: from hyperion.localnet (hyperion.local.treewalker.org [192.168.0.43])
        by starbug-2.treewalker.org (Postfix) with ESMTP id 927EC274CB9;
        Thu,  8 Jun 2017 10:40:05 +0200 (CEST)
From:   Maarten ter Huurne <maarten@treewalker.org>
To:     Stephen Boyd <sboyd@codeaurora.org>
Cc:     Paul Cercueil <paul@crapouillou.net>,
        Ralf Baechle <ralf@linux-mips.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Paul Burton <paul.burton@imgtec.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mips@linux-mips.org, linux-clk@vger.kernel.org
Subject: Re: [PATCH 04/15] clk: Add Ingenic jz4770 CGU driver
Date:   Thu, 08 Jun 2017 10:40:05 +0200
Message-ID: <1614689.ggC5Fptfnb@hyperion>
User-Agent: KMail/4.14.10 (Linux/4.4.62-18.6-default; KDE/4.14.25; x86_64; ; )
In-Reply-To: <20170607205943.GO20170@codeaurora.org>
References: <20170607200439.24450-1-paul@crapouillou.net> <20170607200439.24450-5-paul@crapouillou.net> <20170607205943.GO20170@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Return-Path: <maarten@treewalker.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58304
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: maarten@treewalker.org
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

On Wednesday 07 June 2017 13:59:43 Stephen Boyd wrote:
> On 06/07, Paul Cercueil wrote:
> > Add support for the clocks provided by the CGU in the Ingenic JZ4770
> > SoC.
> > 
> > Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> > Signed-off-by: Maarten ter Huurne <maarten@treewalker.org>
> 
> Signed-off chain looks odd. Sender should be last in the chain
> and first is typically author.

Paul is the main author, but one or more commits I made were squashed 
into the patch during its development.

Bye,
		Maarten
