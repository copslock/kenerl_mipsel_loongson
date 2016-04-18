Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 18 Apr 2016 14:30:51 +0200 (CEST)
Received: from devils.ext.ti.com ([198.47.26.153]:53156 "EHLO
        devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27026276AbcDRMatYTXBF (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 18 Apr 2016 14:30:49 +0200
Received: from dlelxv90.itg.ti.com ([172.17.2.17])
        by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id u3ICUOuV021609;
        Mon, 18 Apr 2016 07:30:24 -0500
Received: from DFLE73.ent.ti.com (dfle73.ent.ti.com [128.247.5.110])
        by dlelxv90.itg.ti.com (8.14.3/8.13.8) with ESMTP id u3ICUNY9007679;
        Mon, 18 Apr 2016 07:30:24 -0500
Received: from dlep32.itg.ti.com (157.170.170.100) by DFLE73.ent.ti.com
 (128.247.5.110) with Microsoft SMTP Server id 14.3.224.2; Mon, 18 Apr 2016
 07:30:23 -0500
Received: from [172.24.190.114] (ileax41-snat.itg.ti.com [10.172.224.153])      by
 dlep32.itg.ti.com (8.14.3/8.13.8) with ESMTP id u3ICUJdE003122;        Mon, 18 Apr
 2016 07:30:20 -0500
Subject: Re: [PATCH v2 1/5] phy: Add a driver for simple phy
To:     Arnd Bergmann <arnd@arndb.de>
References: <1447708924-15076-1-git-send-email-albeu@free.fr>
 <1447708924-15076-2-git-send-email-albeu@free.fr> <570F303A.6030605@ti.com>
 <4848615.OezLJod6Cv@wuerfel>
CC:     Alban Bedel <albeu@free.fr>, <linux-mips@linux-mips.org>,
        Rob Herring <robh+dt@kernel.org>,
        Pawel Moll <pawel.moll@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        Kumar Gala <galak@codeaurora.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <5714D35B.8000208@ti.com>
Date:   Mon, 18 Apr 2016 18:00:19 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.3.0
MIME-Version: 1.0
In-Reply-To: <4848615.OezLJod6Cv@wuerfel>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-Path: <kishon@ti.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53059
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kishon@ti.com
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

Hi Arnd,

On Sunday 17 April 2016 01:20 AM, Arnd Bergmann wrote:
> On Thursday 14 April 2016 11:22:58 Kishon Vijay Abraham I wrote:
>>
>> IMO simple-phy driver should be an independent driver and shouldn't export
>> symbols. The dt binding for the simple phy device should be something like
>> below where all the properties of the simple phy device should be in the
>> binding documentation.
>> usbphy {
>>         compatible = "simple-phy";
>>         phy-supply = <&supply>;
>>         clocks = <&clock>;
>>         reset = <&reset>;
>> };
>>
>> Anything that needs more than this shouldn't be a simple phy.
> 
> I think there are two aspects here:
> 
> a) I agree that a driver that matches "simple-phy" should only call
>    the generic functions and not use any other properties.
> 
> b) Independent of that, I think that it makes a lot of sense to export
>    those functions from the generic PHY subsystems so they can be
>    called from drivers that are a little less generic, or that already
>    have an established binding but need no other code.

These export functions can be abused and called directly from the controller
driver bypassing the phy core.

Actually lot of generic PHY programming are done in the phy-core itself. (For
example, the generic PHY regulator binding "phy-supply" can be used for the phy
core to enable the regulator during power on and disable during power off, phy
core also invokes pm_runtime API's during power_on and power_off which can be
used to enable/disable clocks). So drivers which are less generic can just
populate their specific handling part in their phy ops and leave the rest to be
done in phy core.
"simple-phy" should be used to avoid adding new PHY drivers that does simple
PHY ops.

Thanks
Kishon
