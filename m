Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 05 Feb 2003 00:36:28 +0000 (GMT)
Received: from gtwy.nap.wideopenwest.com ([IPv6:::ffff:64.233.207.11]:7293
	"EHLO pop-1.dnv.wideopenwest.com") by linux-mips.org with ESMTP
	id <S8225240AbTBEAg1> convert rfc822-to-8bit; Wed, 5 Feb 2003 00:36:27 +0000
Received: from localhost.localdomain (s233-106-251.nap.wideopenwest.com [64.233.251.106])
	by pop-1.dnv.wideopenwest.com (8.11.6/8.11.6) with ESMTP id h150fUx19227
	for <linux-mips@linux-mips.org>; Tue, 4 Feb 2003 18:41:30 -0600
Content-Type: text/plain;
  charset="us-ascii"
From: Jason Ormes <jormes@wideopenwest.com>
Reply-To: jormes@wideopenwest.com
To: linux-mips@linux-mips.org
Subject: kernel boot error.
Date: Tue, 4 Feb 2003 18:41:10 -0600
User-Agent: KMail/1.4.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200302041841.10507.jormes@wideopenwest.com>
Return-Path: <jormes@wideopenwest.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1320
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jormes@wideopenwest.com
Precedence: bulk
X-list: linux-mips

hello,

can someone help me with this error?  Is this because the network failed?

scsi0 : QLogic ISP1020 SCSI on PCI bus 00 device 00 irq 4 I/O base 0x8200000
scsi1 : QLogic ISP1020 SCSI on PCI bus 00 device 08 irq 5 I/O base 0x8400000
eth0: Auto-Negotiation unsuccessful, trying force link mode
Slice A got dbe at 0xffffffff801882fc
Hub information:
ERR_INT_PEND = 0x200100
Hub has valid error information:
Overrun is set.  Error stack may contain additional information.
Hub error address is 02400208
Incoming message command 0x9e
Supplemental field of incoming message is 0x7f8
T5 Rn (for RRB only) is 0x0
Error type is Uncached Partial Read PRERR
Cpu 0
$0      : 0000000000000000 0000000014001ce0 a8000000013b1040 a8000000013b1000
$4      : a8000000013b1080 0000000000000000 0000000000000040 ffffffff80284688
$8      : 0000000014001ce1 0000000000000000 a8000000012d3c70 0000000000000004
$12     : 0000000000000000 a8000000013b1080 a8000000012d3c80 ffffffff8026e468
$16     : a8000000013b1040 0000000000000002 a8000000013b0400 a8000000003840c0
$20     : a800000000384000 0000000000000040 0000000000000001 a8000000013a7e00
$24     : 0000000000000040 0000000000000020
$28     : a8000000012d0000 a8000000012d3af0 0000000000000000 ffffffff8010ecd8
Hi      : 0000000000000000
Lo      : 0000000000000040
epc     : ffffffff801882fc    Not tainted
badvaddr: 0000000000000000
Status  : 14001ce2  [ KX SX UX KERNEL EXL ]
Cause   : 0000901c
Index:  0 pgmask=4kb va=c0000fff80000000 asid=00
        [pa=00000000000 c=0 d=0 v=0 g=0] [pa=00000000000 c=0 d=0 v=0 g=0]
Index:  1 pgmask=4kb va=c0000fff80000000 asid=00
        [pa=00000000000 c=0 d=0 v=0 g=0] [pa=00000000000 c=0 d=0 v=0 g=0]
Index:  2 pgmask=4kb va=c0000fff80000000 asid=00
        [pa=00000000000 c=0 d=0 v=0 g=0] [pa=00000000000 c=0 d=0 v=0 g=0]
Index:  3 pgmask=4kb va=c0000fff80000000 asid=00
        [pa=00000000000 c=0 d=0 v=0 g=0] [pa=00000000000 c=0 d=0 v=0 g=0]
Index:  4 pgmask=4kb va=c0000fff80000000 asid=00
        [pa=00000000000 c=0 d=0 v=0 g=0] [pa=00000000000 c=0 d=0 v=0 g=0]
Index:  5 pgmask=4kb va=c0000fff80000000 asid=00
        [pa=00000000000 c=0 d=0 v=0 g=0] [pa=00000000000 c=0 d=0 v=0 g=0]
Index:  6 pgmask=4kb va=c0000fff80000000 asid=00
        [pa=00000000000 c=0 d=0 v=0 g=0] [pa=00000000000 c=0 d=0 v=0 g=0]
Index:  7 pgmask=4kb va=c0000fff80000000 asid=00
        [pa=00000000000 c=0 d=0 v=0 g=0] [pa=00000000000 c=0 d=0 v=0 g=0]
Index:  8 pgmask=4kb va=c0000fff80000000 asid=00
        [pa=00000000000 c=0 d=0 v=0 g=0] [pa=00000000000 c=0 d=0 v=0 g=0]
Index:  9 pgmask=4kb va=c0000fff80000000 asid=00
        [pa=00000000000 c=0 d=0 v=0 g=0] [pa=00000000000 c=0 d=0 v=0 g=0]
Index: 10 pgmask=4kb va=c0000fff80000000 asid=00
        [pa=00000000000 c=0 d=0 v=0 g=0] [pa=00000000000 c=0 d=0 v=0 g=0]
Index: 11 pgmask=4kb va=c0000fff80000000 asid=00


Jason Ormes
