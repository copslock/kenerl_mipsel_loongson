Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 14 Aug 2012 14:37:20 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:46847 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S1903820Ab2HNMhQ (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 14 Aug 2012 14:37:16 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.5/8.14.4) with ESMTP id q7ECbEGa025612;
        Tue, 14 Aug 2012 14:37:14 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.5/8.14.5/Submit) id q7ECbDoF025609;
        Tue, 14 Aug 2012 14:37:13 +0200
Date:   Tue, 14 Aug 2012 14:37:13 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Joshua Kinard <kumba@gentoo.org>
Cc:     Linux MIPS List <linux-mips@linux-mips.org>
Subject: Re: [PATCH]: Improve atomic.h robustness
Message-ID: <20120814123713.GB17040@linux-mips.org>
References: <4FE7B86E.7030601@gentoo.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4FE7B86E.7030601@gentoo.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-archive-position: 34150
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

On Sun, Jun 24, 2012 at 09:01:34PM -0400, Joshua Kinard wrote:

> I've maintained this patch, originally from Thiemo Seufer in 2004, for a
> really long time, but I think it's time for it to get a look at for possible
> inclusion.  I have had no problems with it across various SGI systems over
> the years.
> 
> To quote the post here:
> http://www.linux-mips.org/archives/linux-mips/2004-12/msg00000.html
> 
> "the atomic functions use so far memory references for the inline
> assembler to access the semaphore. This can lead to additional
> instructions in the ll/sc loop, because newer compilers don't
> expand the memory reference any more but leave it to the assembler.
> 
> The appended patch uses registers instead, and makes the ll/sc
> arguments more explicit. In some cases it will lead also to better
> register scheduling because the register isn't bound to an output
> any more."

I have faint memories of having tried this myself and very ancient
compilers didn't like the + constraint in inline assembler; somewhat
less ancient compilers did generate slightly bigger code.  With gcc 4.7
I am getting exactly the same codesize as without your patch applied.
The patch shouldn't do anything to robustness but sureles makes the
inline assembler a bit more readable so I'm queueing this for the next
release.

Thanks,

  Ralf
