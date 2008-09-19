Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 19 Sep 2008 08:58:42 +0100 (BST)
Received: from mail2.miwe.de ([62.225.191.126]:6587 "EHLO mail2.miwe.de")
	by ftp.linux-mips.org with ESMTP id S28791645AbYISH6h convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 19 Sep 2008 08:58:37 +0100
Received: from MAS15.arnstein.miwe.de ([172.16.100.182]) by
 MAS15.arnstein.miwe.de ([172.16.100.182]) with mapi; Fri, 19 Sep 2008
 09:58:30 +0200
From:	Klatt Uwe <U.Klatt@miwe.de>
To:	"'linux-mips@linux-mips.org'" <linux-mips@linux-mips.org>
Date:	Fri, 19 Sep 2008 09:58:29 +0200
Subject: =?iso-8859-1?Q?Same_mipsel_binary_f=FCr_2.4_and_2.6_kernel_possible=3F?=
Thread-Topic: =?iso-8859-1?Q?Same_mipsel_binary_f=FCr_2.4_and_2.6_kernel_possible=3F?=
Thread-Index: AckaLYC+LcrtWakNQGmmeJA4PlHF7Q==
Message-ID: <A1F06CF959C7E14EAC28F277F368175805686A8D6D@MAS15.arnstein.miwe.de>
Accept-Language: de-DE
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
acceptlanguage:	de-DE
x-pmwin-version: 3.0.2.0, Antivirus-Engine: 2.78.0, Antivirus-Data: 4.33E
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Return-Path: <U.Klatt@miwe.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20543
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: U.Klatt@miwe.de
Precedence: bulk
X-list: linux-mips

Hello,

I have a custom hardware (AU1100) with kernel 2.4 and an working binary using floats (compiled with gcc 3.3.5).
Now I am testing with kernel 2.6.

When I use the old binary, float math isn't working anymore.
I have to recompile the source with new gcc 4.1.2 but then the new binary is working only on kernel 2.6.

Can somebody give me some hints, how to chage settings for kernel 2.6 creation or compiler settings to generate an universal binary.

Thanks
Uwe
