Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 19 Sep 2008 11:56:34 +0100 (BST)
Received: from mail2.miwe.de ([62.225.191.126]:12480 "EHLO mail2.miwe.de")
	by ftp.linux-mips.org with ESMTP id S20309298AbYISK41 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 19 Sep 2008 11:56:27 +0100
Received: from MAS15.arnstein.miwe.de ([172.16.100.182]) by
 MAS15.arnstein.miwe.de ([172.16.100.182]) with mapi; Fri, 19 Sep 2008
 12:56:20 +0200
From:	Klatt Uwe <U.Klatt@miwe.de>
To:	"'linux-mips@linux-mips.org'" <linux-mips@linux-mips.org>
Date:	Fri, 19 Sep 2008 12:56:19 +0200
Subject: =?iso-8859-1?Q?AW:_Same_mipsel_binary_f=FCr_2.4_and_2.6_kernel_possible?=
 =?iso-8859-1?Q?=3F?=
Thread-Topic: =?iso-8859-1?Q?Same_mipsel_binary_f=FCr_2.4_and_2.6_kernel_possible=3F?=
Thread-Index: AckaQ1CapIHZYf2FSv2ctDVqn3FpbgAArOBw
Message-ID: <A1F06CF959C7E14EAC28F277F368175805686A8D6F@MAS15.arnstein.miwe.de>
In-Reply-To: <20080919103433.GA14602@linux-mips.org>
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
X-archive-position: 20549
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: U.Klatt@miwe.de
Precedence: bulk
X-list: linux-mips

Hello Ralf,

I link both binaries with -lm.
Could it be a problem with libc?
I will try to compile the new kernel with old compiler...

Bye
Uwe

> Are you using the kernel floating point emulator or a
> software floating
> point library?
>
> Whatever, it sounds like a bug.  The kernel is supposed to be backward
> compatible with old binaries.
>
>   Ralf
>
