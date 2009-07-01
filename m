Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 01 Jul 2009 20:26:40 +0200 (CEST)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:56522 "EHLO h5.dl5rb.org.uk"
	rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org with ESMTP
	id S1491784AbZGAS0c (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 1 Jul 2009 20:26:32 +0200
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
	by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id n61IKqah023611;
	Wed, 1 Jul 2009 19:20:52 +0100
Received: (from ralf@localhost)
	by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id n61IKpnQ023609;
	Wed, 1 Jul 2009 19:20:51 +0100
Date:	Wed, 1 Jul 2009 19:20:51 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	David Daney <ddaney@caviumnetworks.com>
Cc:	"Maciej W. Rozycki" <macro@linux-mips.org>,
	linux-mips@linux-mips.org
Subject: Re: [PATCH] MIPS: Define  __arch_swab64 for all mips r2 cpus (v2).
Message-ID: <20090701182051.GB23121@linux-mips.org>
References: <1246294455-26866-1-git-send-email-ddaney@caviumnetworks.com> <20090629193454.GA23430@linux-mips.org> <alpine.LFD.2.00.0907010132500.23134@eddie.linux-mips.org> <4A4AB845.1030906@caviumnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4A4AB845.1030906@caviumnetworks.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <ralf@h5.dl5rb.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23582
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Jun 30, 2009 at 06:13:41PM -0700, David Daney wrote:

> The problem with CPU_MIPS64_R2 in the kernel is that it means two  
> unrelated things:
>
> 1) The cpu can execute all mips64r2 ISA instructions.
>
> 2) The cpu requires that all worse case cache and execution hazards are  
> handled.
>
> In the case of the Octeon processors, #1 is true, but we can get better  
> performance by omitting many of the hazard barriers because they are  
> unneeded.

The most performance sensitive hazard barriers are the ones in the TLB
exception handlers and they're now being handled in C code in tlbex.c
which mostly does runtime decissions.  I suspect the remaining hazard
barriers are not a big performance thing anymore.

  Ralf
