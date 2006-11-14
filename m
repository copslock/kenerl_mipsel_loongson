Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 14 Nov 2006 12:55:01 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:17874 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20038639AbWKNMy6 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 14 Nov 2006 12:54:58 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.13.8/8.13.8) with ESMTP id kAECtEs7029013;
	Tue, 14 Nov 2006 12:55:15 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.8/8.13.8/Submit) id kAECtEoW029012;
	Tue, 14 Nov 2006 12:55:14 GMT
Date:	Tue, 14 Nov 2006 12:55:14 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	chandrashekar mogilicherla <chandu.nitw@gmail.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: process created when pthread_create is used ??????????
Message-ID: <20061114125514.GA28579@linux-mips.org>
References: <69a573da0611140328w16138465lfa7a6268981867e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <69a573da0611140328w16138465lfa7a6268981867e@mail.gmail.com>
User-Agent: Mutt/1.4.2.2i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13196
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Nov 14, 2006 at 04:58:46PM +0530, chandrashekar mogilicherla wrote:

> Iam using fedora core 2.6.11 kernel on mips machine ,

Interesting, I wonder where you got that Fedora port from?

> "process is getting created when i try to create thread using pthread
> library."
> 
> Can anybody explain what is happening  out  there

On a kernel level thread and process are almost identical things which is
why they look the same in ps output.  The fine differences are more
special properties such as a having a private address space.

  Ralf
