Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 21 Mar 2005 21:10:39 +0000 (GMT)
Received: from foothill.iad.idealab.com ([IPv6:::ffff:64.208.8.35]:46345 "EHLO
	foothill.iad.idealab.com") by linux-mips.org with ESMTP
	id <S8225002AbVCUVKZ> convert rfc822-to-8bit; Mon, 21 Mar 2005 21:10:25 +0000
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Subject: RE: Bitrotting serial drivers
Date:	Mon, 21 Mar 2005 13:10:13 -0800
Message-ID: <BBB228F72FF00E4390479AC295FF4B350DE937@FOOTHILL.iad.idealab.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Bitrotting serial drivers
Thread-Index: AcUuWBr1A7Hs3VGhRa+RX9TP/rZGCwAAoKQQ
From:	"Joseph Chiu" <joseph@omnilux.net>
To:	"Ulrich Eckhardt" <eckhardt@satorlaser.com>,
	<linux-mips@linux-mips.org>
Return-Path: <joseph@omnilux.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7491
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: joseph@omnilux.net
Precedence: bulk
X-list: linux-mips

Hmmm, that's news to me!  I've been using console=ttyS0,115200  console=ttyS0,9600 and console= (no console) forever.

> -----Original Message-----
> From: linux-mips-bounce@linux-mips.org
> [mailto:linux-mips-bounce@linux-mips.org]On Behalf Of Ulrich Eckhardt
> Sent: Monday, March 21, 2005 12:51 PM
> To: linux-mips@linux-mips.org
> Subject: Re: Bitrotting serial drivers
> 
> 
> On Sunday 20 March 2005 23:51, Pete Popov wrote:
> > It works and no one has complained about any bugs. 
> 
> I hereby do complain that it doesn't work. ;)
> 
> I'd give more details, but I'm neither at work nor did I 
> investigate the 
> situation properly. What I remember trying is to add 
> 'console=/dev/ttyS0' or 
> somesuch to the commandline, but couldn't get it to work 
> there. The funny 
> thing is that when I use the GDB support over serial line 
> (which seems to use 
> a primitive, stripped-down version of a serial driver) it 
> works, I can then 
> redirect boot messages via 'console=gdb'.
> 
> Uli
> 
> 
