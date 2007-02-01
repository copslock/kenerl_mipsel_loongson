Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 01 Feb 2007 18:10:32 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:11452 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20038962AbXBASKb (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 1 Feb 2007 18:10:31 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.13.8/8.13.8) with ESMTP id l11IATVo018480;
	Thu, 1 Feb 2007 18:10:29 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.8/8.13.8/Submit) id l11IASdV018479;
	Thu, 1 Feb 2007 18:10:28 GMT
Date:	Thu, 1 Feb 2007 18:10:28 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Franck Bui-Huu <vagabon.xyz@gmail.com>
Cc:	linux-mips <linux-mips@linux-mips.org>
Subject: Re: Question about signal syscalls !
Message-ID: <20070201181028.GA16964@linux-mips.org>
References: <cda58cb80702010243y4a36026i6945f2a5cd3791d0@mail.gmail.com> <20070201135734.GB12728@linux-mips.org> <cda58cb80702010654w74527a34k4ed229b499b8f9b2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cda58cb80702010654w74527a34k4ed229b499b8f9b2@mail.gmail.com>
User-Agent: Mutt/1.4.2.2i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13885
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Feb 01, 2007 at 03:54:40PM +0100, Franck Bui-Huu wrote:

> Let's take for example sys_sigreturn(). In my understanding this
> syscall is used automatically when the signal handler returns. At this
> time, I don't see the point to save the static registers since they
> have been already saved by setup_sigcontext().
> 
> Actually I don't see why they need to be saved/restored at all...

There is no need.  Seems you found a harmless but longstanding but
introduced by c40738a70f3e02e8554b78af334dc95356a78989.

  Ralf
