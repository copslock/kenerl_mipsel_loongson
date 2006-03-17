Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 17 Mar 2006 13:38:43 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:28141 "EHLO bacchus.dhis.org")
	by ftp.linux-mips.org with ESMTP id S8133417AbWCQNic (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 17 Mar 2006 13:38:32 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by bacchus.dhis.org (8.13.4/8.13.4) with ESMTP id k2HDlsPN007440;
	Fri, 17 Mar 2006 13:47:54 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.4/8.13.4/Submit) id k2H9kCeM032294;
	Fri, 17 Mar 2006 09:46:12 GMT
Date:	Fri, 17 Mar 2006 09:46:12 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Gowri Satish Adimulam <gowri@bitel.co.kr>
Cc:	linux-mips@linux-mips.org
Subject: Re: vsftp  -- ping ( two problems)
Message-ID: <20060317094612.GA30947@linux-mips.org>
References: <441A1D53.6080305@fortresstech.com> <1142579486.3332.9.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1142579486.3332.9.camel@localhost.localdomain>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10831
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, Mar 17, 2006 at 04:11:26PM +0900, Gowri Satish Adimulam wrote:

> I have two problems 
> 
> a. i have added icmp.c to the kernel 2.6.14 (mips).
> 
>   i have connected a cross cable to pc , IAM ABLE TO PING THE MIPS
> target board from pc , but in target even self ping is not responding.

Sounds like you didn't configure the loopback interface.

> b. i would like to add ftpserver to the target , i confused where to add
> in kernel space or userspace.

This absolutely belongs into userspace.

  Ralf
