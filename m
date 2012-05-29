Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 29 May 2012 12:48:34 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:59322 "EHLO
        localhost.localdomain" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903545Ab2E2Ks1 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 29 May 2012 12:48:27 +0200
Date:   Tue, 29 May 2012 11:48:27 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@linux-mips.org>
To:     Ralf Baechle <ralf@linux-mips.org>
cc:     "Steven J. Hill" <sjhill@mips.com>, linux-mips@linux-mips.org,
        Douglas Leung <douglas@mips.com>
Subject: Re: [PATCH] MIPS: Add support for the MIPS32 4Kc family I/D
 caches.
In-Reply-To: <20120529084831.GC9944@linux-mips.org>
Message-ID: <alpine.LFD.2.00.1205291124570.3701@eddie.linux-mips.org>
References: <1337614412-29035-1-git-send-email-sjhill@mips.com> <20120522173245.GB5884@linux-mips.org> <alpine.LFD.2.00.1205270312110.3701@eddie.linux-mips.org> <20120529084831.GC9944@linux-mips.org>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-archive-position: 33475
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
Return-Path: <linux-mips-bounce@linux-mips.org>

On Tue, 29 May 2012, Ralf Baechle wrote:

> >  It was not a bug, or at least not an active one.  The new encoding was 
> > only added with revision 3 of the architecture or thereabouts, so not so 
> > long ago.  It used to be reserved previously, so we just handled it 
> > arbitrarily (though perhaps we should have panicked instead on 
> > encountering it indeed).
> 
> The patch at least was applicable to all 2.4 and 2.6 branches ...

 That you could have backported the change to old code doesn't mean the 
code was buggy at the time it was written.  It only became buggy as the 
environment changed.

 I have now double-checked my resources and according to the revision 
history of the architecture spec, the new encoding was only added with 
revision 3.00 of the spec: "Added encoding (0x7) for 32 sets for one cache 
way." that was dated March 2010 (my copy of revision 2.80 certainly does 
not list it and 3.05 does; I don't have the exact 3.00 revision 
unfortunately).  Up until then 64 was the smallest number of ways 
supported (and 7 was listed as a reserved encoding, just as when the code 
you've just patched was written).

 Linux 2.6.33 was released in February 2010 and 2.6.34 in May.  So 
anything before 2.6.34 was never buggy, and certainly none of 2.4 kernels.  

 You now have the answer to your concern as to how long we survived with 
this bug too: 2 years and 2 months.  Not too bad. ;)

 I still wonder why the 4Kc is mentioned in this context, this is a MIPS32 
revision 1 architecture chip, so revision 3 cannot apply to it anyway, 
hmm...

  Maciej
