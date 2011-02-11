Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 11 Feb 2011 16:03:20 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:57547 "EHLO
        duck.linux-mips.net" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S1491059Ab1BKPDQ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 11 Feb 2011 16:03:16 +0100
Received: from duck.linux-mips.net (localhost.localdomain [127.0.0.1])
        by duck.linux-mips.net (8.14.4/8.14.4) with ESMTP id p1BF447w009416;
        Fri, 11 Feb 2011 16:04:04 +0100
Received: (from ralf@localhost)
        by duck.linux-mips.net (8.14.4/8.14.4/Submit) id p1BF43qL009413;
        Fri, 11 Feb 2011 16:04:03 +0100
Date:   Fri, 11 Feb 2011 16:04:03 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     "Anoop P.A" <anoop.pa@gmail.com>
Cc:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/6] Cpu features overrides for msp platforms.
Message-ID: <20110211150403.GG23348@linux-mips.org>
References: <1295943797-20467-1-git-send-email-anoop.pa@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1295943797-20467-1-git-send-email-anoop.pa@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <ralf@duck.linux-mips.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29168
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

Queued for 2.6.39, thanks!

But: this is a rather short cpu-feature-overrides.h file.  You can shrink
the kernel significantly and get a little performance boost by further
defines in that file.  In particular defining the symbols for cache and
TLB properties such as the cpu_dcache_line_size and cpu_icache_line_size
are very effective.

  Ralf
