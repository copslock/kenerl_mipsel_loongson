Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 19 Aug 2013 21:20:18 +0200 (CEST)
Received: from avon.wwwdotorg.org ([70.85.31.133]:40186 "EHLO
        avon.wwwdotorg.org" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6833319Ab3HSTUQHUPYB (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 19 Aug 2013 21:20:16 +0200
Received: from severn.wwwdotorg.org (unknown [192.168.65.5])
        (using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by avon.wwwdotorg.org (Postfix) with ESMTPS id 4C1DF63F7;
        Mon, 19 Aug 2013 13:20:13 -0600 (MDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by severn.wwwdotorg.org (Postfix) with ESMTPSA id 828F4E461B;
        Mon, 19 Aug 2013 13:12:07 -0600 (MDT)
Message-ID: <52126E06.1040108@wwwdotorg.org>
Date:   Mon, 19 Aug 2013 13:12:06 -0600
From:   Stephen Warren <swarren@wwwdotorg.org>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130803 Thunderbird/17.0.8
MIME-Version: 1.0
To:     Sherman Yin <syin@broadcom.com>
CC:     linux-kernel@vger.kernel.org, linus.walleij@linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-mips@linux-mips.org,
        matt.porter@linaro.org, csd@broadcom.com, mmayer@broadcom.com,
        james.hogan@imgtec.com
Subject: Re: [PATCH] pinctrl: Pass all configs to driver on pin_config_set()
References: <1376606573-15093-1-git-send-email-syin@broadcom.com>
In-Reply-To: <1376606573-15093-1-git-send-email-syin@broadcom.com>
X-Enigmail-Version: 1.4.6
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.97.8 at avon.wwwdotorg.org
X-Virus-Status: Clean
Return-Path: <swarren@wwwdotorg.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37590
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: swarren@wwwdotorg.org
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

On 08/15/2013 04:42 PM, Sherman Yin wrote:
> When setting pin configuration in the pinctrl framework, pin_config_set() or
> pin_config_group_set() is called in a loop to set one configuration at a time
> for the specified pin or group.
> 
> This patch 1) removes the loop and 2) changes the API to pass the whole pin
> config array to the driver.  It is now up to the driver to loop through the
> configs.  This allows the driver to potentially combine configs and reduce the
> number of writes to pin config registers.
> 
> Signed-off-by: Sherman Yin <syin@broadcom.com>
> Reviewed-by: Christian Daudt <csd@broadcom.com>
> Reviewed-by: Matt Porter <matt.porter@linaro.org>

> Change-Id: I99cbfa2ae7b774456eb71edb276711b1ddcd42c8

That tag shouldn't be included in upstream patches.

>  drivers/pinctrl/pinconf.c             |   42 ++++----
>  drivers/pinctrl/pinctrl-tegra.c       |   69 ++++++------
>  include/linux/pinctrl/pinconf.h       |    6 +-

Those files, Reviewed-by: Stephen Warren <swarren@nvidia.com>

On Tegra (Tegra114 Dalmore board, on top of next-20130816),
Tested-by: Stephen Warren <nvidia.com>
