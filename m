Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 14 Nov 2003 17:43:00 +0000 (GMT)
Received: from [IPv6:::ffff:66.121.16.190] ([IPv6:::ffff:66.121.16.190]:33509
	"EHLO trid-mail1.tridentmicro.com") by linux-mips.org with ESMTP
	id <S8225358AbTKNRms> convert rfc822-to-8bit; Fri, 14 Nov 2003 17:42:48 +0000
Subject: question regarding put data in the specified section
MIME-Version: 1.0
Content-Type: text/plain;
	charset="big5"
Content-Transfer-Encoding: 8BIT
Date: Fri, 14 Nov 2003 09:42:34 -0800
Message-ID: <92F2591F460F684C9C309EB0D33256FA01B750B8@trid-mail1.tridentmicro.com>
content-class: urn:content-classes:message
X-MS-Has-Attach: 
X-MimeOLE: Produced By Microsoft Exchange V6.0.6249.0
X-MS-TNEF-Correlator: 
Thread-Topic: question regarding put data in the specified section
Thread-Index: AcOq1q+oMjzWNX5USweAKSWtAcTo6A==
From: "Teresa Tao" <TERESAT@TTI-DM.COM>
To: <linux-mips@linux-mips.org>
Return-Path: <TERESAT@TTI-DM.COM>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3620
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: TERESAT@TTI-DM.COM
Precedence: bulk
X-list: linux-mips

Hi there,

Does anyone know how to put my userland program's data in a specified section?

I know there is an attribute "section" to put my data inside a specified section, for example, int data __attribute__ ((section("INITDAT"));
But how do I initialize/setup the INITDAT section? We use the commercial toolchain, and we don't have the source code for it, is there still a way to specify the postion of the INITDAT section?

Thanks in advance!

Teresa
