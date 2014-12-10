Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 10 Dec 2014 21:30:23 +0100 (CET)
Received: from hauke-m.de ([5.39.93.123]:40828 "EHLO hauke-m.de"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27007750AbaLJUaWIZN5T (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 10 Dec 2014 21:30:22 +0100
Received: from [IPv6:2001:470:7259:0:35be:a847:adf9:95cd] (unknown [IPv6:2001:470:7259:0:35be:a847:adf9:95cd])
        by hauke-m.de (Postfix) with ESMTPSA id BA49320107;
        Wed, 10 Dec 2014 21:30:21 +0100 (CET)
Message-ID: <5488AD5D.7000405@hauke-m.de>
Date:   Wed, 10 Dec 2014 21:30:21 +0100
From:   Hauke Mehrtens <hauke@hauke-m.de>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.3.0
MIME-Version: 1.0
To:     =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
        linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>
CC:     Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH V2 1/3] MIPS: BCM47XX: Fix coding style to match kernel
 standards
References: <1418208594-16235-1-git-send-email-zajec5@gmail.com> <1418229506-30245-1-git-send-email-zajec5@gmail.com>
In-Reply-To: <1418229506-30245-1-git-send-email-zajec5@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-Path: <hauke@hauke-m.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44617
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

On 12/10/2014 05:38 PM, Rafał Miłecki wrote:
> Signed-off-by: Rafał Miłecki <zajec5@gmail.com>
> ---
> V2: Replace
> char *nvram_var = "gpioXX";
> with
> char nvram_var[] = "gpioXX";
> to fix sizeof().
> ---
>  arch/mips/bcm47xx/bcm47xx_private.h |  4 ++++
>  arch/mips/bcm47xx/board.c           |  3 +--
>  arch/mips/bcm47xx/nvram.c           | 25 ++++++++++++++-----------
>  arch/mips/bcm47xx/prom.c            |  3 +--
>  arch/mips/bcm47xx/serial.c          |  8 ++++----
>  arch/mips/bcm47xx/setup.c           | 12 ++++++------
>  arch/mips/bcm47xx/sprom.c           |  8 ++++----
>  arch/mips/bcm47xx/time.c            |  1 -
>  8 files changed, 34 insertions(+), 30 deletions(-)
> 

Acked-by: Hauke Mehrtens <hauke@hauke-m.de>
For all 3 patches.
