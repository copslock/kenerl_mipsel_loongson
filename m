Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 20 Feb 2008 16:18:48 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:57571 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20030417AbYBTQSp (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 20 Feb 2008 16:18:45 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id m1KGIjgY003684;
	Wed, 20 Feb 2008 16:18:45 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id m1KGIirO003683;
	Wed, 20 Feb 2008 16:18:44 GMT
Date:	Wed, 20 Feb 2008 16:18:44 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	David VomLehn <dvomlehn@cisco.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: Does HIGHMEM work on 32-bit MIPS ports?
Message-ID: <20080220161844.GC25644@linux-mips.org>
References: <47BBA809.3050505@cisco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <47BBA809.3050505@cisco.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18279
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Feb 19, 2008 at 08:09:45PM -0800, David VomLehn wrote:

> As we continue to investigate using high memory on MIPS, we keep coming up 
> with odd results. The basic mapping of high memory seems to be working 
> correctly, and if we use an INITRAMFS root filesystem, things seem to work. 
> Things also seem to work with an NFS root filesystem if we disable 
> preemption, though we get someone squirrelly behavior in some minor ways. 
> Has anyone else successfully been able to use high memory on a 32-bit MIPS 
> Linux port?

I've written MIPS highmem support in late 2002 for a customer who back
then wasn't interested in being the first through the 64-bit minefield.
Which back then certainly was justified - but there are now fairly
stable 64-bit Linux kernels available so if you happen to be running on
64-bit hardware don't even spend a nanosecond on thinking about 32-bit
highmem kernels.  Highmem fundamentally sucks rocks through a straw.

Coming back to your question.  Highmem was only ever tested to work on
SB1 and somewhat later PMC-Sierra RM9000 cores, both being 64-bit.  With
the increasing maturity of 64-bit Linux interest in these went away and
as the result the highmem code started a slow bitrot - unnoticed for many
moons.

  Ralf
