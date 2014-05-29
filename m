Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 29 May 2014 17:02:33 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:56819 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S6822093AbaE2PCaK2Vph (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 29 May 2014 17:02:30 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.7/8.14.4) with ESMTP id s4TF2TqU003394;
        Thu, 29 May 2014 17:02:29 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.7/8.14.7/Submit) id s4TF2Rj9003393;
        Thu, 29 May 2014 17:02:27 +0200
Date:   Thu, 29 May 2014 17:02:27 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Paul Bolle <pebolle@tiscali.nl>
Cc:     linux-mips@linux-mips.org
Subject: Re: next-20140529: CONFIG_MIPS_MT_SMTC
Message-ID: <20140529150227.GH5157@linux-mips.org>
References: <1401361928.6186.48.camel@x220>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1401361928.6186.48.camel@x220>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 40356
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

On Thu, May 29, 2014 at 01:12:08PM +0200, Paul Bolle wrote:

> Kconfig symbol MIPS_MT_SMTC was removed in next-20140526, in commit
> 633648c5ad3 ("MIPS: MT: Remove SMTC support").
> 
> A few references to its macro popped up again in next-20140529. These
> references can be traced back to commits ae4ce45419f9 ("MIPS: traps: Add
> CPU PM callback for trap configuration") and 74e91335190c ("MIPS: PM:
> Implement PM helper macros"). And those commits were merged in commit
> 7b2e5b89e488 ("Merge branch 'wip-mips-pm' of
> https://github.com/paulburton/linux into mips-for-linux-next"). Now I'm
> guessing that those references to CONFIG_MIPS_MT_SMTC didn't generate
> merge conflicts and therefor went unnoticed.
> 
> The trivial solution here is to remove all code hidden behind those
> references. Would that solution be correct?

Yes.  I did the fix up in the merge commit.

Thanks,

  Ralf
