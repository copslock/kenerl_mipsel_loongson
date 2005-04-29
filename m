Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 29 Apr 2005 14:52:36 +0100 (BST)
Received: from rwcrmhc13.comcast.net ([IPv6:::ffff:204.127.198.39]:26512 "EHLO
	rwcrmhc13.comcast.net") by linux-mips.org with ESMTP
	id <S8225807AbVD2NwU>; Fri, 29 Apr 2005 14:52:20 +0100
Received: from ba3pi (pcp0010731669pcs.howard01.md.comcast.net[69.243.71.130])
          by comcast.net (rwcrmhc13) with SMTP
          id <20050429135212015004nk7re>; Fri, 29 Apr 2005 13:52:12 +0000
From:	"Bryan Althouse" <bryan.althouse@3phoenix.com>
To:	"'Ralf Baechle'" <ralf@linux-mips.org>
Cc:	<linux-mips@linux-mips.org>
Subject: RE: your mail (yosemite + 2.6.x issues)
Date:	Fri, 29 Apr 2005 09:52:05 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.6353
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
In-Reply-To: <20050429110258.GE5951@linux-mips.org>
Thread-Index: AcVMqxJLo5JlAej0RIyD3aq2o/pxFgAFMaRw
Message-Id: <20050429135220Z8225807-1340+6357@linux-mips.org>
Return-Path: <bryan.althouse@3phoenix.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7838
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: bryan.althouse@3phoenix.com
Precedence: bulk
X-list: linux-mips

Thanks Ralf, now I can compile the kernel.  But, I don't get any serial
console output when I try to boot it.  Actually, I get a single line that
looks like this:

Loading file: tftp://192.168.2.39/vmlinux (elf)
0x80100000/2288188 + 0x8032ea3c/111372(z) + 4125 syms|

I have found PMC's "yosemite_defconfig" file and I am using it as the
".config". I have tried using CONFIG_PMC_INTERNAL_UART=y and I have also
tried commenting it out.  Either way, I get no console output.

Thanks for the help!
Bryan

-----Original Message-----
From: Ralf Baechle [mailto:ralf@linux-mips.org] 
Sent: Friday, April 29, 2005 7:03 AM
To: Bryan Althouse
Cc: linux-mips@linux-mips.org; TheNop@gmx.net
Subject: Re: your mail

On Thu, Apr 28, 2005 at 03:15:49PM -0400, Bryan Althouse wrote:

> I would like to use a 2.6.x kernel with my Yosemite/HalfDome board.
> Somehow, I am unable to compile the kernel.  I have tried the 2.6.10
kernel
> trees from ftp.pmc-sierra.com and also the latest 2.6.12 snapshot from
> linux-mips.  I am using the 3.3.x cross compile tools from
> ftp.pmc-sierra.com .  The 2.4.x kernels from PMC compile fine.
> 
> In the case of 2.6.10 from ftp.pmc-sierra.com, my error looks like:
>        Make[3]: *** [drivers/char/agp/backend.o] Error 1

Configuring AGP support for a MIPS kernel is obviously nonsense.  Disable
CONFIG_AGP.

> In the case of 2.6.12 from linux-mips, my error looks like:
> 	drivers/net/titan_ge.c1950: error: 'titan_device_remove"  undeclared
> here (not in a function)

Whoops, a bug.  The function indeed doesn't exist even though it should,
will fix that.  You will hit this bug only if compiling the titan driver
as a module, so workaround set CONFIG_TITAN_GE=y.  Which for the typical
titan-based device seems to be the preferable choice anyway.

  Ralf
