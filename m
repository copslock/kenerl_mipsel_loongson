Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 06 May 2012 09:04:41 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:38129 "EHLO
        localhost.localdomain" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903611Ab2EFHEd (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 6 May 2012 09:04:33 +0200
Date:   Sun, 6 May 2012 08:04:33 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@linux-mips.org>
To:     David Daney <ddaney.cavm@gmail.com>
cc:     Artem Bityutskiy <dedekind1@gmail.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        MIPS Mailing List <linux-mips@linux-mips.org>,
        MTD Maling List <linux-mtd@lists.infradead.org>
Subject: Re: [PATCH 1/2] MIPS: Kbuild: remove -Werror
In-Reply-To: <4F9AD14E.9060008@gmail.com>
Message-ID: <alpine.LFD.2.00.1205060754390.19691@eddie.linux-mips.org>
References: <1335534510-12573-1-git-send-email-dedekind1@gmail.com> <4F9AD14E.9060008@gmail.com>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-archive-position: 33167
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

On Fri, 27 Apr 2012, David Daney wrote:

> > MIPS build fails with the standard W=1 Kbuild switch with because of the
> > -Werror gcc switch.
> > 
> > This patch removes the gcc switch to make W=1 work. Mips is the only
> > architecture I know which does not build with W=1 and this upsets my aiaiai
> > scripts. And in general, you never know which warnings newer versions of gcc
> > will start emiting so having -Werror by default is not the best idea.
> > 
> > Signed-off-by: Artem Bityutskiy<artem.bityutskiy@linux.intel.com>
> 
> I think the warning messages are enough, we don't need to break things.

 I disagree.  People generally don't fix their broken code just because it 
triggers warnings.  The cases where GCC is genuinely confused are the 
minority -- and even if so, chances are the human reader of that code will 
also be.

  Maciej
