Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 18 May 2009 18:48:54 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:52509 "EHLO
	localhost.localdomain" rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org
	with ESMTP id S20024297AbZERRsv (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 18 May 2009 18:48:51 +0100
Date:	Mon, 18 May 2009 18:48:50 +0100 (BST)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	David Daney <ddaney@caviumnetworks.com>
cc:	ralf@linux-mips.org, David VomLehn <dvomlehn@cisco.com>,
	linux-mips@linux-mips.org
Subject: Re: [PATCH] MIPS: Don't branch to eret in TLB refill.
In-Reply-To: <4A118BE8.50201@caviumnetworks.com>
Message-ID: <alpine.LFD.1.10.0905181829270.20791@ftp.linux-mips.org>
References: <1242168316-4009-1-git-send-email-ddaney@caviumnetworks.com> <20090513002337.GA12536@cuplxvomd02.corp.sa.net> <4A0A1E6B.6050908@caviumnetworks.com> <alpine.LFD.1.10.0905160706300.12158@ftp.linux-mips.org> <4A118BE8.50201@caviumnetworks.com>
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22798
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, 18 May 2009, David Daney wrote:

> I don't really know what to say about that comment.
> 
> * We are synthesizing optimized TLB refill handlers, even small improvements
> yield big gains in system performance.
> 
> * The optimization you suggest below, although a good one, is somewhat
> different and would make a good follow on patch.
> 
> * I am trying to make forward progress and not have The perfect be the enemy
> of the good.

 What I suggested obsoletes your patch and requires it to be reverted 
because the folding point search algorithm would change.  It yields 
optimisation you (and everybody else, even if they do not realise it) are 
after not only for your corner case of ERET being exactly at offset of 
0x7c from the beginning of the XTLB handler slot, but for any systems for 
which the size of the XTLB slot is not enough to hold the whole handler, 
which, according to my knowledge, currently means all.  So why to go 
through the two-stage process at all and fix a corner case rather than the 
whole problem in the first place?

 This is my point of view; others may disagree of course.

  Maciej
