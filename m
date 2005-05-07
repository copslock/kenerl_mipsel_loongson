Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 07 May 2005 14:51:59 +0100 (BST)
Received: from money.ngit.com ([IPv6:::ffff:207.22.44.49]:23476 "EHLO
	money.ngit.com") by linux-mips.org with ESMTP id <S8226090AbVEGNvo> convert rfc822-to-8bit;
	Sat, 7 May 2005 14:51:44 +0100
Received: from lithium (router.ngit.com [207.22.44.62])
	by money.ngit.com (8.11.7p1+Sun/8.11.7) with ESMTP id j47DrrA06721;
	Sat, 7 May 2005 09:53:57 -0400 (EDT)
From:	"Bogdan Vacaliuc" <bvacaliuc@ngit.com>
To:	"'Kiran Thota'" <Kiran_Thota@pmc-sierra.com>,
	"'Ulrich Eckhardt'" <eckhardt@satorlaser.com>,
	<linux-mips@linux-mips.org>
Subject: RE: CF custom implementation
Date:	Sat, 7 May 2005 09:51:30 -0400
Organization: NGI Technology, LLC
Message-ID: <00c901c5530b$e49542a0$0b03a8c0@lithium>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.6626
In-Reply-To: <9DFF23E1E33391449FDC324526D1F259024380CB@sjc1exm02.pmc_nt.nt.pmc-sierra.bc.ca>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1441
Importance: Normal
Return-Path: <bvacaliuc@ngit.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7897
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: bvacaliuc@ngit.com
Precedence: bulk
X-list: linux-mips

On Friday, May 06, 2005 1:33 PM, Kiran Thota wrote:

> Another question: If I rework the board so that the wires coming to
> MEMR and MEMW are rewired to IOR and IOW respectively, does it work
> in TrueIDE mode? Just a thought!  

No.  TrueIDE mode changes the meaning of many input/output pins, and thus is significantly different from PCcard IO mode so that
this will not work.

Also, you should bear in mind that (P)IO mode is more similar to IDE mode than it is to memory mode.

To operate the CF/CF+ card in memory mapped mode you will need the following signals:

A[0:10]
D[0:15]
-CD1, -CD2
-CE1, -CE2
-OE
RDY_BUSY
-REG
RESET
-WE
WP

Refer to the "CF+ & CF SPECIFICATION REV. 3.0", pg. 24-30 for details.
http://www.compactflash.org/cfspc3_0.pdf

If your cards are not going to be removable, you can get away with tying up/dn some lines.

Also, please note that on pg. 89, the specification allows for alternate ways that a CF card may 'enter' either trueIDE or memory/io
mode.  Please be aware of this, because certain software implementations may inadvertently cause -OE to stay asserted for an
extended period of time, thus causing the card to spontaneously switch modes.  This results in the card seemingly becoming opaque
until the next reset or power cycle.


Best Regards,

-bogdan
