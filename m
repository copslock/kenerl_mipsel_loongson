Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 27 Oct 2003 17:44:13 +0000 (GMT)
Received: from [IPv6:::ffff:66.121.16.190] ([IPv6:::ffff:66.121.16.190]:35307
	"EHLO trid-mail1.tridentmicro.com") by linux-mips.org with ESMTP
	id <S8225344AbTJ0RoK> convert rfc822-to-8bit; Mon, 27 Oct 2003 17:44:10 +0000
content-class: urn:content-classes:message
Subject: question regarding bss section
MIME-Version: 1.0
Content-Type: text/plain;
	charset="big5"
Content-Transfer-Encoding: 8BIT
Date: Mon, 27 Oct 2003 09:44:05 -0800
Message-ID: <92F2591F460F684C9C309EB0D33256FA01B750B3@trid-mail1.tridentmicro.com>
X-MimeOLE: Produced By Microsoft Exchange V6.0.6249.0
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: question regarding bss section
Thread-Index: AcOcseq6NSMm2DSSQI6oL2751s5g8g==
From: "Teresa Tao" <TERESAT@TTI-DM.COM>
To: <linux-mips@linux-mips.org>
Return-Path: <TERESAT@TTI-DM.COM>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3518
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: TERESAT@TTI-DM.COM
Precedence: bulk
X-list: linux-mips

Hi there,

I have several questions and hope somebody could help me with the answers:
1. how to use gcc to compile the user mode program with larger stack size?
2. Inside the user mode program, I have declared some gloabal data which is being put on the bss section and I would like to know whom initialize the bss section? How big is the bss section? Under what kind of situation, the bss section data could be corrupted?
3. What's the difference to compile the program with -G 0 option? That menas I don't use the $gp register, will there be any side effect?

Thanks in advance!

Teresa
