Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 29 Apr 2015 11:49:23 +0200 (CEST)
Received: (from localhost user: 'macro', uid#1010) by eddie.linux-mips.org
        with ESMTP id S27011967AbbD2JtVpoNH2 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 29 Apr 2015 11:49:21 +0200
Date:   Wed, 29 Apr 2015 10:49:21 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@linux-mips.org>
To:     James Hogan <james.hogan@imgtec.com>
cc:     Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>,
        linux-mips@linux-mips.org, markos.chandras@imgtec.com,
        Ralf Baechle <ralf@linux-mips.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MIPS64: R6: R2 emulation bugfix
In-Reply-To: <5540A1BF.7060408@imgtec.com>
Message-ID: <alpine.LFD.2.11.1504291025430.17786@eddie.linux-mips.org>
References: <20150428195335.11229.4516.stgit@ubuntu-yegoshin> <5540A1BF.7060408@imgtec.com>
User-Agent: Alpine 2.11 (LFD 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47161
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

On Wed, 29 Apr 2015, James Hogan wrote:

> > Error recovery pointers for fixups was improperly set as ".word"
> > which is unsuitable for MIPS64.
> > 
> > Replaced by __stringify(PTR)
> 
> Every other case of this sort of thing uses STR(PTR) (or __UA_ADDR in
> uaccess.h). Can we stick to STR(PTR) for consistency please?

 Or __PA_ADDR in paccess.h.

 I have mixed feelings, the reason for __stringify being absent is the 
macro being generic and more recently added than pieces of code that use 
STR, e.g. unaligned.c that has been there since forever.  And we do use 
__stringify in many other cases.

 On the other hand STR is short and sweet, unlike __stringify.

 So how about adding a macro like __STR_PTR that expands to 
__stringify(PTR) and converting all the places throughout our port 
(including ones currently using __UA_ADDR/__PA_ADDR) to use the new macro?

 Leonid's bug fix will need to go in first of course.

  Maciej
