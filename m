Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 02 Aug 2010 15:30:39 +0200 (CEST)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:60918 "EHLO h5.dl5rb.org.uk"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1492511Ab0HBNaU (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 2 Aug 2010 15:30:20 +0200
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
        by h5.dl5rb.org.uk (8.14.4/8.14.3) with ESMTP id o72DUA4B016749;
        Mon, 2 Aug 2010 14:30:10 +0100
Received: (from ralf@localhost)
        by h5.dl5rb.org.uk (8.14.4/8.14.4/Submit) id o72DU8l6016748;
        Mon, 2 Aug 2010 14:30:08 +0100
Date:   Mon, 2 Aug 2010 14:30:08 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Jason Wessel <jason.wessel@windriver.com>
Cc:     linux-kernel@vger.kernel.org, kgdb-bugreport@lists.sourceforge.net,
        mingo@elte.hu, linux-mips@linux-mips.org
Subject: Re: [PATCH 05/15] mips,kgdb: Individual register get/set for mips
Message-ID: <20100802133008.GB5209@linux-mips.org>
References: <1280517456-1167-1-git-send-email-jason.wessel@windriver.com>
 <1280517456-1167-6-git-send-email-jason.wessel@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1280517456-1167-6-git-send-email-jason.wessel@windriver.com>
User-Agent: Mutt/1.5.20 (2009-12-10)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 27529
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, Jul 30, 2010 at 02:17:26PM -0500, Jason Wessel wrote:

> Implement the ability to individually get and set registers for kdb
> and kgdb for mips.
> 
> Signed-off-by: Jason Wessel <jason.wessel@windriver.com>
> CC: Ralf Baechle <ralf@linux-mips.org>
> CC: linux-mips@linux-mips.org

Looks good; I think this should be be merged with the rest of your stuff.

Acked-by: Ralf Baechle <ralf@linux-mips.org>

  Ralf
