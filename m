Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 16 Nov 2015 20:04:43 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:59694 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27012822AbbKPTElyWkD8 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 16 Nov 2015 20:04:41 +0100
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.15.2/8.14.8) with ESMTP id tAGJ4efo021555;
        Mon, 16 Nov 2015 20:04:40 +0100
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.15.2/8.15.2/Submit) id tAGJ4eCY021554;
        Mon, 16 Nov 2015 20:04:40 +0100
Date:   Mon, 16 Nov 2015 20:04:39 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Brian Norris <computersforpeace@gmail.com>
Cc:     linux-mtd@lists.infradead.org, linux-mips@linux-mips.org
Subject: Re: [PATCH] mtd: jz4740_nand: fix build on jz4740 after removing
 gpio.h
Message-ID: <20151116190439.GD9425@linux-mips.org>
References: <1447284976-96693-1-git-send-email-computersforpeace@gmail.com>
 <20151116132328.GB9425@linux-mips.org>
 <20151116184917.GM8456@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20151116184917.GM8456@google.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49946
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

On Mon, Nov 16, 2015 at 10:49:17AM -0800, Brian Norris wrote:

> Actually, if you don't mind, I'll take it through MTD. I think I'll have
> a few things to push upstream this week anyway, and I'd like to get some
> of my MIPS-based build test configs working again in my development
> trees.
> 
> So...pushed to linux-mtd.git

Cool, thanks!

  Ralf
