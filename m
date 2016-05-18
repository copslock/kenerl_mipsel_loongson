Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 18 May 2016 18:50:50 +0200 (CEST)
Received: from mail.kernel.org ([198.145.29.136]:51257 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27030128AbcERQumzKXhC (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 18 May 2016 18:50:42 +0200
Received: from mail.kernel.org (localhost [127.0.0.1])
        by mail.kernel.org (Postfix) with ESMTP id 6A18C20351;
        Wed, 18 May 2016 16:50:41 +0000 (UTC)
Received: from rob-hp-laptop (72-48-98-129.dyn.grandenetworks.net [72.48.98.129])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D27122034B;
        Wed, 18 May 2016 16:50:39 +0000 (UTC)
Date:   Wed, 18 May 2016 11:50:37 -0500
From:   Rob Herring <robh@kernel.org>
To:     Purna Chandra Mandal <purna.mandal@microchip.com>
Cc:     linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
        Ralf Baechle <ralf@linux-mips.org>, devicetree@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Kumar Gala <galak@codeaurora.org>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        Joshua Henderson <joshua.henderson@microchip.com>,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH 07/11] dt/bindings: Correct clk binding example for PIC32
 pinctrl
Message-ID: <20160518165037.GB1666@rob-hp-laptop>
References: <1463461560-9629-1-git-send-email-purna.mandal@microchip.com>
 <1463461560-9629-7-git-send-email-purna.mandal@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1463461560-9629-7-git-send-email-purna.mandal@microchip.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Virus-Scanned: ClamAV using ClamSMTP
Return-Path: <robh@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53520
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

On Tue, May 17, 2016 at 10:35:56AM +0530, Purna Chandra Mandal wrote:
> Update binding example based on new clock binding scheme.
> [1] Documentation/devicetree/bindings/clock/microchip,pic32.txt
> 
> Signed-off-by: Purna Chandra Mandal <purna.mandal@microchip.com>
> ---
> 
>  Documentation/devicetree/bindings/pinctrl/microchip,pic32-pinctrl.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Acked-by: Rob Herring <robh@kernel.org>
