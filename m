Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 21 Mar 2006 13:26:35 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:21929 "EHLO bacchus.dhis.org")
	by ftp.linux-mips.org with ESMTP id S8133448AbWCUN0Y (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 21 Mar 2006 13:26:24 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by bacchus.dhis.org (8.13.4/8.13.4) with ESMTP id k2LDa9B1012699;
	Tue, 21 Mar 2006 13:36:09 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.4/8.13.4/Submit) id k2LDa9a7012698;
	Tue, 21 Mar 2006 13:36:09 GMT
Date:	Tue, 21 Mar 2006 13:36:09 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	colin <colin@realtek.com.tw>
Cc:	linux-mips@linux-mips.org
Subject: Re: uptime is too high. Is it normal?
Message-ID: <20060321133609.GA12502@linux-mips.org>
References: <009101c64ce4$72d78820$106215ac@realtek.com.tw> <20060321125255.GA8779@linux-mips.org> <00a101c64ce9$554b3180$106215ac@realtek.com.tw>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <00a101c64ce9$554b3180$106215ac@realtek.com.tw>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10896
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Mar 21, 2006 at 09:14:06PM +0800, colin wrote:

>   646 root            DW  [646]
>   647 root            DW  [647]
> 
> The uptime value keeps on going higher and higher.
> It seems that both 646 & 647 process has the same parent "1".
> Their "utime" are "0".

Yes, these two are the offenders.  A process should never be for a long
time in "D" state.  You'll have to figure out what these processes are
doing, but they something wrong with these two.

The load average btw is a fairly artificial meassure.  On a properly
working system it describes the burn of the workload of the system
reasonably well - but if things go wrong and cause processes to get
stuck in D state (aka uninterruptible sleep) then a system may well
still be perfectly responsive even though the load is very high.

  Ralf
