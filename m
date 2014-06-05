Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 05 Jun 2014 23:38:08 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:55178 "EHLO
        localhost.localdomain" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6854763AbaFEViFmZRFv (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 5 Jun 2014 23:38:05 +0200
Date:   Thu, 5 Jun 2014 22:38:05 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@linux-mips.org>
To:     Ralf Baechle <ralf@linux-mips.org>
cc:     David Daney <ddaney.cavm@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>, linux-mips@linux-mips.org
Subject: Re: gcc warning in my trace_benchmark() code
In-Reply-To: <20140605210718.GV17197@linux-mips.org>
Message-ID: <alpine.LFD.2.11.1406052214320.18344@eddie.linux-mips.org>
References: <20140605121204.18ee5f2d@gandalf.local.home> <5390A4F0.3000601@gmail.com> <20140605210718.GV17197@linux-mips.org>
User-Agent: Alpine 2.11 (LFD 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 40446
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

On Thu, 5 Jun 2014, Ralf Baechle wrote:

> > Ralf:  As a side note, while looking at
> > arch/mips/include/asm/div64.h, I saw that the implementation of
> > __div64_32 in that file will be unused, and is also completely
> > broken due to the first parameter never being used.
> 
> Seems I broke c21004cd5b4cb7d479514d470a62366e8307412c "MIPS: Rewrite
> <asm/div64.h> to work with gcc 4.4.0."  Took only five years until
> somebody noticed ...

 Well, it's not really possible to track all the breakage introduced 
unless at least a warning is spat for some config.  Which is why I think 
it's a good idea to have all non-trivial changes put through a review 
process or at least posted to the relevant mailing list.

 This change didn't appear anywhere, only the commit log message was 
posted, so there was no chance to spot the damage, unless there was 
someone who actively studied changes made to the tree.

  Maciej
