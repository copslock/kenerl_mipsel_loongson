Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 19 Nov 2007 19:31:41 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:44728 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20034078AbXKSTbj (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 19 Nov 2007 19:31:39 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id lAJJVcLL027339;
	Mon, 19 Nov 2007 19:31:38 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id lAJJVbMJ027338;
	Mon, 19 Nov 2007 19:31:37 GMT
Date:	Mon, 19 Nov 2007 19:31:37 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Florian Lohoff <flo@rfc822.org>
Cc:	linux-mips@linux-mips.org
Subject: Re: IP22 64Bit arcboot - current git crashes on 3 machines at
	different points
Message-ID: <20071119193137.GA27317@linux-mips.org>
References: <20071119160954.GA12244@paradigm.rfc822.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20071119160954.GA12244@paradigm.rfc822.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17533
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Nov 19, 2007 at 05:09:54PM +0100, Florian Lohoff wrote:

> i am seeing strange issues with 64 Bit kernels IP22 on different
> machines. This came up when i tried the debian distribution kernel
> which fails for me on 2 machines.

I still haven't sorted out all the workarounds for the read-from-compare
bug in early R4000 / R4400 with the new time code.  It may not be the
issue that's hitting you but the new time code definately has the potencial
to trigger the issue.

  Ralf
