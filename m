Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 08 Dec 2011 17:24:00 +0100 (CET)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:50948 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S1903700Ab1LHQXz (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 8 Dec 2011 17:23:55 +0100
Received: from duck.linux-mips.net (duck.linux-mips.net [127.0.0.1])
        by duck.linux-mips.net (8.14.4/8.14.4) with ESMTP id pB8GJfpm017919;
        Thu, 8 Dec 2011 16:19:41 GMT
Received: (from ralf@localhost)
        by duck.linux-mips.net (8.14.4/8.14.4/Submit) id pB8GJVbq017911;
        Thu, 8 Dec 2011 16:19:31 GMT
Date:   Thu, 8 Dec 2011 16:19:31 +0000
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Tejun Heo <tj@kernel.org>
Cc:     benh@kernel.crashing.org, yinghai@kernel.org, hpa@zytor.com,
        tony.luck@intel.com, schwidefsky@de.ibm.com,
        liqin.chen@sunplusct.com, lethal@linux-sh.org, davem@davemloft.net,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        mingo@redhat.com, jonas@southpole.se, lennox.wu@gmail.com,
        linux-mips@linux-mips.org
Subject: Re: [PATCH 19/23] mips: Use HAVE_MEMBLOCK_NODE_MAP
Message-ID: <20111208161931.GA17864@linux-mips.org>
References: <1322508685-32532-1-git-send-email-tj@kernel.org>
 <1322508685-32532-20-git-send-email-tj@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1322508685-32532-20-git-send-email-tj@kernel.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-archive-position: 32062
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 6902

On Mon, Nov 28, 2011 at 11:31:21AM -0800, Tejun Heo wrote:

> mips used early_node_map[] just to prime free_area_init_nodes().  Now
> memblock can be used for the same purpose and early_node_map[] is
> scheduled to be dropped.  Use memblock instead.

Acked-by: Ralf Baechle <ralf@linux-mips.org>

Thanks,

  Ralf
