Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 04 Apr 2016 12:09:49 +0200 (CEST)
Received: from exsmtp01.microchip.com ([198.175.253.37]:33488 "EHLO
        email.microchip.com" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S27007470AbcDDKJs03hHa (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 4 Apr 2016 12:09:48 +0200
Received: from [10.41.20.11] (10.10.76.4) by CHN-SV-EXCH01.mchp-main.com
 (10.10.76.37) with Microsoft SMTP Server id 14.3.181.6; Mon, 4 Apr 2016
 03:09:40 -0700
Subject: Re: [PATCH v5 1/2] dt/bindings: Add bindings for PIC32 SPI peripheral
To:     Mark Brown <broonie@kernel.org>
References: <1459509530-22716-1-git-send-email-purna.mandal@microchip.com>
 <20160402163506.GD2350@sirena.org.uk>
CC:     <linux-kernel@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
        Joshua Henderson <digitalpeer@digitalpeer.com>,
        <devicetree@vger.kernel.org>, <linux-mips@linux-mips.org>,
        Kumar Gala <galak@codeaurora.org>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        Rob Herring <robh+dt@kernel.org>,
        Pawel Moll <pawel.moll@arm.com>,
        Mark Rutland <mark.rutland@arm.com>
From:   Purna Chandra Mandal <purna.mandal@microchip.com>
Message-ID: <57023CFF.5040308@microchip.com>
Date:   Mon, 4 Apr 2016 15:37:59 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.4.0
MIME-Version: 1.0
In-Reply-To: <20160402163506.GD2350@sirena.org.uk>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-Path: <Purna.Mandal@microchip.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52870
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: purna.mandal@microchip.com
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

On 04/02/2016 10:05 PM, Mark Brown wrote:

> On Fri, Apr 01, 2016 at 04:48:49PM +0530, Purna Chandra Mandal wrote:
>> Document the devicetree bindings for the SPI peripheral found
>> on Microchip PIC32 class devices.
> Please use subject lines reflecting the style for the subsystem.

ack. Will do.
