Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 18 Jan 2008 23:21:10 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:45028 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S28575202AbYARXVH (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 18 Jan 2008 23:21:07 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id m0INKs11026393;
	Fri, 18 Jan 2008 23:20:57 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id m0INKluf026391;
	Fri, 18 Jan 2008 23:20:47 GMT
Date:	Fri, 18 Jan 2008 23:20:47 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Jeff Garzik <jeff@garzik.org>
Cc:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>, linux-mips@linux-mips.org
Subject: Re: [PATCH] tc35815: Use irq number for tc35815-mac platform
	device id
Message-ID: <20080118232047.GA23265@linux-mips.org>
References: <20080119.011552.41196389.anemo@mba.ocn.ne.jp> <479105DE.4040407@garzik.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <479105DE.4040407@garzik.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18098
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, Jan 18, 2008 at 03:02:38PM -0500, Jeff Garzik wrote:

> Atsushi Nemoto wrote:
>> The tc35815-mac platform device used a pci bus number and a devfn to
>> identify its target device, but the pci bus number may vary if some
>> bus-bridges are found.  Use irq number which is be unique for embedded
>> controllers.
>>
>> Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
>> ---
>>  arch/mips/tx4938/toshiba_rbtx4938/setup.c |    4 ++--
>>  drivers/net/tc35815.c                     |    2 +-
>>  2 files changed, 3 insertions(+), 3 deletions(-)
>
> ACK, Ralf please apply through your tree...

Done.  Thanks Atsushi,

  Ralf
