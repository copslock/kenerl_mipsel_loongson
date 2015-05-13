Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 13 May 2015 20:03:54 +0200 (CEST)
Received: (from localhost user: 'macro', uid#1010) by eddie.linux-mips.org
        with ESMTP id S27013148AbbEMSDv4ss2E (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 13 May 2015 20:03:51 +0200
Date:   Wed, 13 May 2015 19:03:51 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@linux-mips.org>
To:     James Hogan <james.hogan@imgtec.com>
cc:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        Paul Burton <paul.burton@imgtec.com>
Subject: Re: [PATCH 1/2] MIPS: malta-time: Don't switch RTC to BCD mode
In-Reply-To: <1431519473-24049-2-git-send-email-james.hogan@imgtec.com>
Message-ID: <alpine.LFD.2.11.1505131829580.1538@eddie.linux-mips.org>
References: <1431519473-24049-1-git-send-email-james.hogan@imgtec.com> <1431519473-24049-2-git-send-email-james.hogan@imgtec.com>
User-Agent: Alpine 2.11 (LFD 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47381
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

On Wed, 13 May 2015, James Hogan wrote:

> On Malta, the RTC is forced into binary coded decimal (BCD) mode during
> init, even if the bootloader put it into binary mode (as YAMON does).
> This can result in the RTC seconds being an invalid BCD (e.g.
> 0x1a..0x1f) for up to 6 seconds.

 Sigh.  No sooner I had fixed the breakage (with 636221b8 and a fat 
comment) it got put back (with a87ea88d).  Even though it's easily 
spotted as it breaks the system time (all the fields, including the date 
too, not only the seconds!) across a reboot due to YAMON eagerly 
switching the mode back.  And that'd be the first item I'd check when 
validating a change touching the RTC.

 Is there an actual need to reinitialise the RTC at all?  The RTC 
registers are readable, so the current configuration can be obtained, 
the RTC driver copes with any valid arrangement, so can any other code 
using the clock as a reference.

 YAMON OTOH is not as flexible, its clock management commands expect the 
format the monitor itself set the chip to, so I think the kernel has to 
respect that (just as it doesn't randomly flip bits in the RTC on x86 
PCs for example).

 So unless proven otherwise I'll ask for `init_rtc' to be dropped 
altogether and any changes required made to `estimate_frequencies' 
instead.  Which I believe you already did with 2/2.

  Maciej
