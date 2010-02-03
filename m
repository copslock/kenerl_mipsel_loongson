Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 03 Feb 2010 14:47:34 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:44850 "EHLO h5.dl5rb.org.uk"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S1491970Ab0BCNra (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 3 Feb 2010 14:47:30 +0100
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
        by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id o13DlkOh010202;
        Wed, 3 Feb 2010 14:47:47 +0100
Received: (from ralf@localhost)
        by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id o13Dljot010201;
        Wed, 3 Feb 2010 14:47:45 +0100
Date:   Wed, 3 Feb 2010 14:47:45 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     David Daney <ddaney@caviumnetworks.com>
Cc:     linux-mips@linux-mips.org
Subject: Re: [PATCH] MIPS: Remove #if 0 r4k_update_mmu_cache_hwbug
Message-ID: <20100203134744.GA9389@linux-mips.org>
References: <1265159978-12434-1-git-send-email-ddaney@caviumnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1265159978-12434-1-git-send-email-ddaney@caviumnetworks.com>
User-Agent: Mutt/1.5.20 (2009-08-17)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25869
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Feb 02, 2010 at 05:19:38PM -0800, David Daney wrote:

> The function is #if 0ed out.  There are no other occurrences of its
> name in the tree.  It is safe to remove.

It had a long sad live - unused since 2.1.16 and intended to be used for
an R4000 workaround.  Let it rest in pieces.

Queued for 2.6.34,

  Ralf
