Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 21 Jul 2004 13:54:59 +0100 (BST)
Received: from [IPv6:::ffff:202.125.86.130] ([IPv6:::ffff:202.125.86.130]:35739
	"EHLO ns2.astrainfonets.net") by linux-mips.org with ESMTP
	id <S8224901AbUGUMyz> convert rfc822-to-8bit; Wed, 21 Jul 2004 13:54:55 +0100
Received: from mail.esn.co.in ([202.125.80.34])
	by ns2.astrainfonets.net (8.12.8p1/8.12.8) with ESMTP id i6LCpGIW024659
	for <linux-mips@linux-mips.org>; Wed, 21 Jul 2004 12:51:18 GMT
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Subject: Error :Nomatch found in TLB ?????
X-MimeOLE: Produced By Microsoft Exchange V6.5.6944.0
Date: Wed, 21 Jul 2004 18:25:05 +0530
Message-ID: <4EE0CBA31942E547B99B3D4BFAB34811067510@mail.esn.co.in>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Error :Nomatch found in TLB ?????
Thread-Index: AcRvITae5sZQ4bx+RqS0jC7V+qvUtA==
X-Priority: 1
Priority: Urgent
Importance: high
From: "Srinivas JT." <srinivasjt@esntechnologies.co.in>
To: <linux-mips@linux-mips.org>
Return-Path: <srinivasjt@esntechnologies.co.in>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5532
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: srinivasjt@esntechnologies.co.in
Precedence: bulk
X-list: linux-mips

Dear All,
I am very new to this group.
I tried to load my .serc file into my Db1500 SDB. The steps that I followed are,

1) I wrote a filein C(Linux).
2) I generated an object file using gcc.
3) By using objcopy I converted my obj file into srec file.
4) Then I tried to download my srec file into Db1500 SDB in Yamon using tftp.

then I got error as,

Error: No match in TLB for mapped address  : Address = 0x00000000

Why I am getting this error ?. Is any error there in my procedure..?

Thanks in Advance.

Regards,
Srinivas JT
