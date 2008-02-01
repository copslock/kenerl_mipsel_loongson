Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 01 Feb 2008 09:32:12 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:60567 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20026587AbYBAJcJ (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 1 Feb 2008 09:32:09 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id m119W976018222;
	Fri, 1 Feb 2008 09:32:09 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id m119W9HY018221;
	Fri, 1 Feb 2008 09:32:09 GMT
Date:	Fri, 1 Feb 2008 09:32:09 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Chris Friesen <cfriesen@nortel.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: kexec on SMP mips64?
Message-ID: <20080201093209.GA18195@linux-mips.org>
References: <47A21286.3020009@nortel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <47A21286.3020009@nortel.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18163
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Jan 31, 2008 at 12:25:10PM -0600, Chris Friesen wrote:

> We're starting work on an embedded highly-available product using dual 
> Octeon cpus, and I'm looking into the possibility of using kexec/kdump as a 
> "flight recorder" to dump fault information to a persistant storage 
> location.
>
> I saw the patch adding initial support for kexec, but I was curious about 
> the current status.  Is anyone using kexec for mips64 SMP systems?  Is it 
> known to be broken?  I'm just trying to get a feel for how much work might 
> be involved.

I would classify the code as untested and suspect.

  Ralf
