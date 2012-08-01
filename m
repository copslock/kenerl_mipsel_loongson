Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 01 Aug 2012 18:59:48 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:56353 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S1903828Ab2HAQ7l (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 1 Aug 2012 18:59:41 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.5/8.14.4) with ESMTP id q71GxeUA010383;
        Wed, 1 Aug 2012 18:59:40 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.5/8.14.5/Submit) id q71Gxda8010382;
        Wed, 1 Aug 2012 18:59:39 +0200
Date:   Wed, 1 Aug 2012 18:59:39 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     "Steven J. Hill" <sjhill@mips.com>
Cc:     linux-mips@linux-mips.org
Subject: Re: [PATCH] MIPS: Add detection of DSP ASE Revision 2.
Message-ID: <20120801165938.GA8468@linux-mips.org>
References: <1343165994-1648-1-git-send-email-sjhill@mips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1343165994-1648-1-git-send-email-sjhill@mips.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-archive-position: 34016
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

On Tue, Jul 24, 2012 at 04:39:54PM -0500, Steven J. Hill wrote:

>  arch/mips/include/asm/cpu-features.h | 4 ++++
>  arch/mips/include/asm/cpu.h          | 1 +
>  arch/mips/include/asm/mipsregs.h     | 1 +
>  arch/mips/kernel/cpu-probe.c         | 6 ++++--
>  arch/mips/kernel/proc.c              | 3 ++-
>  5 files changed, 12 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/mips/include/asm/cpu-features.h b/arch/mips/include/asm/cpu-features.h
> index 98bee29..bba9398 100644

This patch causes rejects and it appears not to have been generated against
the linux-mips.git or linux-next tree so no surprise.

  Ralf
