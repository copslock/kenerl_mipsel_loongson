Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 10 May 2016 10:54:13 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:33954 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27028592AbcEJIyKjveW- (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 10 May 2016 10:54:10 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.15.2/8.14.8) with ESMTP id u4A8s9Xi018920;
        Tue, 10 May 2016 10:54:09 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.15.2/8.15.2/Submit) id u4A8s6nN018919;
        Tue, 10 May 2016 10:54:06 +0200
Date:   Tue, 10 May 2016 10:54:06 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Paul Burton <paul.burton@imgtec.com>
Cc:     linux-mips@linux-mips.org, "Maciej W. Rozycki" <macro@imgtec.com>,
        linux-kernel@vger.kernel.org, James Hogan <james.hogan@imgtec.com>
Subject: Re: [PATCH 01/11] MIPS: math-emu: Fix BC1{EQ,NE}Z emulation
Message-ID: <20160510085405.GE16402@linux-mips.org>
References: <1461243895-30371-1-git-send-email-paul.burton@imgtec.com>
 <1461243895-30371-2-git-send-email-paul.burton@imgtec.com>
 <20160510080940.GD16402@linux-mips.org>
 <20160510084315.GA17928@NP-P-BURTON>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20160510084315.GA17928@NP-P-BURTON>
User-Agent: Mutt/1.6.0 (2016-04-01)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53338
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

On Tue, May 10, 2016 at 09:43:15AM +0100, Paul Burton wrote:

> > > The conditions for branching when emulating the BC1EQZ & BC1NEZ
> > > instructions were backwards, leading to each of those instructions being
> > > treated as the other. Fix this by reversing the conditions, and clear up
> > > the code a little for readability & checkpatch.
> > > 
> > > Fixes: c909ca718e8f ("MIPS: math-emu: Emulate missing BC1{EQ,NE}Z instructions")
> > > Signed-off-by: Paul Burton <paul.burton@imgtec.com>
> > > Reviewed-by: James Hogan <james.hogan@imgtec.com>
> > 
> > Patch ok - but you may want to take Markos off the cc list.  Or iff he's
> > still interested, is there any new address for him to use instead?
> > 
> >   Ralf
> 
> Hi Ralf,
> 
> It's a case of automated tooling cc'ing people from relevant git
> history, without the knowledge that the email address is no longer
> valid. I'll see if I can get it to filter him out next time.

I was guessing so - but hoping there was an updated address for him.
Changing the email address in the commit messages of all pending patches
is one of the easier tricks to do :)

  Ralf
