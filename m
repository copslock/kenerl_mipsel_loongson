Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 10 Oct 2017 16:23:23 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:42784 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23993935AbdJJOXLis-oc (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 10 Oct 2017 16:23:11 +0200
Received: from h7.dl5rb.org.uk (localhost [127.0.0.1])
        by h7.dl5rb.org.uk (8.15.2/8.14.8) with ESMTP id v9AENAGN025144;
        Tue, 10 Oct 2017 16:23:10 +0200
Received: (from ralf@localhost)
        by h7.dl5rb.org.uk (8.15.2/8.15.2/Submit) id v9AEN6gs025140;
        Tue, 10 Oct 2017 16:23:06 +0200
Date:   Tue, 10 Oct 2017 16:23:06 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Joshua Kinard <kumba@gentoo.org>
Cc:     linux-mips@linux-mips.org
Subject: Re: Question regarding atomic ops
Message-ID: <20171010142306.GA24194@linux-mips.org>
References: <eb17f62d-c347-e470-f9cf-06b18a55481e@gentoo.org>
 <4f77107c-18ba-d549-c5f2-d52d0460377b@gentoo.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4f77107c-18ba-d549-c5f2-d52d0460377b@gentoo.org>
User-Agent: Mutt/1.9.1 (2017-09-22)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60355
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

On Mon, Oct 09, 2017 at 10:34:43PM -0400, Joshua Kinard wrote:

> On 10/09/2017 22:24, Joshua Kinard wrote:
> 
> [snip]
> 
> > This raises the question of why was the standard "kernel_uses_llsc" case
> > changed but not the R10000_LLSC_WAR case?  The changes seem like they would be
> > applicable to the older R10K CPUs regardless, since this is before a lot of the
> > code for the newer ISAs (R2+) was added.  I am getting a funny feeling that a
> > lot of these templates need to be re-written (maybe even in plain C, given
> > newer gcc's better intelligence) and other useful cleanups done.  I am not
> > fluent in MIPS asm enough, though, to know what to change.
> 
> Answered one of my own questions via this buried commit from ~2006/2007 that
> has a commit message, but no changed files:
> 
> https://git.linux-mips.org/cgit/ralf/linux.git/commit/arch/mips/include/asm/atomic.h?id=5999eca25c1fd4b9b9aca7833b04d10fe4bc877d
> 
> > [MIPS] Improve branch prediction in ll/sc atomic operations.
> > Now that finally all supported versions of binutils have functioning
> > support for .subsection use .subsection to tweak the branch prediction
> > 
> > I did not modify the R10000 errata variants because it seems unclear if
> > this will invalidate the workaround which actually relies on the cheesy
> > prediction of branch likely to cause a misspredict if the sc was
> > successful.
> > 
> > Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
> 
> Seems like that second paragraph is a ripe candidate for a comment block so
> this is better documented :)

Btw, I reasonably certain applying the change to the R10000 LL/SC workaround
versions as well would work.  But testing is difficult, even with hardware
at hand - and the other option asing a R10000 RTL designer is tricky about
20 years later!

  Ralf
