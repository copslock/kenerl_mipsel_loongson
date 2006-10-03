Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 03 Oct 2006 21:13:23 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:59280 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20038894AbWJCUNW (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 3 Oct 2006 21:13:22 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.13.7/8.13.7) with ESMTP id k93KDMva006329;
	Tue, 3 Oct 2006 21:13:22 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.7/8.13.7/Submit) id k93KDLJH006328;
	Tue, 3 Oct 2006 21:13:21 +0100
Date:	Tue, 3 Oct 2006 21:13:21 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: [MIPS] Fix wreckage after removal of tickadj; convert to GENERIC_TIME.
Message-ID: <20061003201320.GB4934@linux-mips.org>
References: <S20038910AbWJCTjS/20061003193918Z+2409@ftp.linux-mips.org> <4522BDFC.5040701@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4522BDFC.5040701@ru.mvista.com>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12792
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Oct 03, 2006 at 11:46:04PM +0400, Sergei Shtylyov wrote:

>    Well, be forewarned that with this patch, MIPS kernel now only has 
> jiffy-precise time resolution. I.e. you could have killed all gettimeoffset 
> handlers I suppose since there's nothing to call them from anymore. We need 
> a clocksource patch added now to restore the old functionality (it's 
> currently a part of the RT patch)...

After the other broken time patch it was most important to get the
kernel buildable again.  We can still sort out the clock source.

  Ralf
