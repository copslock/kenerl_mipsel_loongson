Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 05 Jun 2015 23:18:44 +0200 (CEST)
Received: (from localhost user: 'macro', uid#1010) by eddie.linux-mips.org
        with ESMTP id S27007514AbbFEVSllIQfA (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 5 Jun 2015 23:18:41 +0200
Date:   Fri, 5 Jun 2015 22:18:41 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@linux-mips.org>
To:     Ralf Baechle <ralf@linux-mips.org>
cc:     Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>,
        linux-mips@linux-mips.org, benh@kernel.crashing.org,
        will.deacon@arm.com, linux-kernel@vger.kernel.org,
        markos.chandras@imgtec.com, Steven.Hill@imgtec.com,
        alexander.h.duyck@redhat.com,
        "David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH 1/3] MIPS: R6: Use lightweight SYNC instruction in smp_*
 memory barriers
In-Reply-To: <20150605131046.GD26432@linux-mips.org>
Message-ID: <alpine.LFD.2.11.1506052209520.7979@eddie.linux-mips.org>
References: <20150602000818.6668.76632.stgit@ubuntu-yegoshin> <20150602000934.6668.43645.stgit@ubuntu-yegoshin> <20150605131046.GD26432@linux-mips.org>
User-Agent: Alpine 2.11 (LFD 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47890
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

On Fri, 5 Jun 2015, Ralf Baechle wrote:

> do you have an R4000 / R4600 / R5000 / R7000 / SiByte system at hand to
> test this?

 I should be able to check R4400 (that is virtually the same as R4000) 
next week or so.  As to SiByte -- not before next month I'm afraid.  I 
don't have access to any of the other processors you named.  You may 
want to find a better person if you want to accept this change soon.

  Maciej
