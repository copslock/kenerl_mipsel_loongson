Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 30 Nov 2015 22:43:53 +0100 (CET)
Received: from mail.kernel.org ([198.145.29.136]:49309 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27007995AbbK3Vnut0KIY (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 30 Nov 2015 22:43:50 +0100
Received: from mail.kernel.org (localhost [127.0.0.1])
        by mail.kernel.org (Postfix) with ESMTP id 5DDDE20592;
        Mon, 30 Nov 2015 21:43:48 +0000 (UTC)
Received: from rob-hp-laptop (72-48-98-129.dyn.grandenetworks.net [72.48.98.129])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B963E20591;
        Mon, 30 Nov 2015 21:43:46 +0000 (UTC)
Date:   Mon, 30 Nov 2015 15:43:44 -0600
From:   Rob Herring <robh@kernel.org>
To:     Joshua Henderson <joshua.henderson@microchip.com>
Cc:     linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
        Purna Chandra Mandal <purna.mandal@microchip.com>,
        Pawel Moll <pawel.moll@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        Kumar Gala <galak@codeaurora.org>, devicetree@vger.kernel.org
Subject: Re: [PATCH 03/14] DEVICETREE: Add PIC32 clock binding documentation
Message-ID: <20151130214344.GA13253@rob-hp-laptop>
References: <1448065205-15762-1-git-send-email-joshua.henderson@microchip.com>
 <1448065205-15762-4-git-send-email-joshua.henderson@microchip.com>
 <20151122213110.GA16187@rob-hp-laptop>
 <56569A77.8010800@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <56569A77.8010800@microchip.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Virus-Scanned: ClamAV using ClamSMTP
Return-Path: <robh@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50220
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

On Wed, Nov 25, 2015 at 10:36:55PM -0700, Joshua Henderson wrote:
> Hi Rob,
> 
> On 11/22/2015 2:31 PM, Rob Herring wrote:
> > On Fri, Nov 20, 2015 at 05:17:15PM -0700, Joshua Henderson wrote:
> >> From: Purna Chandra Mandal <purna.mandal@microchip.com>
> >>
> >> Document the devicetree bindings for the clock driver found on Microchip
> >> PIC32 class devices.
> >>
> >> Signed-off-by: Purna Chandra Mandal <purna.mandal@microchip.com>
> >> Signed-off-by: Joshua Henderson <joshua.henderson@microchip.com>
> >> ---
> >>  .../devicetree/bindings/clock/microchip,pic32.txt  |  263 ++++++++++++++++++++
> >>  1 file changed, 263 insertions(+)
> >>  create mode 100644 Documentation/devicetree/bindings/clock/microchip,pic32.txt
> >>
> >> diff --git a/Documentation/devicetree/bindings/clock/microchip,pic32.txt b/Documentation/devicetree/bindings/clock/microchip,pic32.txt
> >> new file mode 100644
> >> index 0000000..4cef72d
> >> --- /dev/null
> >> +++ b/Documentation/devicetree/bindings/clock/microchip,pic32.txt
> >> @@ -0,0 +1,263 @@
> >> +Binding for a Clock hardware block found on
> >> +certain Microchip PIC32 MCU devices.
> >> +
> >> +Microchip SoC clocks-node consists of few oscillators, PLL, multiplexer
> >> +and few divider nodes.
> > 
> > [...]
> > 
> >> +Required properties:
> >> +- compatible : should have "microchip,pic32-clk".

BTW, this should list out the actual compatible strings.

> > There is some discussion about this upstream with "critical-clocks" 
> > binding. Can you use and wait for that?
> > 
> 
> The way this is going, we might not have to wait. :)  Is there a patch available yet to try it out?  

Yes, googling "Lee Jones critical-clocks" should find it.

> >> +- microchip,status-bit-mask: bitmask for status check. This will be used to confirm
> >> +    particular operation by clock sub-node is completed. It is dependent sub-node.
> >> +- microchip,bit-mask: enable mask, similar to microchip,status-bit-mask.
> > 
> > We've generally decided not to describe clocks at this level of detail 
> > in DT. It's fine though for simple clock trees. This one seems to be 
> > borderline IMO.
> > 
> 
> The binding example is the entire clock tree.  These masks are right from the datasheet.  For reference, do you have an example of a better alternative?

Okay, like I said, borderline. If this is complete, then it is fine. 
Adding more clocks or a newer version of the SoC with more clocks would 
change that opinion.

Rob
