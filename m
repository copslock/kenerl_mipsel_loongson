Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 03 Dec 2014 14:37:34 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:49768 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27008013AbaLCNhbsKGE6 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 3 Dec 2014 14:37:31 +0100
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.8/8.14.8) with ESMTP id sB3DbTwk016890;
        Wed, 3 Dec 2014 14:37:29 +0100
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.8/8.14.8/Submit) id sB3DbTgk016889;
        Wed, 3 Dec 2014 14:37:29 +0100
Date:   Wed, 3 Dec 2014 14:37:29 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Lars Persson <lars.persson@axis.com>,
        Jayachandran C <jchandra@broadcom.com>
Cc:     David Daney <ddaney.cavm@gmail.com>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
Subject: Re: [PATCH] MIPS: Remove race window in page fault handling
Message-ID: <20141203133729.GB16063@linux-mips.org>
References: <1401532566-22929-1-git-send-email-larper@axis.com>
 <538CAAA6.90509@gmail.com>
 <771471B8871B5044A6CA7CCD9C26EEE10117E31EC89D@xmail2.se.axis.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <771471B8871B5044A6CA7CCD9C26EEE10117E31EC89D@xmail2.se.axis.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44555
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

On Tue, Jun 03, 2014 at 12:29:17PM +0200, Lars Persson wrote:

> Good point. Would adding !cpu_has_ic_fills_f_dc as an extra condition in set_pte_at be sufficient to address your concern ?

Returning to this old thread ...

cpu_has_ic_fills_f_dc means a CPU's data cache does not need to be
written back to secondary cache or memory when instructions have been
updated in memory.  In other words a CPU can refill the I-cache from
the D-cache on an I-cache miss.

Only the Alchemy cores have this handy property.

The flag is also being set for XL? CPUs in

  arch/mips/include/asm/mach-netlogic/cpu-feature-overrides.h

but not anywhere in the probe code of arch/mips/mm/c-r4k.c which might
stil be correct - but it's at least a bit sloppy and suspicious so I'm
wondering if it's correct indeed.  Jayachandran?

  Ralf
