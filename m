Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 17 Jul 2015 10:04:08 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:35727 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27009572AbbGQIEHGbpGd (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 17 Jul 2015 10:04:07 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.15.1/8.14.8) with ESMTP id t6H845BI009969;
        Fri, 17 Jul 2015 10:04:05 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.15.1/8.15.1/Submit) id t6H845MS009968;
        Fri, 17 Jul 2015 10:04:05 +0200
Date:   Fri, 17 Jul 2015 10:04:05 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Markos Chandras <markos.chandras@imgtec.com>
Cc:     linux-mips@linux-mips.org
Subject: Re: [PATCH] MIPS: math-emu: cp1emu: Fix closing bracket for the
 d_fmt case
Message-ID: <20150717080405.GC9084@linux-mips.org>
References: <1437052005-14520-1-git-send-email-markos.chandras@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1437052005-14520-1-git-send-email-markos.chandras@imgtec.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48335
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

On Thu, Jul 16, 2015 at 02:06:45PM +0100, Markos Chandras wrote:

> The double format (d_fmt) case uses an opening bracket which then
> closes at the end of the word format (w_fmt). This can be rather confusing
> so add the closing bracket at the end of the d_fmt case and use another one
> for the w_fmt one.

Heh.  There used to be a construct like

  switch (foo)
  case val1:
	if (bla) {
		...
  case val2:
	} else {
  case val3:
	}
  }

in the kernel and even though entirely correct I received several bug
reports for it.  One reportes even suggested a bug report against GCC!

So queued for peace of mind in 4.3.  Thanks!

  Ralf
