Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 05 Mar 2016 05:31:45 +0100 (CET)
Received: from mail.kernel.org ([198.145.29.136]:45448 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27006520AbcCEEbkRw1k- (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sat, 5 Mar 2016 05:31:40 +0100
Received: from mail.kernel.org (localhost [127.0.0.1])
        by mail.kernel.org (Postfix) with ESMTP id F191B200E8;
        Sat,  5 Mar 2016 04:31:37 +0000 (UTC)
Received: from rob-hp-laptop (unknown [216.9.110.15])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 092D220254;
        Sat,  5 Mar 2016 04:31:35 +0000 (UTC)
Date:   Fri, 4 Mar 2016 22:31:33 -0600
From:   Rob Herring <robh@kernel.org>
To:     Purna Chandra Mandal <purna.mandal@microchip.com>
Cc:     linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-mips@linux-mips.org,
        Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
        Kumar Gala <galak@codeaurora.org>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        Pawel Moll <pawel.moll@arm.com>,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH v2 1/2] dt/bindings: Add bindings for PIC32 SPI peripheral
Message-ID: <20160305043133.GI13525@rob-hp-laptop>
References: <1457099082-12587-1-git-send-email-purna.mandal@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1457099082-12587-1-git-send-email-purna.mandal@microchip.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Virus-Scanned: ClamAV using ClamSMTP
Return-Path: <robh@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52461
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

On Fri, Mar 04, 2016 at 07:14:41PM +0530, Purna Chandra Mandal wrote:
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
