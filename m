Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 03 Sep 2013 16:58:49 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:59029 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S6825704Ab3ICO6qafc0B (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 3 Sep 2013 16:58:46 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.5/8.14.4) with ESMTP id r83Ewhfa014523;
        Tue, 3 Sep 2013 16:58:43 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.5/8.14.5/Submit) id r83EwdwW014522;
        Tue, 3 Sep 2013 16:58:39 +0200
Date:   Tue, 3 Sep 2013 16:58:39 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Markos Chandras <markos.chandras@imgtec.com>,
        Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org,
        Bryan Wu <cooloney@gmail.com>,
        Richard Purdie <rpurdie@rpsys.net>, linux-leds@vger.kernel.org
Cc:     linux-mips@linux-mips.org
Subject: Re: [PATCH] MIPS: sead3: Select NEW_LEDS, LEDS_CLASS and I2C symbols
Message-ID: <20130903145839.GA14258@linux-mips.org>
References: <1378218420-28011-1-git-send-email-markos.chandras@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1378218420-28011-1-git-send-email-markos.chandras@imgtec.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37748
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
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

On Tue, Sep 03, 2013 at 03:27:00PM +0100, Markos Chandras wrote:

> Select NEW_LEDS and LEDS_CLASS since they export symbols
> needed by leds-sead3.c. Fixes the following build problem:
> 
> leds-sead3.c:(.text+0xf0c): undefined
> reference to `led_classdev_unregister'
> leds-sead3.c:(.text+0xf18): undefined
> reference to `led_classdev_unregister'
> 
> Also select I2C since it's needed by sead3-pic32-i2c-drv.c
> Fixes the following build problem:
> arch/mips/mti-sead3/sead3-pic32-i2c-drv.c:350:2: error:
> implicit declaration of
> function 'i2c_add_numbered_adapter'

You probably should setup a bus like all the other callers of
i2c_add_numbered_adapter() in drivers/i2c/busses/; similar for the LED
issue.

  Ralf
