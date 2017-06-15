Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 15 Jun 2017 11:59:52 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:60654 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23991726AbdFOJ7pj917T (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 15 Jun 2017 11:59:45 +0200
Received: from h7.dl5rb.org.uk (localhost [127.0.0.1])
        by h7.dl5rb.org.uk (8.15.2/8.14.8) with ESMTP id v5F9xeWI004287;
        Thu, 15 Jun 2017 11:59:40 +0200
Received: (from ralf@localhost)
        by h7.dl5rb.org.uk (8.15.2/8.15.2/Submit) id v5F9xcZC004271;
        Thu, 15 Jun 2017 11:59:38 +0200
Date:   Thu, 15 Jun 2017 11:59:38 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Huacai Chen <chenhc@lemote.com>
Cc:     John Crispin <john@phrozen.org>,
        "Steven J . Hill" <Steven.Hill@cavium.com>,
        linux-mips@linux-mips.org, Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>, stable@vger.kernel.org
Subject: Re: [PATCH V5 2/9] MIPS: c-r4k: Add r4k_blast_scache_node for
 Loongson-3
Message-ID: <20170615095938.GA1391@linux-mips.org>
References: <1497492952-23877-1-git-send-email-chenhc@lemote.com>
 <1497492952-23877-3-git-send-email-chenhc@lemote.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1497492952-23877-3-git-send-email-chenhc@lemote.com>
User-Agent: Mutt/1.8.0 (2017-02-23)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58468
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

On Thu, Jun 15, 2017 at 10:15:45AM +0800, Huacai Chen wrote:

> For multi-node Loongson-3 (NUMA configuration), r4k_blast_scache() can
> only flush Node-0's scache. So we add r4k_blast_scache_node() by using
> (CAC_BASE | (node_id << NODE_ADDRSPACE_SHIFT)) instead of CKSEG0 as the
> start address.
> 
> Maybe all MIPS CPUs need r4k_blast_scache_node() to support cc-NUMA,
> but I don't know how to implement it for non-Loongson CPUs.

There other MIPS ccNUMA systems handle caches in hardware fully transparent
to software so no changes are required.  These systems are SGI's SN
(Origin, Onyx) and BCM1480 (ccNUMA support out of tree, but no sw support
required)).

  Ralf
