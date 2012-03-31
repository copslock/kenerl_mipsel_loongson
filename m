Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 31 Mar 2012 22:44:18 +0200 (CEST)
Received: from e31.co.us.ibm.com ([32.97.110.149]:46904 "EHLO
        e31.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1903698Ab2CaUoF (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 31 Mar 2012 22:44:05 +0200
Received: from /spool/local
        by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-mips@linux-mips.org> from <paulmck@linux.vnet.ibm.com>;
        Sat, 31 Mar 2012 14:43:58 -0600
Received: from d03dlp01.boulder.ibm.com (9.17.202.177)
        by e31.co.us.ibm.com (192.168.1.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        Sat, 31 Mar 2012 14:43:44 -0600
Received: from d03relay03.boulder.ibm.com (d03relay03.boulder.ibm.com [9.17.195.228])
        by d03dlp01.boulder.ibm.com (Postfix) with ESMTP id 932581FF0048
        for <linux-mips@linux-mips.org>; Sat, 31 Mar 2012 14:43:43 -0600 (MDT)
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
        by d03relay03.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id q2VKhiIr186020
        for <linux-mips@linux-mips.org>; Sat, 31 Mar 2012 14:43:44 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
        by d03av01.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id q2VKhgrs020781
        for <linux-mips@linux-mips.org>; Sat, 31 Mar 2012 14:43:43 -0600
Received: from paulmck-ThinkPad-W500 (sig-9-49-152-53.mts.ibm.com [9.49.152.53])
        by d03av01.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVin) with ESMTP id q2VKhfwd020771;
        Sat, 31 Mar 2012 14:43:42 -0600
Received: by paulmck-ThinkPad-W500 (Postfix, from userid 1000)
        id C5519E4ABB; Sat, 31 Mar 2012 13:43:32 -0700 (PDT)
Date:   Sat, 31 Mar 2012 13:43:32 -0700
From:   "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To:     Randy Dunlap <rdunlap@xenotime.net>
Cc:     Linas Vepstas <linasvepstas@gmail.com>,
        linux-kernel@vger.kernel.org, linux-alpha@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        uclinux-dist-devel@blackfin.uclinux.org,
        linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-m32r@ml.linux-m32r.org, linux-m32r-ja@ml.linux-m32r.org,
        linux-mips@linux-mips.org, linux-am33-list@redhat.com,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org, tglx@linutronix.de,
        linux@arm.linux.org.uk, dhowells@redhat.com, jejb@parisc-linux.org,
        linux390@de.ibm.com, x86@kernel.org, cmetcalf@tilera.com
Subject: Re: [PATCH RFC] Simplify the Linux kernel by reducing its state space
Message-ID: <20120331204332.GH2450@linux.vnet.ibm.com>
Reply-To: paulmck@linux.vnet.ibm.com
References: <20120331163321.GA15809@linux.vnet.ibm.com>
 <20120331201500.GA27640@linas.org>
 <4F77681E.5010608@xenotime.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4F77681E.5010608@xenotime.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Content-Scanned: Fidelis XPS MAILER
x-cbid: 12033120-7282-0000-0000-000007D474E2
X-archive-position: 32843
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paulmck@linux.vnet.ibm.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

On Sat, Mar 31, 2012 at 01:25:02PM -0700, Randy Dunlap wrote:
> On 03/31/2012 01:15 PM, Linas Vepstas wrote:
> 
> > 
> > Hi,
> > 
> > I didn't actually try to compile the patch below; it didn't look like
> > C code so I wasn't sure what compiler to run it through.  I guess maybe
> > its python?  However, I'm very sure that the patches are completely
> > correct, because I read them, and I also know Paul.  And I've heard of
> > Thomas Gleixner.
> 
> 
> x86_64 defconfig has many build errors and warnings.  :(

I suggest removing the code containing the errors and warnings.  I bet
that the offending code is not needed when running with zero CPUs.

> back to my abacus.

;-)

							Thanx, Paul
