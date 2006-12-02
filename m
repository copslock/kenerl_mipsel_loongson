Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 02 Dec 2006 02:51:18 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:33209 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20038482AbWLBCvR (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sat, 2 Dec 2006 02:51:17 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.13.8/8.13.8) with ESMTP id kB22O6hD029741;
	Sat, 2 Dec 2006 02:24:06 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.8/8.13.8/Submit) id kB22O4su029740;
	Sat, 2 Dec 2006 02:24:04 GMT
Date:	Sat, 2 Dec 2006 02:24:04 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Kaz Kylheku <kaz@zeugmasystems.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: N32 shmat problem identified! Kernel fix needed.
Message-ID: <20061202022404.GA28637@linux-mips.org>
References: <66910A579C9312469A7DF9ADB54A8B7D4B5F5F@exchange.ZeugmaSystems.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <66910A579C9312469A7DF9ADB54A8B7D4B5F5F@exchange.ZeugmaSystems.local>
User-Agent: Mutt/1.4.2.2i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13322
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, Dec 01, 2006 at 04:33:16PM -0800, Kaz Kylheku wrote:

> The function named sys32_shmat has no reason to exist, and is broken. It
> assumes that user space has passed a pointer to the location where the
> resulting pointer should be stored. But that is not the shmat API, and
> glibc will pass no such parameter. So a null dereference results,
> leading to EFAULT.
> 
> The fix is to remove this function from the code base and quite simply
> to wire the normal sys_shmat into the n32 syscall table. Since there is
> in fact no pointer-to-pointer argument, this function doesn't have a 32
> bit compatibility issues.

That's fixed since two months.

  Ralf
