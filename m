Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 06 Jun 2010 03:30:57 +0200 (CEST)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:35533 "EHLO h5.dl5rb.org.uk"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1492229Ab0FFBay (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sun, 6 Jun 2010 03:30:54 +0200
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
        by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id o561U2nY006235;
        Sun, 6 Jun 2010 02:30:05 +0100
Received: (from ralf@localhost)
        by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id o561Tx7J006233;
        Sun, 6 Jun 2010 02:29:59 +0100
Date:   Sun, 6 Jun 2010 02:29:59 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Kevin Cernekee <cernekee@gmail.com>, mingo@elte.hu,
        simon.kagstrom@netinsight.net, David.Woodhouse@intel.com,
        lethal@linux-sh.org, linux-kernel@vger.kernel.org,
        linux-mips@linux-mips.org
Subject: Re: [PATCH v3] printk: fix delayed messages from CPU hotplug events
Message-ID: <20100606012958.GA6169@linux-mips.org>
References: <ee1bf4f9c158983acad0a4548229586128afad67@localhost>
 <20100603225824.8de77fba.akpm@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20100603225824.8de77fba.akpm@linux-foundation.org>
User-Agent: Mutt/1.5.20 (2009-08-17)
X-archive-position: 27080
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 4084

On Thu, Jun 03, 2010 at 10:58:24PM -0700, Andrew Morton wrote:

Assuming everybody is happy now I've merged Andrew's patch into Kevin's
patch and dropped it into the linux-queue tree and my tree for -next.
If nobody objects I intend to send the patch to Linus in about a week
or so.

Andrew, your patch had no Signed-off-by ;-)

Thanks everbody,

  Ralf
