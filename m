Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 05 Sep 2007 06:49:05 +0100 (BST)
Received: from mail.windriver.com ([147.11.1.11]:37326 "EHLO mail.wrs.com")
	by ftp.linux-mips.org with ESMTP id S20022061AbXIEFs4 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 5 Sep 2007 06:48:56 +0100
Received: from ALA-MAIL03.corp.ad.wrs.com (ala-mail03 [147.11.57.144])
	by mail.wrs.com (8.13.6/8.13.6) with ESMTP id l855mTZn001585;
	Tue, 4 Sep 2007 22:48:29 -0700 (PDT)
Received: from ala-mail06.corp.ad.wrs.com ([147.11.57.147]) by ALA-MAIL03.corp.ad.wrs.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Tue, 4 Sep 2007 22:48:29 -0700
Received: from [128.224.162.180] ([128.224.162.180]) by ala-mail06.corp.ad.wrs.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Tue, 4 Sep 2007 22:48:28 -0700
Subject: Re: [PATCH] malta4kec hang in calibrate_delay fix
From:	yshi <yang.shi@windriver.com>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	linux-mips@linux-mips.org
In-Reply-To: <20070904124444.GB23736@linux-mips.org>
References: <46DD1CD1.5040306@windriver.com>
	 <20070904124444.GB23736@linux-mips.org>
Content-Type: text/plain; charset=utf-8
Date:	Wed, 05 Sep 2007 13:51:23 +0800
Message-Id: <1188971483.4145.17.camel@yshi.CORP>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.0 
Content-Transfer-Encoding: 8BIT
X-OriginalArrivalTime: 05 Sep 2007 05:48:28.0634 (UTC) FILETIME=[623C9BA0:01C7EF80]
Return-Path: <Yang.Shi@windriver.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16386
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yang.shi@windriver.com
Precedence: bulk
X-list: linux-mips

在 2007-09-04二的 13:44 +0100，Ralf Baechle写道：
> On Tue, Sep 04, 2007 at 04:52:33PM +0800, yshi wrote:
> 
> > perfmon2 patch changed timer interrupt handler of malta board.
> > When kernel handles timer interrupt, interrupt handler will read 30 bit
> > of cause register. If this bit is zero, timer interrupt handler will
> > exit, won't really handle interrupt. Because Malta 4kec board's core
> > revision is CoreFPGA-3, this core's cause register doesn't implement 30
> > bit, so kernel always read zero from this bit. This will cause kernel
> > hang in calibrate_delay.
> 
> You seem to have defined cpu_has_mips_r2 as 1 in your cpu_features_override.h
> file.  Classic cut'n'paste error I'd guess :-)
I double checked the revision of this board's core. The core is Release
2(cpu_has_mips_r2 is 0x40). So I enabled Release 2 in kernel config. But
kernel still hangs in calibrate_delay. 

I investigated this problem further and found IntCtl register's value is
always zero! So this cause that kernel registers timer interrupt handler
to the wrong IRQ number, because kernel read IntCtl.IPTI bits to
determine timer IRQ number. If I use default IRQ number, kernel will
works well. I printed my board information from YAMON as follows:

Compilation time =              Jul  4 2006  17:12:50
Board type/revision =           0x02 (Malta) / 0x00
Core board type/revision =      0x09 (CoreFPGA-3) / 0x01
System controller/revision =    MIPS SOC-it 101 EC-32 / 1.3  SDR-FW-1:1
FPGA revision =                 0x0001
MAC address =                   00.d0.a0.00.04.e1
Board S/N =                     0000000961
PCI bus frequency =             25 MHz
Processor Company ID/options =  0x01 (MIPS Technologies, Inc.) / 0x00
Processor ID/revision =         0x90 (MIPS 4KEc) / 0x68
Endianness =                    Big
CPU/Bus frequency =             33 MHz / 33 MHz
Flash memory size =             4 MByte
SDRAM size =                    32 MByte
First free SDRAM address =      0x800b6980

According MIPS32 Release 2 specification, IntCtl.IPTI bits should not be
zero, at least 2 and it's readonly. So, is my board defective or an old
version? Thanks.

Best Regards,
Yang Shi
> 
>   Ralf
