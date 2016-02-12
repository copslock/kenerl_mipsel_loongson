Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 12 Feb 2016 17:34:54 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:47082 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27012654AbcBLQewU7iLw (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 12 Feb 2016 17:34:52 +0100
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.15.2/8.14.8) with ESMTP id u1CGYmKB001787;
        Fri, 12 Feb 2016 17:34:48 +0100
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.15.2/8.15.2/Submit) id u1CGYlAk001786;
        Fri, 12 Feb 2016 17:34:47 +0100
Date:   Fri, 12 Feb 2016 17:34:47 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Paul Burton <paul.burton@imgtec.com>
Cc:     linux-mips@linux-mips.org,
        "Steven J. Hill" <Steven.Hill@imgtec.com>,
        Joshua Kinard <kumba@gentoo.org>, linux-kernel@vger.kernel.org,
        =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
        James Hogan <james.hogan@imgtec.com>,
        Markos Chandras <markos.chandras@imgtec.com>
Subject: Re: [PATCH] MIPS: tlb-r4k: panic if the MMU doesn't support PAGE_SIZE
Message-ID: <20160212163447.GA10828@linux-mips.org>
References: <1436803964-29820-1-git-send-email-paul.burton@imgtec.com>
 <20160210221049.GA26712@NP-P-BURTON>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20160210221049.GA26712@NP-P-BURTON>
User-Agent: Mutt/1.5.24 (2015-08-30)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52026
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

On Wed, Feb 10, 2016 at 02:10:49PM -0800, Paul Burton wrote:

> On Mon, Jul 13, 2015 at 05:12:44PM +0100, Paul Burton wrote:
> > After writing the appropriate mask to the cop0 PageMask register, read
> > the register back & check it matches what we want. If it doesn't then
> > the MMU does not support the page size the kernel is configured for and
> > we're better off bailing than continuing to do odd things with TLB
> > exceptions.
> > 
> > Signed-off-by: Paul Burton <paul.burton@imgtec.com>
> > ---
> 
> Hi Ralf,
> 
> This patch is marked as accepted in patchwork[1] but is not present in
> upstream. Did you lose it somehow? Could you please merge it?

No idea what went wrong but I (re-?)applied it.

  Ralf
