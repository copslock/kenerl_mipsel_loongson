Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 04 Sep 2007 15:04:54 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:56750 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20024705AbXIDOEw (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 4 Sep 2007 15:04:52 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id l84E4pBk005638;
	Tue, 4 Sep 2007 15:04:51 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id l84E4oGW005637;
	Tue, 4 Sep 2007 15:04:50 +0100
Date:	Tue, 4 Sep 2007 15:04:50 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Maxime Bizon <mbizon@freebox.fr>
Cc:	linux-mips@linux-mips.org
Subject: Re: Suspicious test in dma-default.c
Message-ID: <20070904140450.GA5624@linux-mips.org>
References: <1188550994.29619.10.camel@sakura.staff.proxad.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1188550994.29619.10.camel@sakura.staff.proxad.net>
User-Agent: Mutt/1.5.14 (2007-02-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16381
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, Aug 31, 2007 at 11:03:14AM +0200, Maxime Bizon wrote:

> I don't know exactly why cpu_is_noncoherent_r10000() is needed, but the
> test looks wrong:
> 
> 	return !plat_device_is_coherent(dev) &&
> 	       (current_cpu_data.cputype == CPU_R10000 &&
> 	       current_cpu_data.cputype == CPU_R12000);

I guess a processor need to be quite shizophrenic to pass this test ;-)

Patch applied, thanks.

  Ralf
