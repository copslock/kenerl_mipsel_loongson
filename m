Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 14 Apr 2016 23:40:07 +0200 (CEST)
Received: from e36.co.us.ibm.com ([32.97.110.154]:37429 "EHLO
        e36.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27026494AbcDNVkBFC5ww (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 14 Apr 2016 23:40:01 +0200
Received: from localhost
        by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-mips@linux-mips.org> from <paulmck@linux.vnet.ibm.com>;
        Thu, 14 Apr 2016 15:39:54 -0600
Received: from d03dlp01.boulder.ibm.com (9.17.202.177)
        by e36.co.us.ibm.com (192.168.1.136) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        Thu, 14 Apr 2016 15:39:52 -0600
X-IBM-Helo: d03dlp01.boulder.ibm.com
X-IBM-MailFrom: paulmck@linux.vnet.ibm.com
X-IBM-RcptTo: linux-mips@linux-mips.org;ralf@linux-mips.org
Received: from b01cxnp23034.gho.pok.ibm.com (b01cxnp23034.gho.pok.ibm.com [9.57.198.29])
        by d03dlp01.boulder.ibm.com (Postfix) with ESMTP id AA11F1FF0021;
        Thu, 14 Apr 2016 15:28:00 -0600 (MDT)
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
        by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id u3ELdpDX34275570;
        Thu, 14 Apr 2016 21:39:52 GMT
Received: from d01av01.pok.ibm.com (localhost [127.0.0.1])
        by d01av01.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id u3ELdmBg007590;
        Thu, 14 Apr 2016 17:39:51 -0400
Received: from paulmck-ThinkPad-W541 ([9.70.82.191])
        by d01av01.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVin) with ESMTP id u3ELdm73007549;
        Thu, 14 Apr 2016 17:39:48 -0400
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id ACD8216C2AF6; Thu, 14 Apr 2016 14:40:15 -0700 (PDT)
Date:   Thu, 14 Apr 2016 14:40:15 -0700
From:   "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Will Deacon <will.deacon@arm.com>,
        Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        linux-arch@vger.kernel.org,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Russell King - ARM Linux <linux@arm.linux.org.uk>,
        virtualization@lists.linux-foundation.org,
        Stefano Stabellini <stefano.stabellini@eu.citrix.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@elte.hu>, "H. Peter Anvin" <hpa@zytor.com>,
        Joe Perches <joe@perches.com>,
        David Miller <davem@davemloft.net>, linux-ia64@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-metag@vger.kernel.org, linux-mips@linux-mips.org,
        x86@kernel.org, user-mode-linux-devel@lists.sourceforge.net,
        adi-buildroot-devel@lists.sourceforge.net,
        linux-sh@vger.kernel.org, linux-xtensa@linux-xtensa.org,
        xen-devel@lists.xenproject.org, Ralf Baechle <ralf@linux-mips.org>,
        Ingo Molnar <mingo@kernel.org>, ddaney.cavm@gmail.com,
        james.hogan@imgtec.com, Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH] documentation: Add disclaimer
Message-ID: <20160414214015.GA31866@linux.vnet.ibm.com>
Reply-To: paulmck@linux.vnet.ibm.com
References: <20160114120445.GB15828@arm.com>
 <56980145.5030901@imgtec.com>
 <20160114204827.GE3818@linux.vnet.ibm.com>
 <56981212.7050301@imgtec.com>
 <20160114222046.GH3818@linux.vnet.ibm.com>
 <20160126102402.GE6357@twins.programming.kicks-ass.net>
 <20160126103200.GI6375@twins.programming.kicks-ass.net>
 <20160126110053.GA21553@arm.com>
 <20160126201143.GV4503@linux.vnet.ibm.com>
 <20160127083546.GJ6357@twins.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20160127083546.GJ6357@twins.programming.kicks-ass.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-MML: disable
X-Content-Scanned: Fidelis XPS MAILER
x-cbid: 16041421-0021-0000-0000-000038A34974
Return-Path: <paulmck@linux.vnet.ibm.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52986
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paulmck@linux.vnet.ibm.com
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

On Wed, Jan 27, 2016 at 09:35:46AM +0100, Peter Zijlstra wrote:
> On Tue, Jan 26, 2016 at 12:11:43PM -0800, Paul E. McKenney wrote:
> > So Peter, would you like to update your patch to include yourself
> > and Will as authors?
> 
> Sure, here goes.
> 
> ---
> Subject: documentation: Add disclaimer
> 
> It appears people are reading this document as a requirements list for
> building hardware. This is not the intent of this document. Nor is it
> particularly suited for this purpose.
> 
> The primary purpose of this document is our collective attempt to define
> a set of primitives that (hopefully) allow us to write correct code on
> the myriad of SMP platforms Linux supports.
> 
> Its a definite work in progress as our understanding of these platforms,
> and memory ordering in general, progresses.
> 
> Nor does being mentioned in this document mean we think its a
> particularly good idea; the data dependency barrier required by Alpha
> being a prime example. Yes we have it, no you're insane to require it
> when building new hardware.
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>

Rather belatedly queued and pushed to -rcu, apologies for the delay.
One minor edit noted below.

							Thanx, Paul

> ---
>  Documentation/memory-barriers.txt | 18 +++++++++++++++++-
>  1 file changed, 17 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/memory-barriers.txt b/Documentation/memory-barriers.txt
> index a61be39c7b51..98626125f484 100644
> --- a/Documentation/memory-barriers.txt
> +++ b/Documentation/memory-barriers.txt
> @@ -4,8 +4,24 @@
> 
>  By: David Howells <dhowells@redhat.com>
>      Paul E. McKenney <paulmck@linux.vnet.ibm.com>
> +    Will Deacon <will.deacon@arm.com>
> +    Peter Zijlstra <peterz@infradead.org>
> 
> -Contents:
> +==========
> +DISCLAIMER
> +==========
> +
> +This document is not a specification; it is intentionally (for the sake of
> +brevity) and unintentionally (due to being human) incomplete. This document is
> +meant as a guide to using the various memory barriers provided by Linux, but
> +in case of any doubt (and there are many) please ask.
> +
> +I repeat, this document is not a specification of what Linux expects from

s/I/To/ because there is more than one author.

> +hardware.
> +
> +========
> +CONTENTS
> +========
> 
>   (*) Abstract memory access model.
> 
> 
