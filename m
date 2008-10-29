Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 29 Oct 2008 18:10:11 +0000 (GMT)
Received: from h4.dl5rb.org.uk ([81.2.74.4]:62339 "EHLO
	ditditdahdahdah-dahdahdahditdit.dl5rb.org.uk") by ftp.linux-mips.org
	with ESMTP id S22673443AbYJ2SKC (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 29 Oct 2008 18:10:02 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by ditditdahdahdah-dahdahdahditdit.dl5rb.org.uk (8.14.2/8.14.1) with ESMTP id m9TI9xax027532;
	Wed, 29 Oct 2008 18:09:59 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.2/8.14.2/Submit) id m9TI9xAe027530;
	Wed, 29 Oct 2008 18:09:59 GMT
Date:	Wed, 29 Oct 2008 18:09:58 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	David Daney <ddaney@caviumnetworks.com>
Cc:	linux-mips@linux-mips.org,
	Tomaso Paoletti <tpaoletti@caviumnetworks.com>,
	Paul Gortmaker <Paul.Gortmaker@windriver.com>
Subject: Re: [PATCH 04/36] Add Cavium OCTEON processor support files to
	arch/mips/mm.
Message-ID: <20081029180958.GE26256@linux-mips.org>
References: <490655B6.4030406@caviumnetworks.com> <1225152181-3221-1-git-send-email-ddaney@caviumnetworks.com> <1225152181-3221-2-git-send-email-ddaney@caviumnetworks.com> <1225152181-3221-3-git-send-email-ddaney@caviumnetworks.com> <1225152181-3221-4-git-send-email-ddaney@caviumnetworks.com> <20081029160710.GB26256@linux-mips.org> <49088E81.7080604@caviumnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <49088E81.7080604@caviumnetworks.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21081
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Oct 29, 2008 at 09:25:37AM -0700, David Daney wrote:

>>  The probability is not so high
>> for typical apps but it's entirely possibly that on a preemptable kernel
>> the thread that wrote the trampoline code gets rescheduled to another
>> CPU before the flush is executed.  Or after the SYNCI happened on the one
>> core the thread is rescheduled to another CPU which then may try to
>> return with an inconsistent I-cache.  Boom.
>
>
> This is the problem I mentioned yesterday on IRC.  I had come to the  
> same conclusion and think we need to invalidate the icache on all cores  
> here.
>
> The real solution to this problem is to place the signal trampolines in  
> a VDSO.  But that is a project for another day.

Or we once more rely on abusing the address error exception.  Place an
address in the kernel space into $ra before jumping to the signal handler.
Once finished the signal handler then will trigger an address error.
Ugly.  Efficient.  And it would get rid of all the fun
"Don't let your children do this ..." stunts of sigreturn.

  Ralf
