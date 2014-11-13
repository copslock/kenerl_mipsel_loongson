Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 13 Nov 2014 12:13:52 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:51037 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27013600AbaKMLNuX3X50 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 13 Nov 2014 12:13:50 +0100
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.8/8.14.8) with ESMTP id sADBDnBG018641;
        Thu, 13 Nov 2014 12:13:49 +0100
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.8/8.14.8/Submit) id sADBDn3o018640;
        Thu, 13 Nov 2014 12:13:49 +0100
Date:   Thu, 13 Nov 2014 12:13:49 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     "Steven J. Hill" <Steven.Hill@imgtec.com>
Cc:     linux-mips@linux-mips.org
Subject: Re: [PATCH 02/11] MIPS: Revert fixrange_init() limiting to the
 FIXMAP region.
Message-ID: <20141113111349.GC13753@linux-mips.org>
References: <1415858743-24492-1-git-send-email-Steven.Hill@imgtec.com>
 <1415858743-24492-3-git-send-email-Steven.Hill@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1415858743-24492-3-git-send-email-Steven.Hill@imgtec.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44112
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

On Thu, Nov 13, 2014 at 12:05:34AM -0600, Steven J. Hill wrote:

> From: Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
> 
> This patch refactors commit 464fd83e841a16f4ea1325b33eb08170ef5cd1f4
> (MIPS: Limit fixrange_init() to the FIXMAP region) and correctly
> calculates the right length while taking into account page table
> alignment by PMD.

In that commit Kevin wrote:

    MIPS: Limit fixrange_init() to the FIXMAP region
    
    fixrange_init() allocates page tables for all addresses higher than
    FIXADDR_TOP.  On processors that override the default FIXADDR_TOP
    address of 0xfffe_0000, this can consume up to 4 pages (1 page per 4MB)
    for pgd's that are never used.

And that's all also reintroduced.  Think of bx 63xx which defines FIXADDR_TOP
as 0xff000000.  Blindly rounding up to 0 for the end address doesn't cut it.

  Ralf
