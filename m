Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 04 Jan 2004 09:09:38 +0000 (GMT)
Received: from web10102.mail.yahoo.com ([IPv6:::ffff:216.136.130.52]:53366
	"HELO web10102.mail.yahoo.com") by linux-mips.org with SMTP
	id <S8225254AbUADJJZ>; Sun, 4 Jan 2004 09:09:25 +0000
Message-ID: <20040104090922.35955.qmail@web10102.mail.yahoo.com>
Received: from [128.107.253.43] by web10102.mail.yahoo.com via HTTP; Sun, 04 Jan 2004 09:09:22 GMT
Date: Sun, 4 Jan 2004 09:09:22 +0000 (GMT)
From: =?iso-8859-1?q?karthikeyan=20natarajan?= <karthik_96cse@yahoo.com>
Subject: Regarding the LL & SC instructions
To: linux-mips@linux-mips.org
In-Reply-To: <Pine.LNX.4.55.0312221342180.27237@jurand.ds.pg.gda.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-Path: <karthik_96cse@yahoo.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3863
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: karthik_96cse@yahoo.com
Precedence: bulk
X-list: linux-mips

Hi All,

    Seems that LL & SC instrutions operate on a 'word'
data.
    Can we use the same instructions to do a atomic
increment on a 'byte' data. If not, are there any
specific instructions to operate on a byte data?
(Like, LLD & SCD for doubleword data) or else, any 
method to achieve this using the LL & SC instr?

Thanks much,
-karthi


=====
The expert at anything was once a beginner

________________________________________________________________________
Yahoo! Messenger - Communicate instantly..."Ping" 
your friends today! Download Messenger Now 
http://uk.messenger.yahoo.com/download/index.html
