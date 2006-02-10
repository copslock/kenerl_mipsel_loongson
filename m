Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 10 Feb 2006 17:09:20 +0000 (GMT)
Received: from wf1.mips-uk.com ([194.74.144.154]:54474 "EHLO bacchus.dhis.org")
	by ftp.linux-mips.org with ESMTP id S8133472AbWBJRJM (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 10 Feb 2006 17:09:12 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by bacchus.dhis.org (8.13.4/8.13.4) with ESMTP id k1AHEKjg004941;
	Fri, 10 Feb 2006 17:14:20 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.4/8.13.4/Submit) id k1AHEKR2004940;
	Fri, 10 Feb 2006 17:14:20 GMT
Date:	Fri, 10 Feb 2006 17:14:20 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Thomas Koeller <thomas.koeller@baslerweb.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH] RM9000 icache problem
Message-ID: <20060210171420.GC32721@linux-mips.org>
References: <200602101736.27563.thomas.koeller@baslerweb.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200602101736.27563.thomas.koeller@baslerweb.com>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10395
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, Feb 10, 2006 at 05:36:27PM +0100, Thomas Koeller wrote:

> The code to work around the RM9000 icache problems is wrong and
> ineffective. The patch below fixes that.

Ah, indeed.  Hand applied, as your patch does not apply to the latest
kernel.

Thanks,

  Ralf
