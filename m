Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 25 Oct 2003 17:44:39 +0100 (BST)
Received: from [IPv6:::ffff:66.121.16.190] ([IPv6:::ffff:66.121.16.190]:185
	"EHLO trid-mail1.tridentmicro.com") by linux-mips.org with ESMTP
	id <S8225407AbTJYQoh> convert rfc822-to-8bit; Sat, 25 Oct 2003 17:44:37 +0100
content-class: urn:content-classes:message
Subject: need help on bus error problem
MIME-Version: 1.0
Content-Type: text/plain;
	charset="big5"
Content-Transfer-Encoding: 8BIT
Date: Sat, 25 Oct 2003 09:44:35 -0700
Message-ID: <92F2591F460F684C9C309EB0D33256FA01B54329@trid-mail1.tridentmicro.com>
X-MimeOLE: Produced By Microsoft Exchange V6.0.6249.0
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: need help on bus error problem
Thread-Index: AcObF0X0mItjLbcfQ4OzPzvO8C2f1w==
From: "Teresa Tao" <TERESAT@TTI-DM.COM>
To: <linux-mips@linux-mips.org>
Return-Path: <TERESAT@TTI-DM.COM>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3512
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: TERESAT@TTI-DM.COM
Precedence: bulk
X-list: linux-mips

Hi there,

I am working on an real time video playback applicaion on a mips cpu. But after my video application play a while like 5 to 10 minutes, a bus error happened.

We add some debug meesage in the kernel, so we know that after the do_ade function inside the unalign.c, the bus error happens for the opcode lw or sw. So my guess is that I have an unaligned memory pointer(not in 4 byte boundary).
But my puzzle is that if I have an unaligned memory pointer, it should happen at the first loop I playback, how come it happens after it plays several loops?
Is there a possibility that my application's stack being trashed after a while? but I don't have recursive calls inside my application.


Thanks in advance!

Teresa
