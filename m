Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 08 Dec 2004 16:09:06 +0000 (GMT)
Received: from 67-121-164-6.ded.pacbell.net ([IPv6:::ffff:67.121.164.6]:7357
	"EHLO mailserver.sunrisetelecom.com") by linux-mips.org with ESMTP
	id <S8225305AbULHQJB>; Wed, 8 Dec 2004 16:09:01 +0000
Received: from there ([192.168.50.222]) by mailserver.sunrisetelecom.com with Microsoft SMTPSVC(5.0.2195.6713);
	 Wed, 8 Dec 2004 08:08:51 -0800
Content-Type: text/plain;
  charset="iso-8859-1"
From: Karl Lessard <klessard@sunrisetelecom.com>
To: linux-mips@linux-mips.org
Subject: Epson13806 performances on Pb1100
Date: Wed, 8 Dec 2004 11:06:14 -0500
X-Mailer: KMail [version 1.3.2]
Cc: ppopov@embeddedalley.com
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID: <MAILSERVERUhrBb0aCQ0000084e@mailserver.sunrisetelecom.com>
X-OriginalArrivalTime: 08 Dec 2004 16:08:51.0386 (UTC) FILETIME=[353A11A0:01C4DD40]
Return-Path: <klessard@sunrisetelecom.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6597
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: klessard@sunrisetelecom.com
Precedence: bulk
X-list: linux-mips

Hi all,

I'm currently developping on a Pb1100 alchemy board, and I use the Epson 
13806 graphic controller connected to the Au1100 static bus. I've written a 
driver for it for kernel 2.6.x, and update the Au1100 code so I can access 
0xE 0000 0000 address range.

Everything works fine, but for the speed. It seems that accessing the chip is 
too slow for having high-graphic performances. The LCLK is set at 49500KHz, 
as the memory clock inside the chip. I know it's a bit overclocked, but a 
lower LCLK freezes my system.

I would like to know if anyone have encountered this performance problem in 
the past with this chip.

Thanks in advance,
Karl
