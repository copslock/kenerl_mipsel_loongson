Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 23 Sep 2003 20:41:35 +0100 (BST)
Received: from Iris.Adtech-Inc.COM ([IPv6:::ffff:63.165.80.18]:18600 "EHLO
	iris.Adtech-Inc.COM") by linux-mips.org with ESMTP
	id <S8225435AbTIWTld> convert rfc822-to-8bit; Tue, 23 Sep 2003 20:41:33 +0100
content-class: urn:content-classes:message
Subject: RE: User-mode drivers and TLB
Date: Tue, 23 Sep 2003 09:41:24 -1000
Message-ID: <DC1BF43A8FAE654DA6B3FB7836DD3A56DEB753@iris.adtech-inc.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: User-mode drivers and TLB
X-MimeOLE: Produced By Microsoft Exchange V6.0.6249.0
Thread-Index: AcOBxzv9D3K9HersR8CGkd2fLs28hwAQrWZw
From: "Finney, Steve" <Steve.Finney@SpirentCom.COM>
To: "Dominic Sweetman" <dom@mips.com>
Cc: <linux-mips@linux-mips.org>
Return-Path: <Steve.Finney@SpirentCom.COM>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3276
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Steve.Finney@SpirentCom.COM
Precedence: bulk
X-list: linux-mips

> 
> Most MIPS CPU hardware allows you to map large chunks of memory with a
> single TLB entry: often up to 16Mbytes at a time.  But I don't know
> how you'd persuade Linux how to do that.
> 
> --
> Dominic Sweetman
> MIPS Technologies.

Thanks: for what it's worth, the Broadcom/Sibyte apparently allows a TLB entry to map 128 MB (the max mapped size is 64 MB, but the TLB entries are paired). And supposedly the MIPS kernel tree was recently updated with some support for Linux to use wired TLB entries on the Broadcom, though I haven't tried this.

sf
