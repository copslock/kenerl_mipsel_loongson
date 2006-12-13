Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 13 Dec 2006 10:36:34 +0000 (GMT)
Received: from smtp3.infineon.com ([203.126.106.229]:52030 "EHLO
	smtp3.infineon.com") by ftp.linux-mips.org with ESMTP
	id S20038807AbWLMKga convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 13 Dec 2006 10:36:30 +0000
Received: from unknown (HELO sinse301.ap.infineon.com) ([172.20.70.22])
  by smtp3.infineon.com with ESMTP; 13 Dec 2006 18:36:11 +0800
X-SBRS:	None
X-MIMEOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
Subject: MIPS32v2 toolchain for MIPS32 24KE Core?
Date:	Wed, 13 Dec 2006 18:36:10 +0800
Message-ID: <5049F8BE55F36348A315EFBE6CF34386E5D89E@sinse301.ap.infineon.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: MIPS32v2 toolchain for MIPS32 24KE Core?
Thread-index: AcceooFiwZT6t1TWRpmt/RCd9et/5g==
From:	<KokHow.Teh@infineon.com>
To:	<linux-mips@linux-mips.org>, <info@denx.de>
Cc:	<Bing-Tao.Xu@infineon.com>
Return-Path: <KokHow.Teh@infineon.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13440
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: KokHow.Teh@infineon.com
Precedence: bulk
X-list: linux-mips

Hi;
	Which toolchain can I use to build linux kernel for 24KEc core
in order to use MIPS32v2 ISA?
	"Programming the MIPS32 24KE Core Family" (Document Number
MD00458 Revision 1.10 December 21,2005) from MIPS Technologies
illustrates the details of programming this core using MIPS32v2 ISA to
access into some hardware registers using some extended instructions.
One typical critical example that I encounter now is the use of `rdhwr
v0, CCRes` that tells you how fast the COUNT register is running. I
assumed it to be running at pipeline frequency but in fact it is not.
What I do now is to hard-code it to be running at half of the pipeline
frequency according to hardware implementation document since the
present toolchain that I am using is not supporting this ISA. Assembling
`rdhwr v0,CCRes` will result in "opcode not supported at this ISA level
(mips2) error. GCC(1) does not give any indication of MIPS32v2 ISA at
all.
	Any advice and insight is appreciated.

Regards,
KH
