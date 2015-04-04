Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 04 Apr 2015 22:55:11 +0200 (CEST)
Received: (from localhost user: 'macro', uid#1010) by eddie.linux-mips.org
        with ESMTP id S27009427AbbDDUzJpWl4t (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 4 Apr 2015 22:55:09 +0200
Date:   Sat, 4 Apr 2015 21:55:09 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@linux-mips.org>
To:     Ralf Baechle <ralf@linux-mips.org>
cc:     linux-mips@linux-mips.org
Subject: Re: [PATCH 00/48] FPU and FP emulation clean-ups, fixes and feature
 updates
In-Reply-To: <20150404200459.GE20157@linux-mips.org>
Message-ID: <alpine.LFD.2.11.1504042142500.21028@eddie.linux-mips.org>
References: <alpine.LFD.2.11.1504030054200.21028@eddie.linux-mips.org> <20150404200459.GE20157@linux-mips.org>
User-Agent: Alpine 2.11 (LFD 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46780
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

On Sat, 4 Apr 2015, Ralf Baechle wrote:

> >  Clean-ups come first as they should be completely uncontroversial, 
> > followed by restructuring, bug fixes and new features.
> 
> It would have been nice if the bug fixes or at least those relevant to
> 4.0 and older were at the beginning to reduce issue when applying them
> to the 4.0-fixes and possibly -stable branches.

 Good point, I will keep it in mind in the future.  I think there's 
actually little if any overlap here though, you should be able to ignore 
comment and formatting changes when doing any backports and the rest 
should just apply right away.

 I can send you a pre-r6 version of the relevant patches too if that would 
help -- I think there are 3 or 4 that I had to rework while rebasing from 
3.19 to 4.0.

> I applied your patches on top of my working branch and ran into a number
> of conflicts.  Will push the result out as soon as I'm done with the
> conflict resolution.

 Great, thanks!

 Is there a better branch than master of ralf/linux.git to base patches 
submitted against so as to save you from the need to sort out conflicts?  
Let me know if you need help with any unobvious 3-way merge too.

  Maciej
