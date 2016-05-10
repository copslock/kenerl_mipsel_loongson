Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 10 May 2016 09:34:52 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:57432 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27028563AbcEJHesh2RXv (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 10 May 2016 09:34:48 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.15.2/8.14.8) with ESMTP id u4A7Ykbc017299;
        Tue, 10 May 2016 09:34:46 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.15.2/8.15.2/Submit) id u4A7YiYN017298;
        Tue, 10 May 2016 09:34:44 +0200
Date:   Tue, 10 May 2016 09:34:44 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     "Maciej W. Rozycki" <macro@imgtec.com>
Cc:     James Hogan <james.hogan@imgtec.com>,
        Paul Burton <paul.burton@imgtec.com>,
        Manuel Lauss <manuel.lauss@gmail.com>,
        "Jayachandran C." <jchandra@broadcom.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        linux-mips@linux-mips.org, kvm@vger.kernel.org
Subject: Re: [PATCH 0/7] MIPS: Add extended ASID support
Message-ID: <20160510073444.GA16402@linux-mips.org>
References: <1462541784-22128-1-git-send-email-james.hogan@imgtec.com>
 <20160509132315.GA28818@linux-mips.org>
 <alpine.DEB.2.00.1605091756520.6794@tp.orcam.me.uk>
 <20160509190442.GC23699@jhogan-linux.le.imgtec.org>
 <alpine.DEB.2.00.1605092041200.6794@tp.orcam.me.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1605092041200.6794@tp.orcam.me.uk>
User-Agent: Mutt/1.6.0 (2016-04-01)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53334
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

On Mon, May 09, 2016 at 08:56:51PM +0100, Maciej W. Rozycki wrote:

>  Yes, but these are not legacy architectures, are they?  Since you've got 
> bits set across Config registers you don't need to resort to poking at 
> other registers.  Although there are exceptions like PABITS and SEGBITS 
> (we ought to handle this one day actually, for correct unaligned access 
> emulation -- right now you get a repeated AdEL exception in emulation code 
> for what originally was an unaligned out of range kernel XKPHYS access, 
> making it a big pain to debug; I've had a hack for this since 2.4 days, 
> but it should be done properly).

Yeah, it's simply an implementation guided by the SISO principle.  Shit in,
shit out.  The issue you're having rarely hurts and if a simple hack can
solve it I'm in principle open to consider it for merging.

>  In the old days pretty much nothing was recorded in the single Config 
> register (very old chips didn't even have that -- you had to size caches 
> manually for example), but stuff could often be determined via other 
> means, sometimes (like probably here) without detailed checks on PRId.

Sizing the R4000/R4400 second level cache for example.  I'd call that
taking the RISC design principle to the edge :-)

  Ralf
