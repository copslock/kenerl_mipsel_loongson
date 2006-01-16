Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 16 Jan 2006 16:32:18 +0000 (GMT)
Received: from pasta.sw.starentnetworks.com ([12.33.234.10]:57483 "EHLO
	pasta.sw.starentnetworks.com") by ftp.linux-mips.org with ESMTP
	id S8133509AbWAPQcA (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 16 Jan 2006 16:32:00 +0000
Received: from cortez.sw.starentnetworks.com (cortez.sw.starentnetworks.com [12.33.233.12])
	by pasta.sw.starentnetworks.com (Postfix) with ESMTP
	id 8EEBA149719; Mon, 16 Jan 2006 11:35:26 -0500 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17355.52046.456176.406834@cortez.sw.starentnetworks.com>
Date:	Mon, 16 Jan 2006 11:35:26 -0500
From:	Dave Johnson <djohnson+linuxmips@sw.starentnetworks.com>
To:	Martin Michlmayr <tbm@cyrius.com>, linux-mips@linux-mips.org
Subject: Re: [PATCH] gettimeofday jumps backwards then forwards
In-Reply-To: <20060116160031.GA28383@deprecation.cyrius.com>
References: <17118.25343.948383.547250@cortez.sw.starentnetworks.com>
	<20060116160031.GA28383@deprecation.cyrius.com>
X-Mailer: VM 7.07 under 21.4 (patch 6) "Common Lisp" XEmacs Lucid
Return-Path: <djohnson@sw.starentnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9903
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: djohnson+linuxmips@sw.starentnetworks.com
Precedence: bulk
X-list: linux-mips

Martin Michlmayr writes:
> * Dave Johnson <djohnson+linuxmips@sw.starentnetworks.com> [2005-07-20 10:43]:
> > Below are 2 fixes I made to 2.6.12 to do with time jumping around
> > as reported by gettimeofday().  One is SB1250 specific and one appears
> > generic.
> > 
> > The symptom is revealed by running multile copies (1 per cpu) of a
> > simple test program that calls gettimeofday() as fast as possible
> > looking for time to go backwards.
> > 
> > When a jump is detected the program outputs a few samples before and
> > after each jump:
> 
> Does anyone have comments regarding this patch?

In addition to this problem I found significant lost ticks under load
as there is no checking for lost ticks. I'll create a clean patch with
just that fix in a bit.


-- 
Dave Johnson
Starent Networks
