Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 23 May 2014 15:17:32 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:60648 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S6855635AbaEWNRaOAC24 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 23 May 2014 15:17:30 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.7/8.14.4) with ESMTP id s4NDHLJT002520;
        Fri, 23 May 2014 15:17:21 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.7/8.14.7/Submit) id s4NDHL62002517;
        Fri, 23 May 2014 15:17:21 +0200
Date:   Fri, 23 May 2014 15:17:21 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Alex Smith <alex.smith@imgtec.com>
Cc:     linux-mips@linux-mips.org
Subject: Re: [PATCH mips-for-linux-next] MIPS: math-emu: Regression fixes
Message-ID: <20140523131721.GE17197@linux-mips.org>
References: <1400849364-7077-1-git-send-email-alex.smith@imgtec.com>
 <20140523125842.GC334@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20140523125842.GC334@linux-mips.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 40256
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

On Fri, May 23, 2014 at 02:58:42PM +0200, Ralf Baechle wrote:

> > Fix some errors introduced by commit e2efc0ab3a ("MIPS: math-emu:
> > Remove most ifdefery."), which result in incorrect behaviour of the
> > FPU emulator.
> > 
> > Signed-off-by: Alex Smith <alex.smith@imgtec.com>
> > ---
> > Ralf, the above commit in mips-for-linux-next causes a regression
> > which this patch fixes (the regression I was seeing is fixed by the
> > last change, but I also noticed a couple of incorrect ISA level
> > checks which I fixed up as well). Could you squash this into that
> > commit?

Seems your patch was not against e2efc0ab3a but top of tree which
resulted in rejects for the first two segments.  Just in case you
want to look over them, the new commit id of e2efc0ab3a is now
08a07904e182895e1205f399465a3d622c0115b8 and the other patch which
was affected is 3f7cac416b5e62d37aa693538729c6c23e9b938b [MIPS: math-emu:
Cleanup coding style.]

Thanks!

  Ralf
