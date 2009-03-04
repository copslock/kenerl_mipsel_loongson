Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 04 Mar 2009 12:17:41 +0000 (GMT)
Received: from NaN.false.org ([208.75.86.248]:25220 "EHLO nan.false.org")
	by ftp.linux-mips.org with ESMTP id S21365165AbZCDMRi (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 4 Mar 2009 12:17:38 +0000
Received: from nan.false.org (localhost [127.0.0.1])
	by nan.false.org (Postfix) with ESMTP id 48BEF10A30;
	Wed,  4 Mar 2009 12:17:36 +0000 (GMT)
Received: from caradoc.them.org (209.195.188.212.nauticom.net [209.195.188.212])
	by nan.false.org (Postfix) with ESMTP id 986BF104DE;
	Wed,  4 Mar 2009 12:17:35 +0000 (GMT)
Received: from drow by caradoc.them.org with local (Exim 4.69)
	(envelope-from <drow@caradoc.them.org>)
	id 1Leq2W-0007TG-W4; Wed, 04 Mar 2009 07:17:33 -0500
Date:	Wed, 4 Mar 2009 07:17:32 -0500
From:	Daniel Jacobowitz <dan@debian.org>
To:	Brian Foster <brian.foster@innova-card.com>
Cc:	David Daney <ddaney@caviumnetworks.com>,
	"Maciej W. Rozycki" <macro@codesourcery.com>,
	Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
	libc-ports@sourceware.org,
	"Maciej W. Rozycki" <macro@linux-mips.org>
Subject: Re: [PATCH, RFC] MIPS: Implement the getcontext API
Message-ID: <20090304121732.GA28381@caradoc.them.org>
References: <alpine.DEB.1.10.0902282326580.4064@tp.orcam.me.uk> <49AD6139.60209@caviumnetworks.com> <200903040919.29294.brian.foster@innova-card.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <200903040919.29294.brian.foster@innova-card.com>
User-Agent: Mutt/1.5.17 (2008-05-11)
Return-Path: <drow@false.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21998
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dan@debian.org
Precedence: bulk
X-list: linux-mips

On Wed, Mar 04, 2009 at 09:19:28AM +0100, Brian Foster wrote:
>  moving the signal trampoline to a vdso (which
>  is(? was?) called, maybe misleadingly, ‘vsyscall’,
>  on other architectures) is the obvious solution to
>  that part of the puzzle.  and yes, it is possible
>  to maintain the ABI; the signal trampoline is still
>  also put on the stack, and modulo XI, would work if
>  used — the trampoline-on-stack is simply not used
>  if there is a vdso with the signal trampoline.

That won't quite retain the ABI: you need to make sure everyone
locates it by using the stack pointer instead of the return pc.
Fortunately, GCC uses the return PC only for instruction matching
today.  I have a vague memory it used to use the stack pointer but
this was more reliable.

They don't necessarily have to go into the vdso; other architectures
have moved them off the stack directly to glibc.

-- 
Daniel Jacobowitz
CodeSourcery
