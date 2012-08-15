Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 15 Aug 2012 12:57:32 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:44444 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S1903553Ab2HOK52 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 15 Aug 2012 12:57:28 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.5/8.14.4) with ESMTP id q7FAvNS9006519;
        Wed, 15 Aug 2012 12:57:23 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.5/8.14.5/Submit) id q7FAvKKX006515;
        Wed, 15 Aug 2012 12:57:20 +0200
Date:   Wed, 15 Aug 2012 12:57:20 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     David Daney <ddaney.cavm@gmail.com>
Cc:     linux-mips@linux-mips.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        David Daney <david.daney@cavium.com>
Subject: Re: [PATCH 0/2] Align MIPS swapper_pg_dir for faster code.
Message-ID: <20120815105720.GA6270@linux-mips.org>
References: <1344967681-13179-1-git-send-email-ddaney.cavm@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1344967681-13179-1-git-send-email-ddaney.cavm@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-archive-position: 34179
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

On Tue, Aug 14, 2012 at 11:07:59AM -0700, David Daney wrote:

> From: David Daney <david.daney@cavium.com>
> 
> The MIPS swapper_pg_dir needs 64K alignment for faster TLB refills in
> kernel mappings.  There are two parts to the patch set:
> 
> 1) Modify generic vmlinux.lds.h to allow architectures to place
>    additional sections at the start of .bss.  This allows alignment
>    constraints to be met with minimal holes added for padding.
>    Putting this in common code should reduce the risk of future
>    changes to the linker scripts not being propagated to MIPS (or any
>    other architecture that needs something like this).
> 
> 2) Align the MIPS swapper_pg_dir.
> 
> Since the initial use of the code is for MIPS, perhaps both parts
> could be merged by Ralf's tree (after collecting any Acked-bys).

Looks good to me but will wait a bit longer for comments and (N)Acks
before merging.

  Ralf
