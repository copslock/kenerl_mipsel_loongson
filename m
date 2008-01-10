Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 10 Jan 2008 14:37:38 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:58765 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S28577371AbYAJOhd (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 10 Jan 2008 14:37:33 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id m0AEbI4d013767;
	Thu, 10 Jan 2008 14:37:18 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id m0AEbIwC013766;
	Thu, 10 Jan 2008 14:37:18 GMT
Date:	Thu, 10 Jan 2008 14:37:18 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Vitaly Wool <vitalywool@gmail.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: pnx8xxx: move to clocksource
Message-ID: <20080110143718.GA13489@linux-mips.org>
References: <4786273D.7010006@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4786273D.7010006@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17972
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Jan 10, 2008 at 05:10:05PM +0300, Vitaly Wool wrote:

> This patch converts PNX8XXX system timer to clocksource.

Checkpatch had a little to moan on your patch:

$ scripts/checkpatch.pl /tmp/pend 
ERROR: use tabs not spaces
#79: FILE: arch/mips/philips/pnx8550/common/time.c:57:
+        struct clock_event_device *c = dev_id;$

ERROR: use tabs not spaces
#81: FILE: arch/mips/philips/pnx8550/common/time.c:59:
+        /* clear MATCH, signal the event */$

ERROR: use tabs not spaces
#82: FILE: arch/mips/philips/pnx8550/common/time.c:60:
+        c->event_handler(c);$

Your patch has style problems, please review.  If any of these errors
are false positives report them to the maintainer, see
CHECKPATCH in MAINTAINERS.

I fixed those, applied.  Thanks!

  Ralf
