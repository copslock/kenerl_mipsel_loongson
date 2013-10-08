Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 08 Oct 2013 14:39:02 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:39254 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S6832655Ab3JHMjAch0uZ (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 8 Oct 2013 14:39:00 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.7/8.14.4) with ESMTP id r98CcxbP029713;
        Tue, 8 Oct 2013 14:38:59 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.7/8.14.7/Submit) id r98CcxbI029712;
        Tue, 8 Oct 2013 14:38:59 +0200
Date:   Tue, 8 Oct 2013 14:38:59 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Markos Chandras <Markos.Chandras@imgtec.com>
Cc:     linux-mips@linux-mips.org,
        Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
Subject: Re: [PATCH] MIPS: Print correct PC in trace dump after NMI exception
Message-ID: <20131008123859.GK1615@linux-mips.org>
References: <1381232371-25017-1-git-send-email-markos.chandras@imgtec.com>
 <20131008121546.GI1615@linux-mips.org>
 <5253FB20.7050909@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5253FB20.7050909@imgtec.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38269
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

On Tue, Oct 08, 2013 at 01:31:28PM +0100, Markos Chandras wrote:

> >If you were afraid gas might use $1 expanding this macro instruction - no,
> >it won't.  A belt & suspenders approach might be to drop in a ".set noat";
> >it would make the assembler throw an error if should ever see the need to
> >use $1.
> >
> yeah i don't think the assembler would pick $1 in this case but we
> could add ".set noat" just to be safe i suppose.
> 
> Thanks for the review. Could you fix these problems for me or should
> i submit a new patch?

It's trivial enough so I'm going to do it.

The NMI handler btw. was already wrapped with .set push; .set noat; ...
.set pop.

  Ralf
