Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 07 Sep 2014 21:32:06 +0200 (CEST)
Received: from hauke-m.de ([5.39.93.123]:39896 "EHLO hauke-m.de"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27008376AbaIGTcEMao7K (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sun, 7 Sep 2014 21:32:04 +0200
Received: from [IPv6:2001:470:7259:0:b952:7678:9bd5:1eb9] (unknown [IPv6:2001:470:7259:0:b952:7678:9bd5:1eb9])
        by hauke-m.de (Postfix) with ESMTPSA id C0A2F2063D;
        Sun,  7 Sep 2014 21:32:03 +0200 (CEST)
Message-ID: <540CB2B2.7010309@hauke-m.de>
Date:   Sun, 07 Sep 2014 21:32:02 +0200
From:   Hauke Mehrtens <hauke@hauke-m.de>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.0
MIME-Version: 1.0
To:     =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
        linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [PATCH] MIPS: BCM47XX: Move SPROM fallback code into sprom.c
References: <1409904503-31202-1-git-send-email-zajec5@gmail.com>
In-Reply-To: <1409904503-31202-1-git-send-email-zajec5@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-Path: <hauke@hauke-m.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42464
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

On 09/05/2014 10:08 AM, Rafał Miłecki wrote:
> This is some general cleanup as well as preparing sprom.c to become a
> standalone driver. We will need this for bcm53xx ARM arch support.
> 
> Signed-off-by: Rafał Miłecki <zajec5@gmail.com>

Acked-by: Hauke Mehrtens <hauke@hauke-m.de>

> ---
>  arch/mips/bcm47xx/bcm47xx_private.h |  3 ++
>  arch/mips/bcm47xx/setup.c           | 58 ++-----------------------------
>  arch/mips/bcm47xx/sprom.c           | 68 +++++++++++++++++++++++++++++++++++++
>  3 files changed, 73 insertions(+), 56 deletions(-)
> 
