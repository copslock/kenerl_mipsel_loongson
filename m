Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 06 Feb 2006 01:29:36 +0000 (GMT)
Received: from mail.renesas.com ([202.234.163.13]:47506 "EHLO
	mail04.idc.renesas.com") by ftp.linux-mips.org with ESMTP
	id S8133565AbWBFB3Y (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 6 Feb 2006 01:29:24 +0000
Received: from mail04.idc.renesas.com ([127.0.0.1])
 by mail04.idc.renesas.com. (SMSSMTP 4.1.9.35) with SMTP id M2006020610344704680
 for <linux-mips@linux-mips.org>; Mon, 06 Feb 2006 10:34:47 +0900
Received: (from root@localhost)
	by guardian04.idc.renesas.com with  id k161YjTT025197;
	Mon, 6 Feb 2006 10:34:45 +0900 (JST)
Received: from unknown [172.20.8.73] by guardian04.idc.renesas.com with SMTP id LAA25196 ; Mon, 6 Feb 2006 10:34:45 +0900
Received: from mrkaisv.hoku.renesas.com ([10.145.105.245])
	by ml01.idc.renesas.com (8.12.10/8.12.10) with ESMTP id k161YhdI011969;
	Mon, 6 Feb 2006 10:34:44 +0900 (JST)
Received: from localhost (pcepx10 [10.145.105.241])
	by mrkaisv.hoku.renesas.com (Postfix) with ESMTP
	id 7E45D798071; Mon,  6 Feb 2006 10:34:43 +0900 (JST)
Date:	Mon, 06 Feb 2006 10:34:43 +0900 (JST)
Message-Id: <20060206.103443.608416320.takata.hirokazu@renesas.com>
To:	rmk+lkml@arm.linux.org.uk
Cc:	takata@linux-m32r.org, linux-kernel@vger.kernel.org,
	linux-mips@linux-mips.org, linuxppc-dev@ozlabs.org, pfg@sgi.com
Subject: Re: [CFT] Don't use ASYNC_* nor SERIAL_IO_* with serial_core
From:	Hirokazu Takata <takata@linux-m32r.org>
In-Reply-To: <20060205000136.GF24887@flint.arm.linux.org.uk>
References: <20060202102721.GE5034@flint.arm.linux.org.uk>
	<20060202.231033.1059963967.takata.hirokazu@renesas.com>
	<20060205000136.GF24887@flint.arm.linux.org.uk>
X-Mailer: Mew version 3.3 on XEmacs 21.4.18 (Social Property)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <takata@linux-m32r.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10338
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: takata@linux-m32r.org
Precedence: bulk
X-list: linux-mips

From: Russell King <rmk+lkml@arm.linux.org.uk>
Subject: Re: [CFT] Don't use ASYNC_* nor SERIAL_IO_* with serial_core
Date: Sun, 05 Feb 2006 00:01:36 +0000
> On Thu, Feb 02, 2006 at 11:10:33PM +0900, Hirokazu Takata wrote:
> > On m32r,
> >   compile and boot test: OK
> 
> Is that an Acked-by ?
> 
> -- 
> Russell King
>  Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
>  maintainer of:  2.6 Serial core
> 

Yes.

Acked-by: Hirokazu Takata <takata@linux-m32r.org>

Thanks,
--
Hirokazu Takata <takata@linux-m32r.org>
Linux/M32R Project:  http://www.linux-m32r.org/
