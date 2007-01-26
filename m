Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 26 Jan 2007 18:19:24 +0000 (GMT)
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:61328 "EHLO
	mailhub.stusta.mhn.de") by ftp.linux-mips.org with ESMTP
	id S20046642AbXAZSTU (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 26 Jan 2007 18:19:20 +0000
Received: from r063144.stusta.swh.mhn.de (r063144.stusta.swh.mhn.de [10.150.63.144])
	by mailhub.stusta.mhn.de (Postfix) with ESMTP id 5B6CB181C17;
	Fri, 26 Jan 2007 19:18:48 +0100 (CET)
Received: by r063144.stusta.swh.mhn.de (Postfix, from userid 1000)
	id 24A29114D96; Fri, 26 Jan 2007 19:18:53 +0100 (CET)
Date:	Fri, 26 Jan 2007 19:18:53 +0100
From:	Adrian Bunk <bunk@stusta.de>
To:	Linus Torvalds <torvalds@linux-foundation.org>,
	Andrew Morton <akpm@osdl.org>
Cc:	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Duncan <1i5t5.duncan@cox.net>, Neil Brown <neilb@suse.de>,
	mingo@redhat.com, linux-raid@vger.kernel.org,
	Dave Jones <davej@redhat.com>, cpufreq@lists.linux.org.uk,
	lenb@kernel.org, linux-acpi@vger.kernel.org,
	Jan Altenberg <jan@linutronix.de>,
	Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
	Andrew Clayton <andrew@digital-domain.net>,
	Trond Myklebust <trond.myklebust@fys.uio.no>
Subject: 2.6.20-rc6: known regressions with patches
Message-ID: <20070126181853.GO17836@stusta.de>
References: <Pine.LNX.4.64.0701241847360.25027@woody.linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0701241847360.25027@woody.linux-foundation.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Return-Path: <bunk@stusta.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13822
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: bunk@stusta.de
Precedence: bulk
X-list: linux-mips

This email lists some known regressions in 2.6.20-rc6 compared to 2.6.19
with patches available.

If you find your name in the Cc header, you are either submitter of one
of the bugs, maintainer of an affectected subsystem or driver, a patch
of you caused a breakage or I'm considering you in any other way possibly
involved with one or more of these issues.

Due to the huge amount of recipients, please trim the Cc when answering.


Subject    : RAID: annoying "hunk_aligned_read : non aligned" messages
References : http://bugzilla.kernel.org/show_bug.cgi?id=7835
Submitter  : Duncan <1i5t5.duncan@cox.net>
Handled-By : Neil Brown <neilb@suse.de>
Patch      : http://bugzilla.kernel.org/show_bug.cgi?id=7835
Status     : patch available


Subject    : ACPI: fix cpufreq regression
References : http://lkml.org/lkml/2007/1/16/120
Submitter  : Ingo Molnar <mingo@elte.hu>
Caused-By  : Dave Jones <davej@redhat.com>
             commit 0916bd3ebb7cefdd0f432e8491abe24f4b5a101e
Handled-By : Ingo Molnar <mingo@elte.hu>
Patch      : http://lkml.org/lkml/2007/1/16/120
Status     : patch available


Subject    : MIPS Malta: CONFIG_MTD=n compile error
References : http://lkml.org/lkml/2007/1/25/122
Submitter  : Jan Altenberg <jan@linutronix.de>
Caused-By  : Ralf Baechle <ralf@linux-mips.org>
             commit b228f4c54df37b53c6f364aa7f3efa4280bcc4f0
Handled-By : Jan Altenberg <jan@linutronix.de>
Patch      : http://lkml.org/lkml/2007/1/25/122
Status     : patch available


Subject    : NFS triggers WARN_ON() in invalidate_inode_pages2_range()
References : http://bugzilla.kernel.org/show_bug.cgi?id=7826
Submitter  : Andrew Clayton <andrew@digital-domain.net>
Caused-By  : Andrew Morton <akpm@osdl.org>
             commit 8258d4a574d3a8c01f0ef68aa26b969398a0e140
Handled-By : Trond Myklebust <trond.myklebust@fys.uio.no>
Patch      : http://lkml.org/lkml/2007/1/24/323
Status     : patch available
