Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 15 Mar 2008 14:47:23 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:27330 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S28593215AbYCOOrV (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sat, 15 Mar 2008 14:47:21 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id m2FElKum024340;
	Sat, 15 Mar 2008 14:47:20 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id m2FElKKF024339;
	Sat, 15 Mar 2008 14:47:20 GMT
Date:	Sat, 15 Mar 2008 14:47:20 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH] check for gcc r10k-cache-barrier support
Message-ID: <20080315144720.GA22631@linux-mips.org>
References: <20080315112851.55750C2360@solo.franken.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20080315112851.55750C2360@solo.franken.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18400
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Sat, Mar 15, 2008 at 12:28:51PM +0100, Thomas Bogendoerfer wrote:

> Check whether gcc supports -mr10-cache-barrier=1 and issue a cleaner
> error message if not. This option is needed to build working SGI IP28
> kernels.

Thanks, applied.

  Ralf
