Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 21 Dec 2004 00:25:23 +0000 (GMT)
Received: from p508B7A83.dip.t-dialin.net ([IPv6:::ffff:80.139.122.131]:56185
	"EHLO mail.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225241AbULUAZS>; Tue, 21 Dec 2004 00:25:18 +0000
Received: from fluff.linux-mips.net (localhost.localdomain [127.0.0.1])
	by mail.linux-mips.net (8.13.1/8.13.1) with ESMTP id iBL0P7Uw020785;
	Tue, 21 Dec 2004 01:25:07 +0100
Received: (from ralf@localhost)
	by fluff.linux-mips.net (8.13.1/8.13.1/Submit) id iBL0P6Ol020784;
	Tue, 21 Dec 2004 01:25:06 +0100
Date: Tue, 21 Dec 2004 01:25:06 +0100
From: Ralf Baechle <ralf@linux-mips.org>
To: "Steven J. Hill" <sjhill@realitydiluted.com>
Cc: linux-mips@linux-mips.org
Subject: Re: Ideas on removing a compiler warning in 'init_task.c' ...
Message-ID: <20041221002506.GA6538@linux-mips.org>
References: <41C377ED.1040502@realitydiluted.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41C377ED.1040502@realitydiluted.com>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6719
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, Dec 17, 2004 at 06:21:01PM -0600, Steven J. Hill wrote:

> I actually broke out the macro and it is complaining about the 
> initialization
> of 'action' member in the 'sighand_struct' defined in 
> 'include/linux/sched.h'.
> 
>   struct sighand_struct {
>           atomic_t                count;
>           struct k_sigaction      action[_NSIG];
>           spinlock_t              siglock;
>   };
> 
> I do not see this when compiling x86 code and the MIPS structure is
> not that drastically different IMHO. Anyone have some ideas on this
> one?

The members of struct sigaction are ordered differently on MIPS.

  Ralf
