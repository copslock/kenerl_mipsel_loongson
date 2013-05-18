Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 19 May 2013 01:25:56 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:48337 "EHLO
        localhost.localdomain" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6825737Ab3ERXZvWIKu8 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 19 May 2013 01:25:51 +0200
Date:   Sun, 19 May 2013 00:25:51 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@linux-mips.org>
To:     David Daney <ddaney.cavm@gmail.com>
cc:     "Steven J. Hill" <sjhill@realitydiluted.com>,
        linux-mips@linux-mips.org
Subject: Re: [PATCH v99,11/13] MIPS: microMIPS: Optimise 'strncpy' core
 library function.
In-Reply-To: <518A7D40.1060502@gmail.com>
Message-ID: <alpine.LFD.2.03.1305190022040.10753@linux-mips.org>
References: <1354856737-28678-1-git-send-email-sjhill@mips.com> <1354856737-28678-12-git-send-email-sjhill@mips.com> <518987BD.7030900@gmail.com> <5189C41D.3000005@realitydiluted.com> <518A7D40.1060502@gmail.com>
User-Agent: Alpine 2.03 (LFD 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36454
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
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

On Wed, 8 May 2013, David Daney wrote:

> > > You don't really explain how the change helps optimization either.
> > > 
> > The exercise is left to the reader. Build a microMIPS kernel yourself and
> > figure it out.
> 
> This isn't some sort of programming text book.  Your job in the change log
> (and the mailing list) isn't to force us to learn by doing a lot of
> independent analysis of the code.  Instead I would prefer a concise
> explanation of why the change is beneficial.
> 
> You are dumping a lot of new code into the kernel.  That is fine, but you
> could consider making the process easier by improving the quality of the
> changelogs  that accompany it.

 I concur, it's the contributor's responsibility to make the reviewers' 
work as easy as possible and to convince them that the change offered is 
both technically correct and desired for inclusion.

  Maciej
