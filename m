Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 01 Apr 2015 22:38:55 +0200 (CEST)
Received: from smtprelay0111.hostedemail.com ([216.40.44.111]:49317 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S27009593AbbDAUix0zIKG (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 1 Apr 2015 22:38:53 +0200
Received: from filter.hostedemail.com (unknown [216.40.38.60])
        by smtprelay08.hostedemail.com (Postfix) with ESMTP id B3E7629DD79;
        Wed,  1 Apr 2015 20:38:52 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: steam65_6a501fba9c153
X-Filterd-Recvd-Size: 1655
Received: from joe-X200MA.home (pool-71-119-66-80.lsanca.fios.verizon.net [71.119.66.80])
        (Authenticated sender: joe@perches.com)
        by omf03.hostedemail.com (Postfix) with ESMTPA;
        Wed,  1 Apr 2015 20:38:50 +0000 (UTC)
Message-ID: <1427920728.31790.94.camel@perches.com>
Subject: Re: [PATCH 2/2] phy: Add driver for Pistachio USB2.0 PHY
From:   Joe Perches <joe@perches.com>
To:     Andrew Bresticker <abrestic@chromium.org>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        Ralf Baechle <ralf@linux-mips.org>, devicetree@vger.kernel.org,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        James Hartley <james.hartley@imgtec.com>,
        Damien Horsley <Damien.Horsley@imgtec.com>
Date:   Wed, 01 Apr 2015 13:38:48 -0700
In-Reply-To: <1427919394-3580-3-git-send-email-abrestic@chromium.org>
References: <1427919394-3580-1-git-send-email-abrestic@chromium.org>
         <1427919394-3580-3-git-send-email-abrestic@chromium.org>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.12.10-0ubuntu1~14.10.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-Path: <joe@perches.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46697
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: joe@perches.com
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

On Wed, 2015-04-01 at 13:16 -0700, Andrew Bresticker wrote:
> Add a driver for the USB2.0 PHY found on the IMG Pistachio SoC.

Spelling trivia:

> diff --git a/drivers/phy/phy-pistachio-usb.c b/drivers/phy/phy-pistachio-usb.c
[]
> +static int pistachio_usb_phy_power_on(struct phy *phy)
> +{
[]
> +	if (p_phy->refclk == REFCLK_XO_CRYSTAL && rate != 12000000) {
> +		dev_err(p_phy->dev, "Unspported rate for XO crystal: %ld\n",

typo

[]

> +	if (i == ARRAY_SIZE(fsel_rate_map)) {
> +		dev_err(p_phy->dev, "Unspported clock rate: %lu\n", rate);

here too
