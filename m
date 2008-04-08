Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 08 Apr 2008 14:16:42 +0200 (CEST)
Received: from oss.sgi.com ([192.48.170.157]:57323 "EHLO oss.sgi.com")
	by lappi.linux-mips.net with ESMTP id S536848AbYDHMQg (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 8 Apr 2008 14:16:36 +0200
Received: from dl5rb.ham-radio-op.net (localhost [127.0.0.1])
	by oss.sgi.com (8.12.11.20060308/8.12.11/SuSE Linux 0.7) with ESMTP id m38CEUhD018704
	for <linux-mips@linux-mips.org>; Tue, 8 Apr 2008 05:14:31 -0700
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id m38BJdAn016880;
	Tue, 8 Apr 2008 12:19:39 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id m38BJd3m016879;
	Tue, 8 Apr 2008 12:19:39 +0100
Date:	Tue, 8 Apr 2008 12:19:39 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH] Pb1000: bury the remnants of the PCI code
Message-ID: <20080408111939.GA15630@linux-mips.org>
References: <200804052259.29959.sshtylyov@ru.mvista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200804052259.29959.sshtylyov@ru.mvista.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Virus-Scanned: ClamAV 0.91.2/6021/Wed Feb 27 15:55:48 2008 on oss.sgi.com
X-Virus-Status:	Clean
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18855
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Sat, Apr 05, 2008 at 10:59:29PM +0400, Sergei Shtylyov wrote:

> PCI support for the Pb1000 board was ectomized by Pete Popov four years ago.
> Unfortunately,  the header file  wasn't cleansed, so the remnants still get
> in the way of the kernel build (due to macro redefinitions).
> 
> Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

Thanks, applied.

  Ralf
