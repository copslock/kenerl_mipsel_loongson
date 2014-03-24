Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 24 Mar 2014 15:17:52 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:55219 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S6823121AbaCXONK6r0Xq (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 24 Mar 2014 15:13:10 +0100
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.7/8.14.4) with ESMTP id s2OED0CY021047;
        Mon, 24 Mar 2014 15:13:00 +0100
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.7/8.14.7/Submit) id s2OECxpw021046;
        Mon, 24 Mar 2014 15:12:59 +0100
Date:   Mon, 24 Mar 2014 15:12:59 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Florian Fainelli <florian@openwrt.org>
Cc:     linux-mips@linux-mips.org, blogic@openwrt.org, macro@linux-mips.org
Subject: Re: [PATCH 1/2] MIPS: add MIPS_L1_CACHE_SHIFT_2
Message-ID: <20140324141259.GL17197@linux-mips.org>
References: <1390327294-2618-1-git-send-email-florian@openwrt.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1390327294-2618-1-git-send-email-florian@openwrt.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39573
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

On Tue, Jan 21, 2014 at 10:01:33AM -0800, Florian Fainelli wrote:

> Some older machines such as the DECStation use a L1 data-cache shift of
> 2 (value of 4), add a Kconfig symbol for this value so they can express
> this requirement.

Older DECstations got R2000/R3000 processors which have 16 byte cache
lines.  So a cache shift value of 4 would appear to be right.  Maciej?

  Ralf
