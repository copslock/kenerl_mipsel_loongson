Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 15 Jan 2013 19:04:59 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:34121 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S6832191Ab3AOSEylkxOW (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 15 Jan 2013 19:04:54 +0100
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.5/8.14.4) with ESMTP id r0FI4mUH008075;
        Tue, 15 Jan 2013 19:04:48 +0100
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.5/8.14.5/Submit) id r0FI4lGA008074;
        Tue, 15 Jan 2013 19:04:47 +0100
Date:   Tue, 15 Jan 2013 19:04:46 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Jayachandran C <jchandra@broadcom.com>
Cc:     linux-mips@linux-mips.org
Subject: Re: [PATCH 04/10] MIPS: Netlogic: Split XLP L1 i-cache among threads
Message-ID: <20130115180446.GA4526@linux-mips.org>
References: <1358179922-26663-1-git-send-email-jchandra@broadcom.com>
 <1358179922-26663-5-git-send-email-jchandra@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1358179922-26663-5-git-send-email-jchandra@broadcom.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-archive-position: 35448
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

On Mon, Jan 14, 2013 at 09:41:56PM +0530, Jayachandran C wrote:

> Since we now use r4k cache code for Netlogic XLP, it is
> better to split L1 icache among the active threads, so that
> threads won't step on each other while flushing icache.
> 
> The L1 dcache is already split among the threads in the core.

It's a bit orthogonal to your patch but you may want to look at adding
support for SYS_SUPPORTS_SCHED_SMT which scheduler support for SMT that
is tries to schedule threads in a shared cache friendly way.  See
0ab7aefc4d43a6dee26c891b41ef9c7a67d2379b [[MIPS] MT: Scheduler support for
SMT].

  Ralf
