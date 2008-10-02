Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 02 Oct 2008 10:35:15 +0100 (BST)
Received: from ditditdahdahdah-dahditditditdit.dl5rb.org.uk ([217.169.26.26]:53895
	"EHLO ditditdahdahdah-dahdahdahditdit.dl5rb.org.uk")
	by ftp.linux-mips.org with ESMTP id S20340525AbYJBJfM (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 2 Oct 2008 10:35:12 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by ditditdahdahdah-dahdahdahditdit.dl5rb.org.uk (8.14.2/8.14.1) with ESMTP id m929ZA6Q019278;
	Thu, 2 Oct 2008 10:35:11 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.2/8.14.2/Submit) id m929ZALp019276;
	Thu, 2 Oct 2008 10:35:10 +0100
Date:	Thu, 2 Oct 2008 10:35:10 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	"Kevin D. Kissell" <kevink@paralogos.com>
Cc:	Linux MIPS Org <linux-mips@linux-mips.org>
Subject: Re: SMTC Patches [0 of 3]
Message-ID: <20081002093510.GA19177@linux-mips.org>
References: <48C6DC4C.5040208@paralogos.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <48C6DC4C.5040208@paralogos.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20672
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Sep 09, 2008 at 10:27:56PM +0200, Kevin D. Kissell wrote:
> From: "Kevin D. Kissell" <kevink@paralogos.com>
> Date: Tue, 09 Sep 2008 22:27:56 +0200
> To: Linux MIPS Org <linux-mips@linux-mips.org>
> Subject: SMTC Patches [0 of 3]
> Content-Type: text/plain; charset=ISO-8859-1; format=flowed
> 
> I've managed to steal enough time to rework the SMTC support
> for the MIPS 34K (and, I suppose 1004K) processors so that it
> works again near the head of the source tree.  This involved
> a complete rework of the clocking model to be compatible with
> new common timing event system, which finally enables "tickless"
> operation in SMTC, something it needed pretty badly.  I also
> solved the problem with using the "wait_irqoff" idle loop
> under SMTC.
>
> There are going to be three patches that will follow.  The
> first two are relatively localized fixes to problems with
> FPU affinity and with IPI replay that I came across in testing
> the new code.  The last is a pretty big patch, but it all
> pretty much hangs together and I couldn't see any sensible
> way to partition it.

I've folded patch 4/3 into 1/3 and backported everything, as far as
it seemed sensible.  One nit was that 2/3 breaks the build and 3/3 fixes
it again.  This sort of build breakage is not uncommon but frowned
uppon these days since it makes use of git bisect for debugging
impossible.

Thanks,

  Ralf
