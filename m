Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 11 Nov 2011 14:49:14 +0100 (CET)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:58439 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S1903972Ab1KKNtI (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 11 Nov 2011 14:49:08 +0100
Received: from duck.linux-mips.net (duck.linux-mips.net [127.0.0.1])
        by duck.linux-mips.net (8.14.4/8.14.4) with ESMTP id pABDn7uJ013849;
        Fri, 11 Nov 2011 13:49:07 GMT
Received: (from ralf@localhost)
        by duck.linux-mips.net (8.14.4/8.14.4/Submit) id pABDn60a013843;
        Fri, 11 Nov 2011 13:49:06 GMT
Date:   Fri, 11 Nov 2011 13:49:06 +0000
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Hillf Danton <dhillf@gmail.com>
Cc:     linux-mips@linux-mips.org,
        "Jayachandran C." <jayachandranc@netlogicmicro.com>
Subject: Re: [PATCH 12/12] MIPS: Netlogic: Mark Netlogic chips as SMT capable
Message-ID: <20111111134906.GA12771@linux-mips.org>
References: <cover.1321010998.git.jayachandranc@netlogicmicro.com>
 <7a1a9bad5b110e931f1662ebaae4c0164d4dcc84.1321011002.git.jayachandranc@netlogicmicro.com>
 <20111111125436.GD28303@linux-mips.org>
 <CAJd=RBA6OBq9PucheeAmzcphPRMPyDdwOOKQuQh7Lq7p37-g4A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJd=RBA6OBq9PucheeAmzcphPRMPyDdwOOKQuQh7Lq7p37-g4A@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-archive-position: 31561
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 10301

On Fri, Nov 11, 2011 at 09:39:00PM +0800, Hillf Danton wrote:

> The patch was delivered by me, and reprepared under ideas and comments from
> you and Jayachandran, thanks. It was fine tuned, and SOB, by Jayachandran, and
> included in this patchset, which is far beyond my capability, for supporting
> Netlogic chips. And please reconsider the patchset.

This was just a comment on the mechanics of sending patches, not a review
of the patch itself - in fact I think it's fine.

What seems to have happened is that Jayachandran prepared the patches
with git-format-patch, then sent them out using mutt -H, not as the
authors of git had intended using git-send-email.  Git-send-email
puts the sender's email address into the from header and inserts a From:
into the first line of the body, where needed.

On the receiving side it doesn't change a thing - the patch would have
looked exactly the same after being applied to git but as elaborated
before, there are other problems.

  Ralf
