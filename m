Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 09 Aug 2015 22:14:59 +0200 (CEST)
Received: from hauke-m.de ([5.39.93.123]:38245 "EHLO hauke-m.de"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27011855AbbHIUO521x6j (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sun, 9 Aug 2015 22:14:57 +0200
Received: from [192.168.178.24] (p5DE948B6.dip0.t-ipconnect.de [93.233.72.182])
        by hauke-m.de (Postfix) with ESMTPSA id E8EEB100733;
        Sun,  9 Aug 2015 22:14:56 +0200 (CEST)
Message-ID: <55C7B4C0.7060903@hauke-m.de>
Date:   Sun, 09 Aug 2015 22:14:56 +0200
From:   Hauke Mehrtens <hauke@hauke-m.de>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.8.0
MIME-Version: 1.0
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     Andrzej Hajda <a.hajda@samsung.com>,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        linux-kernel@vger.kernel.org, linux-mips@linux-mips.org
Subject: Re: [PATCH 04/31] arch/mips/bcm47xx: use kmemdup rather than duplicating
 its implementation
References: <1438934377-4922-1-git-send-email-a.hajda@samsung.com> <1438934377-4922-5-git-send-email-a.hajda@samsung.com>
In-Reply-To: <1438934377-4922-5-git-send-email-a.hajda@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-Path: <hauke@hauke-m.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48744
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

On 08/07/2015 09:59 AM, Andrzej Hajda wrote:
> The patch was generated using fixed coccinelle semantic patch
> scripts/coccinelle/api/memdup.cocci [1].
> 
> [1]: http://permalink.gmane.org/gmane.linux.kernel/2014320
> 
> Signed-off-by: Andrzej Hajda <a.hajda@samsung.com>

Acked-by: Hauke Mehrtens <hauke@hauke-m.de>
