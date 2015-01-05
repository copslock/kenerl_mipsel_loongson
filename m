Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 05 Jan 2015 18:45:42 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:56961 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27014302AbbAERpjcPoa7 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 5 Jan 2015 18:45:39 +0100
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.8/8.14.8) with ESMTP id t05HjcQi027663;
        Mon, 5 Jan 2015 18:45:38 +0100
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.8/8.14.8/Submit) id t05HjbqZ027662;
        Mon, 5 Jan 2015 18:45:37 +0100
Date:   Mon, 5 Jan 2015 18:45:37 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     James Hogan <james.hogan@imgtec.com>
Cc:     linux-mips@linux-mips.org, Paul Burton <paul.burton@imgtec.com>
Subject: Re: [PATCH] MIPS: mips-cm: Fix sparse warnings
Message-ID: <20150105174537.GB14192@linux-mips.org>
References: <1420472730-23629-1-git-send-email-james.hogan@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1420472730-23629-1-git-send-email-james.hogan@imgtec.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44965
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

On Mon, Jan 05, 2015 at 03:45:30PM +0000, James Hogan wrote:

> Sparse emits a bunch of warnings in mips-cm.h due to casting away of
> __iomem by the addr_gcr_*() functions:
> 
> arch/mips/include/asm/mips-cm.h:134:1: warning: cast removes address space of expression
> 
> And subsequent passing of the return values to __raw_readl() and
> __raw_writel() in the read_gcr_*() and write_gcr_*() functions:
> 
> arch/mips/include/asm/mips-cm.h:134:1: warning: incorrect type in argument 2 (different address spaces)
> arch/mips/include/asm/mips-cm.h:134:1:    expected void volatile [noderef] <asn:2>*mem
> arch/mips/include/asm/mips-cm.h:134:1:    got unsigned int [usertype] *
> arch/mips/include/asm/mips-cm.h:134:1: warning: incorrect type in argument 1 (different address spaces)
> arch/mips/include/asm/mips-cm.h:134:1:    expected void const volatile [noderef] <asn:2>*mem
> arch/mips/include/asm/mips-cm.h:134:1:    got unsigned int [usertype] *
> 
> Fix by adding __iomem to the addr_gcr_*() return type and cast.

Thanks, applied.

  Ralf
