Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 21 Mar 2006 12:43:21 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:56522 "EHLO bacchus.dhis.org")
	by ftp.linux-mips.org with ESMTP id S8133416AbWCUMnL (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 21 Mar 2006 12:43:11 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by bacchus.dhis.org (8.13.4/8.13.4) with ESMTP id k2LCqvCt008849;
	Tue, 21 Mar 2006 12:52:57 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.4/8.13.4/Submit) id k2LCqtBE008848;
	Tue, 21 Mar 2006 12:52:55 GMT
Date:	Tue, 21 Mar 2006 12:52:55 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	colin <colin@realtek.com.tw>
Cc:	linux-mips@linux-mips.org
Subject: Re: uptime is too high. Is it normal?
Message-ID: <20060321125255.GA8779@linux-mips.org>
References: <009101c64ce4$72d78820$106215ac@realtek.com.tw>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <009101c64ce4$72d78820$106215ac@realtek.com.tw>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10894
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Mar 21, 2006 at 08:39:08PM +0800, colin wrote:

> Hi all,
> We use MIPS Linux+uClibc0.9.28+busybox 1.1.0 on our machine.
> After use "uptime" to get the loading of device, it shows: 
>     03:50:05 up  3:50, load average: 2.00, 2.00, 2.00
> Is it normal? It seems too high because my PC Linux has a much lower value:
>     20:38:31 up 12 days,  5:11,  5 users,  load average: 0.04, 0.01, 0.00

Well, check with ps what is causing the load.  Look for processes in
either 'D' or 'R' state.

  Ralf
