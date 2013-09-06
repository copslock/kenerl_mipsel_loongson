Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 06 Sep 2013 10:00:32 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:42312 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S6817548Ab3IFIA3xDU89 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 6 Sep 2013 10:00:29 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.5/8.14.4) with ESMTP id r8680QcW026782;
        Fri, 6 Sep 2013 10:00:26 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.5/8.14.5/Submit) id r8680OMP026781;
        Fri, 6 Sep 2013 10:00:24 +0200
Date:   Fri, 6 Sep 2013 10:00:24 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     David Daney <ddaney.cavm@gmail.com>
Cc:     Prem Mallappa <prem.mallappa@gmail.com>,
        linux-mips <linux-mips@linux-mips.org>,
        Prem Mallappa <pmallappa@caviumnetworks.com>
Subject: Re: [PATCH v2 2/2] MIPS: KEXEC: Fixes Random crashes while loading
 crashkernel
Message-ID: <20130906080023.GD11592@linux-mips.org>
References: <1378317384-9923-1-git-send-email-pmallappa@caviumnetworks.com>
 <20130905181222.GC11592@linux-mips.org>
 <5228CDEF.4010609@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5228CDEF.4010609@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37772
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

On Thu, Sep 05, 2013 at 11:31:11AM -0700, David Daney wrote:

> >Prem,
> >
> >I only see patch 2/2.  I wonder, has 1/2 been lost in transit or is there
> >only the 2/2 patch?
> >
> 
> V1 of 1/2 didn't need revision, so it can be applied as is:
> 
> http://patchwork.linux-mips.org/patch/5786/

I've done some cosmetic changes.  Formatting with tabs, as per CodingStyle
use

	/*
	 *
	 */

style comments, not

	/*
	*
	*/

And finally use beqz rather than beq $reg, zero.  Anyway, Prem, thanks
for debugging this & patch applied!

  Ralf
