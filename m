Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 17 Mar 2016 13:00:53 +0100 (CET)
Received: from mail.kernel.org ([198.145.29.136]:34657 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27013911AbcCQMAvRd5Vr (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 17 Mar 2016 13:00:51 +0100
Received: from mail.kernel.org (localhost [127.0.0.1])
        by mail.kernel.org (Postfix) with ESMTP id 427FC20279;
        Thu, 17 Mar 2016 12:00:49 +0000 (UTC)
Received: from rob-hp-laptop (72-48-98-129.dyn.grandenetworks.net [72.48.98.129])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B09732034F;
        Thu, 17 Mar 2016 12:00:44 +0000 (UTC)
Date:   Thu, 17 Mar 2016 07:00:42 -0500
From:   Rob Herring <robh@kernel.org>
To:     Purna Chandra Mandal <purna.mandal@microchip.com>
Cc:     linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        Mark Brown <broonie@kernel.org>,
        Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
        Joshua Henderson <digitalpeer@digitalpeer.com>,
        devicetree@vger.kernel.org, linux-mips@linux-mips.org,
        Kumar Gala <galak@codeaurora.org>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        Pawel Moll <pawel.moll@arm.com>,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [RESEND PATCH v2 1/2] dt/bindings: Add bindings for PIC32 SPI
 peripheral
Message-ID: <20160317120042.GA4744@rob-hp-laptop>
References: <1457238927-16120-1-git-send-email-purna.mandal@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1457238927-16120-1-git-send-email-purna.mandal@microchip.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Virus-Scanned: ClamAV using ClamSMTP
Return-Path: <robh@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52635
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

On Sun, Mar 06, 2016 at 10:05:26AM +0530, Purna Chandra Mandal wrote:
> Signed-off-by: Purna Chandra Mandal <purna.mandal@microchip.com>
> 
> ---
> 
> Changes in v2:
>  - fix indentation
>  - add space after comma
>  - moved 'cs-gpios' section under 'required' properties.
> 
>  .../bindings/spi/microchip,spi-pic32.txt           | 34 ++++++++++++++++++++++
>  1 file changed, 34 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/spi/microchip,spi-pic32.txt

Acked-by: Rob Herring <robh@kernel.org>
