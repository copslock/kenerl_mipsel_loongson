Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 04 Apr 2015 23:57:01 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:33079 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27006155AbbDDV477BzL0 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sat, 4 Apr 2015 23:56:59 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.9/8.14.8) with ESMTP id t34Lv084016755;
        Sat, 4 Apr 2015 23:57:00 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.9/8.14.9/Submit) id t34Lv0lT016754;
        Sat, 4 Apr 2015 23:57:00 +0200
Date:   Sat, 4 Apr 2015 23:57:00 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     "Maciej W. Rozycki" <macro@linux-mips.org>
Cc:     linux-mips@linux-mips.org
Subject: Re: [PATCH 00/48] FPU and FP emulation clean-ups, fixes and feature
 updates
Message-ID: <20150404215700.GF20157@linux-mips.org>
References: <alpine.LFD.2.11.1504030054200.21028@eddie.linux-mips.org>
 <20150404200459.GE20157@linux-mips.org>
 <alpine.LFD.2.11.1504042142500.21028@eddie.linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.11.1504042142500.21028@eddie.linux-mips.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46781
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

On Sat, Apr 04, 2015 at 09:55:09PM +0100, Maciej W. Rozycki wrote:

>  Is there a better branch than master of ralf/linux.git to base patches 
> submitted against so as to save you from the need to sort out conflicts?  
> Let me know if you need help with any unobvious 3-way merge too.

That's a little harder this time.  Normally the top of upstream-sfr's
mips-for-linux-next is a good choice for the base but this time I have
another branch, 4.1-fp in upstream-sfr and I want to keep the merge
commit pulling this branch and the 4.0-fixes branch on top which lands
me in a bunch of conflicts.

The conflicts are in

    arch/mips/include/asm/asmmacro-32.h
    arch/mips/kernel/traps.c

I've tested a number of defconfigs and I'm pushing a new upstream-sfr
now.  I'd appreciate if you could test/review the result.

  Ralf
