Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 04 Jun 2004 01:52:55 +0100 (BST)
Received: from p508B7B0E.dip.t-dialin.net ([IPv6:::ffff:80.139.123.14]:6202
	"EHLO mail.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225997AbUFDAuD>; Fri, 4 Jun 2004 01:50:03 +0100
Received: from fluff.linux-mips.net (fluff.linux-mips.net [127.0.0.1])
	by mail.linux-mips.net (8.12.11/8.12.8) with ESMTP id i540o1NX001785;
	Fri, 4 Jun 2004 02:50:01 +0200
Received: (from ralf@localhost)
	by fluff.linux-mips.net (8.12.11/8.12.11/Submit) id i540o11M001784;
	Fri, 4 Jun 2004 02:50:01 +0200
Date: Fri, 4 Jun 2004 02:50:01 +0200
From: Ralf Baechle <ralf@linux-mips.org>
To: Sujith Nayak <nayak_27@yahoo.com>
Cc: linux-mips@linux-mips.org
Subject: Re: shared mem problem
Message-ID: <20040604005001.GA21250@linux-mips.org>
References: <20040603143153.42483.qmail@web60703.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040603143153.42483.qmail@web60703.mail.yahoo.com>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5248
X-Approved-By: ralf@linux-mips.org
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Jun 03, 2004 at 03:31:53PM +0100, Sujith Nayak wrote:

> I am currently working on a board powered by a MIPS
> processor, using Linux kernel 2.4.2. The problem that
> I am facing is, whenever I create a shared memory
> using shmget(), shmat(), etc. APIs, I always see that
> the shared mem is created with 0 bytes. As a result
> any access to it bombs the process.
> 
> Anyone has any idea, I will be grateful for your
> response. I had a look at the patch-2.4.2-ac23, which
> talks about the some shared mem lock up problem. But I
> cannot apply the patch as it is because my customer
> has pruned the kernel so much that the patch does not
> apply right away.

This doesn't look like the fingerprint of any known problem.  Anyway,
discussing 2.4.2 bugs is pointless - you're missing over three years
worth of bugfixes.

  Ralf
