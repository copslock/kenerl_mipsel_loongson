Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 08 Sep 2006 11:59:22 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:45448 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20037675AbWIHK7U (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 8 Sep 2006 11:59:20 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.13.7/8.13.7) with ESMTP id k88Axsm0021219;
	Fri, 8 Sep 2006 12:59:54 +0200
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.7/8.13.7/Submit) id k88Axrj7021218;
	Fri, 8 Sep 2006 12:59:53 +0200
Date:	Fri, 8 Sep 2006 12:59:53 +0200
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Kaz Kylheku <kaz@zeugmasystems.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: 64-bit 2.6.17.7 SMP hangs in __cpu_up().
Message-ID: <20060908105953.GA1555@linux-mips.org>
References: <66910A579C9312469A7DF9ADB54A8B7D390152@exchange.ZeugmaSystems.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <66910A579C9312469A7DF9ADB54A8B7D390152@exchange.ZeugmaSystems.local>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12539
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Sep 07, 2006 at 04:25:51PM -0700, Kaz Kylheku wrote:

> Anyone seen anything like this?
> 
> Execution does not get past the loop:
> 
>   while (!cpu_isset(cpu, cpu_callin_map))
>     udelay(100);
> 
> The other CPU is not coming up.
> 
> 32 bit SMP works fine.

Interesting because the 64-bit kernel is considered bettere tested on
Sibyte chips than 32-bit these days.

Not a problem I was aware of.

  Ralf
