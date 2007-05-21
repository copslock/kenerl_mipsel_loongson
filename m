Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 21 May 2007 23:16:58 +0100 (BST)
Received: from 67-129-173-13.dia.static.qwest.net ([67.129.173.13]:16262 "EHLO
	alfalfa.fortresstech.com") by ftp.linux-mips.org with ESMTP
	id S20024381AbXEUWQy (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 21 May 2007 23:16:54 +0100
Received: from [172.26.71.3] ([172.26.71.3]) by alfalfa.fortresstech.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Mon, 21 May 2007 18:16:26 -0400
Message-ID: <46521A3F.6060107@sneakemail.com>
Date:	Mon, 21 May 2007 18:16:31 -0400
From:	Marco <u070z5w02@sneakemail.com>
User-Agent: Icedove 1.5.0.9 (X11/20061220)
MIME-Version: 1.0
To:	linux-mips@linux-mips.org
Subject: duplicate tlb entries
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 21 May 2007 22:16:26.0850 (UTC) FILETIME=[AC9B4C20:01C79BF5]
Return-Path: <u070z5w02@sneakemail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15119
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: u070z5w02@sneakemail.com
Precedence: bulk
X-list: linux-mips

Hello,

Could anyone tell me if the following dump_tlb_all() is valid?  I see a 
few duplicate tlb entries, which I'm under the impression is not a good 
thing.  Unfortunately, I haven't been able to figure it out from my 
investigating.  I'm using a Mips32/r4000-style TLB setup with 2.6.16.18.

I did the dump below during a squashfs error I was experiencing.

Also please note I commented out
       if ((entryhi & 0xf0000000) != 0x80000000
            && (entryhi & 0xff) == asid) {
which normally suppresses some of the output so every tlb entry would be 
dumped.


Heres dump_tlb_all() output slightly modified and sorted on va for 
readability.

Index: 27 pgmask=4kb <3>va=00400000 asid=5f [pa=014f3000  c=3 d=0 v=1 
g=0] [pa=014f4000  c=3 d=0 v=1 g=0]
Index: 12 pgmask=4kb <3>va=00404000 asid=61 [pa=0b597000  c=3 d=0 v=1 
g=0] [pa=0b598000  c=3 d=0 v=1 g=0]
Index: 16 pgmask=4kb <3>va=00406000 asid=61 [pa=0b599000  c=3 d=0 v=1 
g=0] [pa=0b59a000  c=3 d=0 v=1 g=0]
Index: 22 pgmask=4kb <3>va=0041c000 asid=6b [pa=09570000  c=3 d=0 v=1 
g=0] [pa=09571000  c=3 d=0 v=1 g=0]
Index: 23 pgmask=4kb <3>va=0044a000 asid=5f [pa=00677000  c=3 d=0 v=1 
g=0] [pa=00678000  c=3 d=0 v=1 g=0]
Index:  2 pgmask=4kb <3>va=0049a000 asid=5f [pa=00000000  c=0 d=0 v=0 
g=0] [pa=005de000  c=3 d=1 v=1 g=0]
Index: 29 pgmask=4kb <3>va=0049a000 asid=5f [pa=00000000  c=0 d=0 v=0 
g=0] [pa=005de000  c=3 d=1 v=1 g=0]
Index: 14 pgmask=4kb <3>va=004a2000 asid=5f [pa=005da000  c=3 d=1 v=1 
g=0] [pa=005db000  c=3 d=1 v=1 g=0]
Index: 21 pgmask=4kb <3>va=10000000 asid=61 [pa=0b5df000  c=3 d=1 v=1 
g=0] [pa=0b5a3000  c=3 d=1 v=1 g=0]
Index:  8 pgmask=4kb <3>va=10002000 asid=61 [pa=0b66f000  c=3 d=1 v=1 
g=0] [pa=0b6bb000  c=3 d=1 v=1 g=0]
Index:  5 pgmask=4kb <3>va=10004000 asid=61 [pa=0b738000  c=3 d=1 v=1 
g=0] [pa=0b73a000  c=3 d=1 v=1 g=0]
Index: 26 pgmask=4kb <3>va=10004000 asid=61 [pa=0b738000  c=3 d=1 v=1 
g=0] [pa=0b73a000  c=3 d=1 v=1 g=0]
Index: 20 pgmask=4kb <3>va=10022000 asid=67 [pa=0916c000  c=3 d=1 v=1 
g=0] [pa=0916e000  c=3 d=1 v=1 g=0]
Index: 10 pgmask=4kb <3>va=2ab18000 asid=61 [pa=006e3000  c=3 d=0 v=1 
g=0] [pa=00000000  c=0 d=0 v=0 g=0]
Index:  6 pgmask=4kb <3>va=2ab5c000 asid=61 [pa=00000000  c=0 d=0 v=0 
g=0] [pa=0c878000  c=3 d=0 v=1 g=0]
Index: 17 pgmask=4kb <3>va=2ab5e000 asid=61 [pa=00000000  c=0 d=0 v=0 
g=0] [pa=0c87a000  c=3 d=0 v=1 g=0]
Index: 24 pgmask=4kb <3>va=2ab6a000 asid=61 [pa=0c84d000  c=3 d=0 v=1 
g=0] [pa=00000000  c=0 d=0 v=0 g=0]
Index: 31 pgmask=4kb <3>va=2ab82000 asid=60 [pa=00000000  c=0 d=0 v=0 
g=0] [pa=0c877000  c=3 d=0 v=1 g=0]
Index: 11 pgmask=4kb <3>va=2ab92000 asid=61 [pa=0cf47000  c=3 d=0 v=1 
g=0] [pa=0cf48000  c=3 d=0 v=1 g=0]
Index: 19 pgmask=4kb <3>va=2aba2000 asid=60 [pa=00000000  c=0 d=0 v=0 
g=0] [pa=0cf5c000  c=3 d=0 v=1 g=0]
Index:  3 pgmask=4kb <3>va=2abc2000 asid=61 [pa=0c8f1000  c=3 d=0 v=1 
g=0] [pa=0c8f2000  c=3 d=0 v=1 g=0]
Index:  9 pgmask=4kb <3>va=2ac0e000 asid=60 [pa=006d4000  c=3 d=0 v=1 
g=0] [pa=006d5000  c=3 d=0 v=1 g=0]
Index: 30 pgmask=4kb <3>va=2ac7e000 asid=61 [pa=00000000  c=0 d=0 v=0 
g=0] [pa=006e9000  c=3 d=0 v=1 g=0]
Index: 18 pgmask=4kb <3>va=2accc000 asid=61 [pa=0b58b000  c=3 d=0 v=0 
g=0] [pa=0b58a000  c=3 d=0 v=1 g=0]
Index: 25 pgmask=4kb <3>va=2acd0000 asid=60 [pa=0b55c000  c=3 d=1 v=1 
g=0] [pa=0b55b000  c=3 d=1 v=1 g=0]
Index: 15 pgmask=4kb <3>va=2acd2000 asid=61 [pa=0b5e0000  c=3 d=1 v=1 
g=0] [pa=0b5ea000  c=3 d=1 v=1 g=0]
Index:  4 pgmask=4kb <3>va=2b2fa000 asid=02 [pa=0a8e7000  c=3 d=0 v=1 
g=0] [pa=0a8e8000  c=3 d=0 v=1 g=0]
Index: 13 pgmask=4kb <3>va=7fd84000 asid=6c [pa=0a8e9000  c=3 d=1 v=1 
g=0] [pa=00000000  c=0 d=0 v=0 g=0]
Index:  0 pgmask=4kb <3>va=c0100000 asid=00 [pa=601000000 c=2 d=1 v=1 
g=1] [pa=601001000 c=2 d=1 v=1 g=1]
Index:  1 pgmask=4kb <3>va=c0104000 asid=00 [pa=f14000000 c=2 d=1 v=1 
g=1] [pa=f14001000 c=2 d=1 v=1 g=1]
Index: 28 pgmask=4kb <3>va=c0228000 asid=61 [pa=0a64d000  c=3 d=1 v=1 
g=1] [pa=0a64e000  c=3 d=1 v=1 g=1]
Index:  7 pgmask=4kb <3>va=c0244000 asid=61 [pa=0a669000  c=3 d=1 v=1 
g=1] [pa=0a66a000  c=3 d=1 v=1 g=1]

Thank you,

Marco
