Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 20 Jul 2012 11:16:10 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:58909 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S1903645Ab2GTJQF (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 20 Jul 2012 11:16:05 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.5/8.14.4) with ESMTP id q6K9G4Gn021221;
        Fri, 20 Jul 2012 11:16:04 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.5/8.14.5/Submit) id q6K9G2Pd021220;
        Fri, 20 Jul 2012 11:16:02 +0200
Date:   Fri, 20 Jul 2012 11:16:02 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     kr kr <kr-jiffy@yandex.ru>
Cc:     linux-mips@linux-mips.org
Subject: Re: [mips32r1 cpu] Advice needed: "Machine Check exception - caused
 by multiple matching entries in the TLB"
Message-ID: <20120720091602.GA15546@linux-mips.org>
References: <194011342123405@web6e.yandex.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <194011342123405@web6e.yandex.ru>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-archive-position: 33943
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
Return-Path: <linux-mips-bounce@linux-mips.org>

On Fri, Jul 13, 2012 at 12:03:25AM +0400, kr kr wrote:

> [   12.560000] Kernel panic - not syncing: Caught Machine Check exception - caused by multiple matching entries in the TLB.

Running userland should never result in crashing the kernel except if
programs directly touch I/O hardware an do stupid things or abuse their
root priviledges..

This type of crash specifically has in the past been produced by incorrect
hazard barriers but also CPU hardware bugs so you may want to review the
kernel code against a CPU datasheet and errata documentation.  As always
with hardware that is only supported out of tree we can't be too helpful ...

  Ralf
