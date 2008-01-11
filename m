Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 11 Jan 2008 12:32:24 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:6853 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S28579060AbYAKMcW (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 11 Jan 2008 12:32:22 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id m0BCW1jA028932;
	Fri, 11 Jan 2008 12:32:01 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id m0BCW0c6028931;
	Fri, 11 Jan 2008 12:32:00 GMT
Date:	Fri, 11 Jan 2008 12:32:00 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Daniel Walker <dwalker@mvista.com>
Cc:	brian@murphy.dk, mingo@elte.hu, linux-mips@linux-mips.org
Subject: Re: [PATCH] mips: picvue: pvc_sem semaphore to mutex
Message-ID: <20080111123200.GA19900@linux-mips.org>
References: <20080111045321.274084894@mvista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20080111045321.274084894@mvista.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17985
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Jan 10, 2008 at 08:53:21PM -0800, Daniel Walker wrote:

> This semaphore conforms to the new struct mutex, so I've converted it
> to use that new API.
> 
> I also changed the name to pvc_mutex, and moved the define to the file
> it's used in which allows it to be static.

Queued for 2.6.25, thanks.

  Ralf
