Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 24 Jan 2017 21:13:56 +0100 (CET)
Received: from hauke-m.de ([IPv6:2001:41d0:8:b27b::1]:45652 "EHLO
        mail.hauke-m.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23991346AbdAXUNtSBsW6 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 24 Jan 2017 21:13:49 +0100
Received: from [192.168.10.229] (p4FD97029.dip0.t-ipconnect.de [79.217.112.41])
        by mail.hauke-m.de (Postfix) with ESMTPSA id 7438D10002C;
        Tue, 24 Jan 2017 21:13:41 +0100 (CET)
Subject: Re: [PATCH] MIPS: BCM47XX: Add Luxul devices to the database
To:     Dan Haab <dhaab@luxul.com>, Ralf Baechle <ralf@linux-mips.org>
References: <1485201038-15834-1-git-send-email-dhaab@luxul.com>
Cc:     =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
        linux-mips@linux-mips.org
From:   Hauke Mehrtens <hauke@hauke-m.de>
Message-ID: <641958b1-a8fb-7a48-233b-b010cd16c7e8@hauke-m.de>
Date:   Tue, 24 Jan 2017 21:13:40 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Icedove/45.6.0
MIME-Version: 1.0
In-Reply-To: <1485201038-15834-1-git-send-email-dhaab@luxul.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-Path: <hauke@hauke-m.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56479
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

On 01/23/2017 08:50 PM, Dan Haab wrote:
> So far only Luxul XWR-1750 router was supported. This adds a set of
> other Luxul devices based on BCM47XX. It's a standard support for LEDs
> and buttons.
> 
> Signed-off-by: Dan Haab <dhaab@luxul.com>
> ---
>  arch/mips/bcm47xx/board.c                          |    9 +++
>  arch/mips/bcm47xx/buttons.c                        |   72 +++++++++++++++++
>  arch/mips/bcm47xx/leds.c                           |   81 ++++++++++++++++++++
>  arch/mips/include/asm/mach-bcm47xx/bcm47xx_board.h |    9 +++
>  4 files changed, 171 insertions(+)
> 

Acked-by: Hauke Mehrtens <hauke@hauke-m.de>
