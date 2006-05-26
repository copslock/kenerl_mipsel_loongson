Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 26 May 2006 03:38:58 +0200 (CEST)
Received: from mo32.po.2iij.net ([210.128.50.17]:26131 "EHLO mo32.po.2iij.net")
	by ftp.linux-mips.org with ESMTP id S8134097AbWEZBiu (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 26 May 2006 03:38:50 +0200
Received: by mo.po.2iij.net (mo32) id k4Q1chaG083360; Fri, 26 May 2006 10:38:43 +0900 (JST)
Received: from localhost.localdomain (65.126.232.202.bf.2iij.net [202.232.126.65])
	by mbox.po.2iij.net (mbox33) id k4Q1ce6D051452
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Fri, 26 May 2006 10:38:40 +0900 (JST)
Date:	Fri, 26 May 2006 10:38:40 +0900
From:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
To:	"Roman Mashak" <mrv@corecom.co.kr>
Cc:	linux-mips@linux-mips.org
Subject: Re: booting with NFS root
Message-Id: <20060526103840.79fe5ec5.yoichi_yuasa@tripeaks.co.jp>
In-Reply-To: <001101c6805e$4c4f62b0$9d0ba8c0@mrv>
References: <001101c6805e$4c4f62b0$9d0ba8c0@mrv>
Organization: TriPeaks Corporation
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yoichi_yuasa@tripeaks.co.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11553
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yoichi_yuasa@tripeaks.co.jp
Precedence: bulk
X-list: linux-mips

Hi,

On Fri, 26 May 2006 09:49:50 +0900
"Roman Mashak" <mrv@corecom.co.kr> wrote:

> Hello!
> 
> I have evaluation board from PMC-sierra, their CPU is using E9000 core. 
> Kernel (2.4.26), root FS are provided by them. I set up NFS and TFTP servers 
> on my linux box, kernel loads into board but fails to boot woth the 
> following message (I skipped some lines of kernel):
> 
<snip>
> Freeing unused kernel memory: 104k freed
> do_cpu invoked from kernel context! in traps.c::do_cpu, line 676:

This error is coprocessor unusable exception.

> $0 : 00000000 9004a000 2ab03fe0 2ab03fe0 2ab01560 00000000 00000ae0 00000ae0
> $8 : 00000020 2ab01fe0 2ab01520 00001000 00000019 00000080 811d7b18 00000c62
> $16: 2ab010c0 811d7c58 87f8cfe0 00000003 00000080 2ab01520 87f841a0 00000001
> $24: 00000000 00000080                   811d6000 811d7ba0 2aaa8000 8015f414
> Hi : 00000000
> Lo : 00000000
> epc   : 80256e14    Not tainted

The exception program counter is 0x80256e14 .
You can check instructions(0x80256e14 and before) in your kernel object.

> Status: 9004a003
> Cause : 1000002c
> PrId  : 000034c1
> Process init (pid: 1, stackpage=811d6000)
> Stack:    8015f8a8 8015f9a8 87f71180 8012b2fc 00000000 80135330 00002012
>  00000019 87f8cf60 2ab019e4 00000004 00002012 000590c0 2ab01000 10000000
>  811d7d88 87ff5740 00000000 811d7ef8 81164e80 00000000 00000002 87f841a0
>  8015ffd8 811d7c20 811d6000 811d7cbc 801975a4 00006012 0000000a 811d7c18
>  811d7c18 7f454c46 01020100 00000000 00000000 00020008 00000001 00401980
>  00000034 ...
> Call Trace:   [<8015f8a8>] [<8015f9a8>] [<8012b2fc>] [<80135330>] 
> [<8015ffd8>]
>  [<801975a4>] [<8015fbc0>] [<801493ac>] [<801007b8>] [<8014889c>] 
> [<801495bc>]
>  [<801495a8>] [<801007b8>] [<80108f80>] [<801007b8>] [<8014fcc4>] 
> [<801095c0>]
>  [<8025ad30>] [<801007b8>] [<8025ad30>] [<8014af50>] [<801007b8>] 
> [<80117888>]
>  [<801194a0>] [<80100884>] [<801007b8>] [<8010079c>] [<8025de14>] 
> [<80104320>]
>  [<80117aec>] [<8026b7a8>] [<801b2054>] [<80104310>]
> 
> Code: 30c8003c  01244821  24840040 <ac85ffc0> ac85ffc4  ac85ffc8  ac85ffcc 
> ac85ffd0  ac85ffd4
> Kernel panic: Attempted to kill init!
> =====================
> 
> I load kernel with the following parameters:
> tftp://192.168.11.43/vmlinux ip=192.168.11.42 root=/dev/nfs 
> nfsroot=192.168.11.43:/export/linux/mips-fs-be
> 
> What may be the problem here?
> 
> Thanks in advance!
> 
> With best regards, Roman Mashak.  E-mail: mrv@corecom.co.kr 
> 

Yoichi
