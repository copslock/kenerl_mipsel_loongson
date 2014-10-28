Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 28 Oct 2014 13:48:08 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:51283 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27011620AbaJ1MsGiLFyr (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 28 Oct 2014 13:48:06 +0100
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.8/8.14.8) with ESMTP id s9SCm5Fg022417;
        Tue, 28 Oct 2014 13:48:05 +0100
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.8/8.14.8/Submit) id s9SCm5Mg022416;
        Tue, 28 Oct 2014 13:48:05 +0100
Date:   Tue, 28 Oct 2014 13:48:05 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Cc:     linux-mips@linux-mips.org, Hauke Mehrtens <hauke@hauke-m.de>
Subject: Re: [PATCH] MIPS: BCM47XX: Make bcma init NVRAM instead of bcm47xx
 polling it
Message-ID: <20141028124804.GC16320@linux-mips.org>
References: <1414499423-16662-1-git-send-email-zajec5@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1414499423-16662-1-git-send-email-zajec5@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43625
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

On Tue, Oct 28, 2014 at 01:30:23PM +0100, Rafał Miłecki wrote:

> This drops ssb/bcma dependency and will allow us to make it a standalone
> driver.
> 
> Signed-off-by: Rafał Miłecki <zajec5@gmail.com>
> ---
> This patch depends on
> [PATCH V2] MIPS: BCM47XX: Make ssb init NVRAM instead of bcm47xx polling it

You've even posted a V3 of that patch:

V2: https://patchwork.linux-mips.org/patch/7609/
V3: https://patchwork.linux-mips.org/patch/7612/

I assume you meant V3?

  Ralf
