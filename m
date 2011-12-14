Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 14 Dec 2011 17:55:47 +0100 (CET)
Received: from [205.233.59.134] ([205.233.59.134]:33657 "EHLO
        merlin.infradead.org" rhost-flags-FAIL-FAIL-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903618Ab1LNQzm convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 14 Dec 2011 17:55:42 +0100
Received: from canuck.infradead.org ([2001:4978:20e::1])
        by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
        id 1Ras7D-0001lG-1w; Wed, 14 Dec 2011 16:55:35 +0000
Received: from j77219.upc-j.chello.nl ([24.132.77.219] helo=twins)
        by canuck.infradead.org with esmtpsa (Exim 4.76 #1 (Red Hat Linux))
        id 1Ras7C-0005HD-1e; Wed, 14 Dec 2011 16:55:34 +0000
Received: by twins (Postfix, from userid 1000)
        id 2E4848278324; Wed, 14 Dec 2011 17:54:44 +0100 (CET)
Message-ID: <1323881470.28489.51.camel@twins>
Subject: Re: [PATCH] jump-label: initialize jump-label subsystem somewhat
 later
From:   Peter Zijlstra <a.p.zijlstra@chello.nl>
To:     David Daney <ddaney.cavm@gmail.com>
Cc:     ralf@linux-mips.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-mips@linux-mips.org,
        Jeremy Fitzhardinge <jeremy.fitzhardinge@citrix.com>,
        linux-kernel@vger.kernel.org, Jason Baron <jbaron@redhat.com>,
        David Daney <david.daney@cavium.com>
In-Reply-To: <1323881315-23245-1-git-send-email-ddaney.cavm@gmail.com>
References: <1323881315-23245-1-git-send-email-ddaney.cavm@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Date:   Wed, 14 Dec 2011 17:51:10 +0100
Mime-Version: 1.0
X-Mailer: Evolution 3.2.1- 
X-archive-position: 32094
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: a.p.zijlstra@chello.nl
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 11497

On Wed, 2011-12-14 at 08:48 -0800, David Daney wrote:
> From: David Daney <david.daney@cavium.com>
> 
> commit 97ce2c88f9ad42e3c60a9beb9fca87abf3639faa breaks MIPS.
> 
> The jump-lable initialization does I-Cache flushing after modifying
> code.  On MIPS this is done by calling through the function pointer
> flush_icache_range().  This function pointer is initialized mm_init().
> 
> As things stand, we cannot be calling jump_label_init() until after
> mm_init() completes, so we move the call down to satisfy this
> constraint.

I'm fine as long as it stays before sched_init(), which it does. Jeremy
is this still early enough for you?
