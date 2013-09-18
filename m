Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 18 Sep 2013 16:56:32 +0200 (CEST)
Received: from server19320154104.serverpool.info ([193.201.54.104]:46436 "EHLO
        hauke-m.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6817537Ab3IRO41P7LNO (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 18 Sep 2013 16:56:27 +0200
Received: from localhost (localhost [127.0.0.1])
        by hauke-m.de (Postfix) with ESMTP id 0B2E1857F;
        Wed, 18 Sep 2013 16:56:27 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at hauke-m.de 
Received: from hauke-m.de ([127.0.0.1])
        by localhost (hauke-m.de [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id IH4zpev31xIY; Wed, 18 Sep 2013 16:56:23 +0200 (CEST)
Received: from [IPv6:2001:470:1f0b:447:4ca:e75d:fb06:9711] (unknown [IPv6:2001:470:1f0b:447:4ca:e75d:fb06:9711])
        by hauke-m.de (Postfix) with ESMTPSA id 0075E8F62;
        Wed, 18 Sep 2013 16:56:18 +0200 (CEST)
Message-ID: <5239BF12.7060907@hauke-m.de>
Date:   Wed, 18 Sep 2013 16:56:18 +0200
From:   Hauke Mehrtens <hauke@hauke-m.de>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130803 Thunderbird/17.0.8
MIME-Version: 1.0
To:     Geert Uytterhoeven <geert@linux-m68k.org>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>
Subject: Re: [PATCH] MIPS: BCM47XX: put board detention data into init section
References: <1379515235-29161-1-git-send-email-hauke@hauke-m.de> <CAMuHMdUKHEBBCio2ixu04i8dc-mBvK3fD8VuXr2y1GSV5zrh3A@mail.gmail.com>
In-Reply-To: <CAMuHMdUKHEBBCio2ixu04i8dc-mBvK3fD8VuXr2y1GSV5zrh3A@mail.gmail.com>
X-Enigmail-Version: 1.4.6
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-Path: <hauke@hauke-m.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37872
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hauke@hauke-m.de
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

On 09/18/2013 04:43 PM, Geert Uytterhoeven wrote:
> On Wed, Sep 18, 2013 at 4:40 PM, Hauke Mehrtens <hauke@hauke-m.de> wrote:
>> +       strncpy(bcm47xx_board.name, board_detected->name, BCM47XX_BOARD_MAX_NAME);
>> +       bcm47xx_board.name[BCM47XX_BOARD_MAX_NAME - 1] = 0;
> 
> You can use strlcpy() instead.
> 
Thanks, I haven't know of this function.

Hauke
