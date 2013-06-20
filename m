Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 20 Jun 2013 17:19:56 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:56183 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S6819540Ab3FTPTwCNx1f (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 20 Jun 2013 17:19:52 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.5/8.14.4) with ESMTP id r5KFJnMA000445;
        Thu, 20 Jun 2013 17:19:49 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.5/8.14.5/Submit) id r5KFJn3n000444;
        Thu, 20 Jun 2013 17:19:49 +0200
Date:   Thu, 20 Jun 2013 17:19:49 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Jayachandran C <jchandra@broadcom.com>
Cc:     linux-mips@linux-mips.org
Subject: Re: [PATCH UPDATED 3/4] MIPS: mm: Use scratch for PGD when
 !CONFIG_MIPS_PGD_C0_CONTEXT
Message-ID: <20130620151949.GA337@linux-mips.org>
References: <1370965298-29210-4-git-send-email-jchandra@broadcom.com>
 <1371559516-4862-1-git-send-email-jchandra@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1371559516-4862-1-git-send-email-jchandra@broadcom.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37060
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

On Tue, Jun 18, 2013 at 06:15:15PM +0530, Jayachandran C wrote:

> Allow usage of scratch register for current pgd even when
> MIPS_PGD_C0_CONTEXT is not configured. MIPS_PGD_C0_CONTEXT is set
> for 64r2 platforms to indicate availability of Xcontext for saving
> cpuid, thus freeing Context to be used for saving PGD. This option
> was also tied to using a scratch register for storing PGD.
> 
> This commit will allow usage of scratch register to store the current
> pgd if one can be allocated for the platform, even when
> MIPS_PGD_C0_CONTEXT is not set. The cpuid will be kept in the CP0
> Context register in this case.
> 
> The code to store the current pgd for the TLB miss handler is now
> generated in all cases. When scratch register is available, the PGD
> is also stored in the scratch register.

I also pulled this one again as it was causing to others.

  Ralf
