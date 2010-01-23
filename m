Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 23 Jan 2010 21:07:54 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:54444 "EHLO h5.dl5rb.org.uk"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S1492608Ab0AWUHv (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sat, 23 Jan 2010 21:07:51 +0100
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
        by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id o0NK7sBB010556;
        Sat, 23 Jan 2010 21:07:55 +0100
Received: (from ralf@localhost)
        by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id o0NK7r1R010555;
        Sat, 23 Jan 2010 21:07:53 +0100
Date:   Sat, 23 Jan 2010 21:07:53 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     David Daney <ddaney@caviumnetworks.com>
Cc:     linux-mips@linux-mips.org
Subject: Re: [PATCH 1/2] MIPS: Remove probe_tlb().
Message-ID: <20100123200753.GA3251@linux-mips.org>
References: <1264200075-4992-1-git-send-email-ddaney@caviumnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1264200075-4992-1-git-send-email-ddaney@caviumnetworks.com>
User-Agent: Mutt/1.5.20 (2009-08-17)
X-archive-position: 25643
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 15411

On Fri, Jan 22, 2010 at 02:41:14PM -0800, David Daney wrote:

> The function probe_tlb() only does anything for processors that are
> not PRID_COMP_LEGACY.  This is precisely the set of processors for
> which decode_configs() is called to do identical tlbsize probing
> calculations.  Therefore probe_tlb() is completely redundant and may
> be removed.
> 
> Signed-off-by: David Daney <ddaney@caviumnetworks.com>

Queued for 2.6.34.  Nice cleanup - it also gets rid of another SMTC
dependency.

Thanks,

  Ralf
