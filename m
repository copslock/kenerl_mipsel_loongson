Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 18 Dec 2014 14:02:10 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:35470 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27009089AbaLRNCEtCMi3 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 18 Dec 2014 14:02:04 +0100
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.8/8.14.8) with ESMTP id sBID23ST000393;
        Thu, 18 Dec 2014 14:02:04 +0100
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.8/8.14.8/Submit) id sBID23IW000392;
        Thu, 18 Dec 2014 14:02:03 +0100
Date:   Thu, 18 Dec 2014 14:02:03 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Brian Norris <computersforpeace@gmail.com>
Cc:     linux-mips@linux-mips.org
Subject: Re: [PATCH] MIPS: JZ4740: fixup #include's (sparse)
Message-ID: <20141218130203.GC25711@linux-mips.org>
References: <1418870341-16618-1-git-send-email-computersforpeace@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1418870341-16618-1-git-send-email-computersforpeace@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44733
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

On Wed, Dec 17, 2014 at 06:39:01PM -0800, Brian Norris wrote:

> Fixes sparse warnings:
> 
>   arch/mips/jz4740/irq.c:63:6: warning: symbol 'jz4740_irq_suspend' was not declared. Should it be static?
>   arch/mips/jz4740/irq.c:69:6: warning: symbol 'jz4740_irq_resume' was not declared. Should it be static?
> 
> Also, I've seen some elusive build errors on my automated build test
> where JZ4740_IRQ_BASE and NR_IRQS are missing, but I can't reproduce
> them manually for some reason. Anyway, mach-jz4740/irq.h should help us
> avoid relying on some implicit include.

Patch is looking good.

There is a known issue building jz in a separate build directory; building
in the source directory itself will succeed.  Could that be why you can't
seem to reproduce the build issue?

  Ralf
