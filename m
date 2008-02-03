Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 03 Feb 2008 14:59:29 +0000 (GMT)
Received: from host194-211-dynamic.20-79-r.retail.telecomitalia.it ([79.20.211.194]:25279
	"EHLO eppesuigoccas.homedns.org") by ftp.linux-mips.org with ESMTP
	id S20022951AbYBCO7U (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sun, 3 Feb 2008 14:59:20 +0000
Received: from [192.168.1.33] (helo=[192.168.1.2])
	by eppesuigoccas.homedns.org with esmtpsa (TLS-1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.63)
	(envelope-from <giuseppe@eppesuigoccas.homedns.org>)
	id 1JLt8O-0000Vi-Bp
	for linux-mips@linux-mips.org; Mon, 04 Feb 2008 05:40:46 +0100
Subject: new type of crash report?
From:	Giuseppe Sacco <giuseppe@eppesuigoccas.homedns.org>
To:	linux-mips@linux-mips.org
Content-Type: text/plain
Date:	Sun, 03 Feb 2008 15:56:18 +0100
Message-Id: <1202050578.7035.11.camel@scarafaggio>
Mime-Version: 1.0
X-Mailer: Evolution 2.12.3 
Content-Transfer-Encoding: 7bit
Return-Path: <giuseppe@eppesuigoccas.homedns.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18171
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: giuseppe@eppesuigoccas.homedns.org
Precedence: bulk
X-list: linux-mips

Hi all,
with latest kernel I started getting problem like this one. How may I
understand what part of the kernel produced the problem? Is it possible
to get a stack trace from this report?

Thank you very much,
Giuseppe

Got dbe at 0x2ac2bffc
Cpu 0
$ 0   : 0000000000000000 0000000000000014 0000000000000000 000000002acf1758
$ 4   : 0000000000000000 00000000000073b0 0000000000000000 0000000000000000
$ 8   : 000000007fd06a64 0000000000000000 47a5ca5900000000 0000100000000000
$12   : 0000000000000000 0000000047a5ca59 0000000047a5ca59 0000000000000000
$16   : 0000000000000000 000000002acef588 000000002accbd68 0000000000000000
$20   : 0000000000546408 0000000000545e68 0000000000000000 0000000000530bb8
$24   : 0000000000000000 000000002abf8e58                                  
$28   : 000000002acf7960 000000007fd069e0 000000007fd069f0 000000002ac2bfdc
Hi    : 0000000000000000
Lo    : 0000000000000000
epc   : 000000002ac2bffc 0x2ac2bffc     Not tainted
ra    : 000000002ac2bfdc 0x2ac2bfdc
Status: 8001fcf3    KX SX UX USER EXL IE 
Cause : 0000041c
PrId  : 00002321 (R5000)
Index:  1 pgmask=4kb va=c00000ffc0126000 asid=6b
        [pa=00053946000 c=3 d=1 v=1 g=1] [pa=000538da000 c=3 d=1 v=1 g=1]
Index:  2 pgmask=4kb va=c00000ffc003a000 asid=6b
        [pa=00054e25000 c=3 d=1 v=1 g=1] [pa=00000000000 c=0 d=0 v=0 g=1]
Index:  4 pgmask=4kb va=c00000ffc00d8000 asid=6b
        [pa=00000000000 c=0 d=0 v=0 g=1] [pa=00053921000 c=3 d=1 v=1 g=1]
Index:  7 pgmask=4kb va=c00000ffc0042000 asid=6b
        [pa=00054cf7000 c=3 d=1 v=1 g=1] [pa=00054eaa000 c=3 d=1 v=1 g=1]
Index:  8 pgmask=4kb va=c00000ffc012c000 asid=6b
        [pa=000539e5000 c=3 d=1 v=1 g=1] [pa=00000000000 c=0 d=0 v=0 g=1]
Index: 10 pgmask=4kb va=c00000ffc00fa000 asid=6b
        [pa=000539ae000 c=3 d=1 v=1 g=1] [pa=000539af000 c=3 d=1 v=1 g=1]
[...]
