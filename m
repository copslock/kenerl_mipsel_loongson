Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 29 Oct 2008 16:26:57 +0000 (GMT)
Received: from h4.dl5rb.org.uk ([81.2.74.4]:38808 "EHLO
	ditditdahdahdah-dahdahdahditdit.dl5rb.org.uk") by ftp.linux-mips.org
	with ESMTP id S22668471AbYJ2Q0u (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 29 Oct 2008 16:26:50 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by ditditdahdahdah-dahdahdahditdit.dl5rb.org.uk (8.14.2/8.14.1) with ESMTP id m9TGQgBW025529;
	Wed, 29 Oct 2008 16:26:42 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.2/8.14.2/Submit) id m9TGQgEk025527;
	Wed, 29 Oct 2008 16:26:42 GMT
Date:	Wed, 29 Oct 2008 16:26:42 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	David Daney <ddaney@caviumnetworks.com>
Cc:	linux-mips@linux-mips.org,
	Tomaso Paoletti <tpaoletti@caviumnetworks.com>,
	Paul Gortmaker <Paul.Gortmaker@windriver.com>
Subject: Re: [PATCH 15/36] Probe for Cavium OCTEON CPUs.
Message-ID: <20081029162642.GC26256@linux-mips.org>
References: <1225152181-3221-8-git-send-email-ddaney@caviumnetworks.com> <1225152181-3221-9-git-send-email-ddaney@caviumnetworks.com> <1225152181-3221-10-git-send-email-ddaney@caviumnetworks.com> <1225152181-3221-11-git-send-email-ddaney@caviumnetworks.com> <1225152181-3221-12-git-send-email-ddaney@caviumnetworks.com> <1225152181-3221-13-git-send-email-ddaney@caviumnetworks.com> <1225152181-3221-14-git-send-email-ddaney@caviumnetworks.com> <1225152181-3221-15-git-send-email-ddaney@caviumnetworks.com> <20081029121737.GA26256@linux-mips.org> <49088CBF.8060109@caviumnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <49088CBF.8060109@caviumnetworks.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21077
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Oct 29, 2008 at 09:18:07AM -0700, David Daney wrote:

> Acked-by: David Daney <ddaney@caviumnetworks.com>
>
> This seems sane to me assuming that alchemy, sibyte, sandcraft, nxp, and  
> broadcom all have standard mips{32,64} watch registers (i.e., if the  
> watch bit in config1 is set the registers have mips semantics).

The watch bit is a standard feature of the MIPS R1/R2 architecture.  What
Sandcraft did was bascially an RM7000 clone with some extensions.  I'm
still trying to track somebody who could verify the correctness of that
code as I don't have Sandcraft docs ...

  Ralf
