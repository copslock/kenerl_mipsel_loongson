Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 09 Oct 2003 22:35:00 +0100 (BST)
Received: from Iris.Adtech-Inc.COM ([IPv6:::ffff:63.165.80.18]:52772 "EHLO
	iris.Adtech-Inc.COM") by linux-mips.org with ESMTP
	id <S8225625AbTJIVe6> convert rfc822-to-8bit; Thu, 9 Oct 2003 22:34:58 +0100
content-class: urn:content-classes:message
Subject: MIPS bootloaders
Date: Thu, 9 Oct 2003 11:34:49 -1000
Message-ID: <DC1BF43A8FAE654DA6B3FB7836DD3A56DEB770@iris.adtech-inc.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: YAMON Source code modification 
X-MimeOLE: Produced By Microsoft Exchange V6.0.6249.0
Thread-Index: AcOOomaYLdlEU2UoR2yDmesX26wdFQABvn1A
From: "Finney, Steve" <Steve.Finney@SpirentCom.COM>
To: <linux-mips@linux-mips.org>
Return-Path: <Steve.Finney@SpirentCom.COM>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3405
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Steve.Finney@SpirentCom.COM
Precedence: bulk
X-list: linux-mips

> 
> In message <20031009110154.B17781@mvista.com> you wrote:
> >
> > Actually is YAMON code freely available?  Can someone from 
> MIPS confirm
> > that and perhaps point to the downloading place?  


Broadcom has a "CFE" bootloader for their chip, and the documentation implies that it was designed to be for general purpose use (e.g., arch/mips/board/... directory hierarchy); it's covered by what I'd call a BSD style license (but IANAL). I don't know if it is publically available, and its current state of support is largely tailored to the peripherals on their eval boards, but (from my limited experience) it looks like  a reasonable and pretty-well written bootloader. Typical size is 400K, but this could be decreased (or increased :-) ).

sf
