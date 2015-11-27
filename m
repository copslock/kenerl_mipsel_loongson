Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 27 Nov 2015 12:20:29 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:49726 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27006685AbbK0LU0zqhP2 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 27 Nov 2015 12:20:26 +0100
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.15.2/8.14.8) with ESMTP id tARBKQPn000817;
        Fri, 27 Nov 2015 12:20:26 +0100
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.15.2/8.15.2/Submit) id tARBKQO8000816;
        Fri, 27 Nov 2015 12:20:26 +0100
Date:   Fri, 27 Nov 2015 12:20:26 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Subject: Re: no-op delay loops
Message-ID: <20151127112025.GD20269@linux-mips.org>
References: <87si3rbz6p.fsf@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87si3rbz6p.fsf@rasmusvillemoes.dk>
User-Agent: Mutt/1.5.24 (2015-08-30)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50152
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

On Fri, Nov 27, 2015 at 09:53:50AM +0100, Rasmus Villemoes wrote:

> It seems that gcc happily compiles
> 
> for (i = 0; i < 1000000000; ++i) ;
> 
> into simply
> 
> i = 1000000000;
> 
> (which is then usually eliminated as a dead store). At least at -O2, and
> when i is not declared volatile. So it would seem that the loops at
> 
> arch/mips/pci/pci-rt2880.c:235
> arch/mips/pmcs-msp71xx/msp_setup.c:80
> arch/mips/sni/reset.c:35
> 
> actually don't do anything. (In the middle one, i is 'register', but
> that doesn't change anything.) Is mips compiled with some special flags
> that would make gcc actually emit code for the above?

Thanks for reporting!

GCC used to intentionally not eleminate empty loops.  This has changed a
while ago.  Using volatile for the loop variable will result in atrocious
code so should be avoided.

One problem of these open coded loops is that it's not obvious how much
delay was actually intended so when fixing this I will have to do a bit
of precission guessing ;-)

  Ralf
