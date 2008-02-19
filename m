Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 19 Feb 2008 14:19:43 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:62659 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20024611AbYBSOTl (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 19 Feb 2008 14:19:41 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id m1JEJeR5014998;
	Tue, 19 Feb 2008 14:19:40 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id m1JEJeWs014997;
	Tue, 19 Feb 2008 14:19:40 GMT
Date:	Tue, 19 Feb 2008 14:19:40 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Dmitri Vorobiev <dmitri.vorobiev@gmail.com>
Cc:	linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [MIPS] Enable the timerfd_*() o32 system calls
Message-ID: <20080219141940.GA14991@linux-mips.org>
References: <1203368557-32356-1-git-send-email-dmitri.vorobiev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1203368557-32356-1-git-send-email-dmitri.vorobiev@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18263
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Feb 19, 2008 at 12:02:37AM +0300, Dmitri Vorobiev wrote:

> This patch enables the system calls timerfd_create(), timerfd_settime()
> and timerfd_gettime() for MIPS architecture.
> 
> Please see the following Bugzilla entry for more details:
> 
> http://bugzilla.kernel.org/show_bug.cgi?id=10038
> 
> This was tested using a Malta 4Kc board in both little-endian and
> big-endian modes. The unit test program is available from the URL
> above.
> 
> Note that only the "o32"-style system calls have been added. This is
> due to the fact that I have no suitable equipment to test the other
> flavors of MIPS ABI.

Thanks.  I added the missing bits for the others ABIs and applied the
combined patch.

  Ralf
