Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 08 Aug 2014 22:47:35 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:41248 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S6898485AbaHHUrPB-SxK (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 8 Aug 2014 22:47:15 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.8/8.14.8) with ESMTP id s78Kl65B006190;
        Fri, 8 Aug 2014 22:47:06 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.8/8.14.8/Submit) id s78Kl5fY006189;
        Fri, 8 Aug 2014 22:47:05 +0200
Date:   Fri, 8 Aug 2014 22:47:05 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     David Daney <ddaney.cavm@gmail.com>
Cc:     Lars Persson <lars.persson@axis.com>, linux-mips@linux-mips.org,
        Lars Persson <larper@axis.com>
Subject: Re: [PATCH v2] MIPS: Remove race window in page fault handling
Message-ID: <20140808204705.GH29898@linux-mips.org>
References: <1407505668-18547-1-git-send-email-larper@axis.com>
 <53E500E4.5020509@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <53E500E4.5020509@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 41912
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

On Fri, Aug 08, 2014 at 09:55:00AM -0700, David Daney wrote:

> >+static inline void set_pte_at(struct mm_struct *mm, unsigned long addr,
> >+	pte_t *ptep, pte_t pteval);
> >+
> 
> Is it possible to reorder the code such that this declaration is not
> necessary?

That's not as obvious as one might think initially.  set_pte_at needs
to be defined after set_pte but before clear_pte which is calling set_pte_at.

Of both set_pte and clear_pte there are two #ifdefd variants.

set_pte_at is a fairly small function only but it's invoked quite a few
times so I was a little concerned about the effect on I'm experimenting with
outlining set_pte_at entirely.  ip22_defconfig with the patch applied as
posted; this is the effect on code size.

  text    data     bss     dec     hex filename
3790118  175304   84544 4049966  3dcc2e vmlinux		as posted
3789062	 175304	  84544	4048910	 3dc80e	vmlinux		set_pte_at outlined

  Ralf
