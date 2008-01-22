Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 22 Jan 2008 17:57:37 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:646 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S28589389AbYAVR5f (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 22 Jan 2008 17:57:35 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id m0MHvYov001218;
	Tue, 22 Jan 2008 17:57:35 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id m0MHvYLk001217;
	Tue, 22 Jan 2008 17:57:34 GMT
Date:	Tue, 22 Jan 2008 17:57:34 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Chris Friesen <cfriesen@nortel.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: quick question on 64-bit values with 32-bit inline assembly
Message-ID: <20080122175734.GA31013@linux-mips.org>
References: <4794DFE1.5040805@nortel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4794DFE1.5040805@nortel.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18111
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Jan 21, 2008 at 12:09:37PM -0600, Chris Friesen wrote:

> We're running a 64-bit kernel and 32-bit userspace.  We've got some code 
> that is trying to get a 64-bit timestamp in userspace.
>
> The following code seems to work fine in the kernel but in userspace it 
> appears to be swapping the two words in the result.
>
> gethrtime(void)
> {
>    unsigned long long result;
>
>    asm volatile ("rdhwr %0,$31" : "=r" (result));

Ah, Cavium.

>    return result;
> }
>
> Do I need to do something special because userspace is 32-bit?  If so, can 
> someone point me to a reference?

Ouch.  You found a nasty special case.  Normally 32-bit userspace should
not use 64-bit values but since you're running a 64-bit kernel.

unsigned long long gethrtime(void)
{
	unsigned long result;

	asm volatile(
	"	.set	mips64r2		\n"
	"	rdhwr	%M0, $31		\n"
	"	sll	%L0, %M0, 0		\n"
	"	dsra	%M0, 32			\n"
	"	.set	mips0			\n"
	: "=r" (result));

	return result;
}

Note this wouldn't possibly work on a 32-bit kernel because 32-bit kernels
will corrupt the upper 32-bit of integer registers so you might lose the
result value before you can stash it away.  Also 32-bit kernels don't allow
the execution of 64-bit instructions, not even on 64-bit processors.

  Ralf
