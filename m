Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 29 Oct 2008 01:29:29 +0000 (GMT)
Received: from h4.dl5rb.org.uk ([81.2.74.4]:54925 "EHLO
	ditditdahdahdah-dahdahdahditdit.dl5rb.org.uk") by ftp.linux-mips.org
	with ESMTP id S22617978AbYJ2B3Q (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 29 Oct 2008 01:29:16 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by ditditdahdahdah-dahdahdahditdit.dl5rb.org.uk (8.14.2/8.14.1) with ESMTP id m9T1TC1w013364;
	Wed, 29 Oct 2008 01:29:12 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.2/8.14.2/Submit) id m9T1TBJ0013362;
	Wed, 29 Oct 2008 01:29:11 GMT
Date:	Wed, 29 Oct 2008 01:29:11 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	David Daney <ddaney@caviumnetworks.com>
Cc:	linux-mips@linux-mips.org,
	Tomaso Paoletti <tpaoletti@caviumnetworks.com>,
	Paul Gortmaker <Paul.Gortmaker@windriver.com>
Subject: Re: [PATCH 02/36] Add Cavium OCTEON files to
	arch/mips/include/asm/mach-cavium-octeon
Message-ID: <20081029012911.GA13328@linux-mips.org>
References: <490655B6.4030406@caviumnetworks.com> <1225152181-3221-1-git-send-email-ddaney@caviumnetworks.com> <1225152181-3221-2-git-send-email-ddaney@caviumnetworks.com> <20081028075733.GB20858@linux-mips.org> <4907A586.40409@caviumnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4907A586.40409@caviumnetworks.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21070
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Oct 28, 2008 at 04:51:34PM -0700, David Daney wrote:

>> It also means the resulting kernel won't have support for futex which
>> essentially means you're cut off from modern libcs.
>>
>> It is possible to get this to work - but nobody bothered so far; ll/sc-less
>> R2000 class processors are very rare these days.  My recommendation is
>> to keep cpu_has_llsc as 1 until you've fixed up the futex implementation,
>> if you deciede so.
>
> Someone should tell ip32 w/ R5000 this.  It seems that it is broken too.
>
> This could explain why my R5000 O2 does weird things with glibc 2.8...

The R5000 has a hardware bug with LL/SC on XKPHYS addresses so we
can't ...

  Ralf
