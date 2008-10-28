Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 28 Oct 2008 17:28:24 +0000 (GMT)
Received: from h4.dl5rb.org.uk ([81.2.74.4]:62855 "EHLO
	ditditdahdahdah-dahdahdahditdit.dl5rb.org.uk") by ftp.linux-mips.org
	with ESMTP id S22597124AbYJ1R2O (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 28 Oct 2008 17:28:14 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by ditditdahdahdah-dahdahdahditdit.dl5rb.org.uk (8.14.2/8.14.1) with ESMTP id m9SHSBrQ002176;
	Tue, 28 Oct 2008 17:28:11 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.2/8.14.2/Submit) id m9SHSA5k002175;
	Tue, 28 Oct 2008 17:28:10 GMT
Date:	Tue, 28 Oct 2008 17:28:10 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	David Daney <ddaney@caviumnetworks.com>
Cc:	linux-mips@linux-mips.org,
	Tomaso Paoletti <tpaoletti@caviumnetworks.com>,
	Paul Gortmaker <Paul.Gortmaker@windriver.com>
Subject: Re: [PATCH 07/36] Don't assume boot CPU is CPU0 if
	MIPS_DISABLE_BOOT_CPU_ZERO set.
Message-ID: <20081028172810.GC1566@linux-mips.org>
References: <490655B6.4030406@caviumnetworks.com> <1225152181-3221-1-git-send-email-ddaney@caviumnetworks.com> <1225152181-3221-2-git-send-email-ddaney@caviumnetworks.com> <1225152181-3221-3-git-send-email-ddaney@caviumnetworks.com> <1225152181-3221-4-git-send-email-ddaney@caviumnetworks.com> <1225152181-3221-5-git-send-email-ddaney@caviumnetworks.com> <1225152181-3221-6-git-send-email-ddaney@caviumnetworks.com> <1225152181-3221-7-git-send-email-ddaney@caviumnetworks.com> <20081028064743.GA18610@linux-mips.org> <49074135.6060104@caviumnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <49074135.6060104@caviumnetworks.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21066
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Oct 28, 2008 at 09:43:33AM -0700, David Daney wrote:

>> This assignment is redundant anyway - the kernel is starting with the array
>> zeroed.  So just remove this entire initialization and do your array
>> initialization in your mp_ops->smp_setup.
>>
>
> We already do that.  I will just delete this section unconditionally.

I've already committed that locally.

  Ralf
