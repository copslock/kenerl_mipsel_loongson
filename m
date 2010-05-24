Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 24 May 2010 14:44:46 +0200 (CEST)
Received: from bby1mta02.pmc-sierra.com ([216.241.235.117]:40928 "EHLO
        bby1mta02.pmc-sierra.bc.ca" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491912Ab0EXMon convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 24 May 2010 14:44:43 +0200
Received: from bby1mta02.pmc-sierra.bc.ca (localhost.pmc-sierra.bc.ca [127.0.0.1])
        by localhost (Postfix) with SMTP id 9645B8E005B;
        Mon, 24 May 2010 05:44:25 -0700 (PDT)
Received: from bby1exg02.pmc_nt.nt.pmc-sierra.bc.ca (BBY1EXG02.pmc-sierra.bc.ca [216.241.231.167])
        by bby1mta02.pmc-sierra.bc.ca (Postfix) with SMTP id 8960D8E0056;
        Mon, 24 May 2010 05:44:25 -0700 (PDT)
Received: from BBY1EXM11.pmc_nt.nt.pmc-sierra.bc.ca ([216.241.231.157]) by bby1exg02.pmc_nt.nt.pmc-sierra.bc.ca with Microsoft SMTPSVC(6.0.3790.4675);
         Mon, 24 May 2010 05:44:25 -0700
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
        charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
Subject: Kernel unaligned access
Date:   Mon, 24 May 2010 05:44:23 -0700
Message-ID: <A7DEA48C84FD0B48AAAE33F328C0201404E2D299@BBY1EXM11.pmc_nt.nt.pmc-sierra.bc.ca>
In-Reply-To: <20100524173624.2d3ffc3d.yuasa@linux-mips.org>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Kernel unaligned access
Thread-Index: Acr7HIZJTiXFOjN2TcOArJ3H7VCcWAAILJ+A
References: <20100524173624.2d3ffc3d.yuasa@linux-mips.org>
From:   "Anoop P.A." <Anoop_P.A@pmc-sierra.com>
To:     "linux-mips" <linux-mips@linux-mips.org>
Cc:     "Ralf Baechle" <ralf@linux-mips.org>
X-OriginalArrivalTime: 24 May 2010 12:44:25.0532 (UTC) FILETIME=[D77D07C0:01CAFB3E]
Return-Path: <Anoop_P.A@pmc-sierra.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26831
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Anoop_P.A@pmc-sierra.com
Precedence: bulk
X-list: linux-mips

Hi list,

I am trying to run 32 bit RFS with a 64 bit kernel on a RM9000 based
processor board. The board is equipped with 2 GB DIMM.  When ever I
initiate ftp transfer of 1 GB file I am getting following unaligned
access error

ftp> get 1gfile
local: 1gfile remote: 1gfile
200 PORT command successful. Consider using PASV.
150 Opening BINARY mode data connection for 1gfile (1024000000 bytes).
Unhandled kernel unaligned access[#1]:
Cpu 0
$ 0   : 0000000000000000 ffffffff804c7710 0000000000000000
0000000000000000
$ 4   : 9a5d9c1483fa8a60 ffffffffdc620000 0000000000000000
ffffffff8017f1f8
$ 8   : ffffffffdc620000 9800000001fd7ce0 980000003fa3e310
980000003fa3e3b0
$12   : ffffffff9400e0e0 000000001000001e 0000000000000000
ffffffff8055c000
$16   : 980000003fe16560 9800000001fd7ce0 980000003fe07810
0000000000000000
$20   : 0000000000000070 0000000000000038 0000000000200200
0000000000100100
$24   : 0000000000000000 000000002ad6afd8
$28   : 9800000001fd4000 9800000001fd7cb0 6800000000000000
ffffffff801041c0
Hi    : 0000000000000000
Lo    : 025d9c1482fa8a60
epc   : ffffffff8010b904 do_ade+0x1c4/0x470     Not tainted
ra    : ffffffff801041c0 handle_adel_int+0x28/0x48
Status: 9400e0e2    KX SX UX KERNEL EXL
Cause : 00000010
BadVA : 9a5d9c1483fa8a60
PrId  : 000034c1
Modules linked in: e1000 aoe bonding block2mtd
Process events/0 (pid: 4, threadinfo=9800000001fd4000,
task=9800000001fc0648)
Stack : 0000000000000000 980000003fe16560 0000000000000000
980000003fe07810
        980000003fe16570 ffffffff801041c0 0000000000000000
ffffffff80820000
        025d9c1482fa8a60 9a5d9c1483fa8a60 450805dc47954000
980000003fe07810
        0000000000000070 0000000000000010 0000000000000000
980000003f9ff440
        980000003fa3e310 980000003fa3e3b0 9800000001fd7fe0
000000000000e000
        0000000000000000 ffffffff8055c000 980000003fe16560
0000000000000000
        980000003fe07810 980000003fe16570 0000000000000070
0000000000000038
        0000000000200200 0000000000100100 0000000000000000
000000002ad6afd8
        9800000022ddf020 0000000000000000 9800000001fd4000
9800000001fd7e10
        6800000000000000 ffffffff8017f584 ffffffff9400e0e2
0000000000000000
        ...
Call Trace:
[<ffffffff8010b904>] do_ade+0x1c4/0x470
[<ffffffff801041c0>] handle_adel_int+0x28/0x48


Code: 00431024  5440005f  de220100 <68830000> 6c830007  24020000
08042e1d  00000000  3042001f

FTP of smaller files ( ~100MB) works without any issues.

If I limit memory size to 512MB from command line, ftp transfer of
bigger files works as expected.

Kindly help me with your pointers to debug the issue. I am running
2.6.18 kernel.

Thanks
Anoop  
