Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 19 Sep 2008 14:40:13 +0100 (BST)
Received: from mail2.miwe.de ([62.225.191.126]:11717 "EHLO mail2.miwe.de")
	by ftp.linux-mips.org with ESMTP id S29049296AbYISNkL convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 19 Sep 2008 14:40:11 +0100
Received: from MAS15.arnstein.miwe.de ([172.16.100.182]) by
 MAS15.arnstein.miwe.de ([172.16.100.182]) with mapi; Fri, 19 Sep 2008
 15:40:05 +0200
From:	Klatt Uwe <U.Klatt@miwe.de>
To:	"'linux-mips@linux-mips.org'" <linux-mips@linux-mips.org>
Date:	Fri, 19 Sep 2008 15:40:04 +0200
Subject: =?iso-8859-1?Q?AW:_Same_mipsel_binary_f=FCr_2.4_and_2.6_kernel_possible?=
 =?iso-8859-1?Q?=3F?=
Thread-Topic: =?iso-8859-1?Q?Same_mipsel_binary_f=FCr_2.4_and_2.6_kernel_possible=3F?=
Thread-Index: AckaW08UtGiq7IteSrGDeEO/xzh0owAABk4A
Message-ID: <A1F06CF959C7E14EAC28F277F368175805686A8D71@MAS15.arnstein.miwe.de>
In-Reply-To: <48D3A909.6020604@paralogos.com>
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
X-archive-position: 20558
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: U.Klatt@miwe.de
Precedence: bulk
X-list: linux-mips

Hello everybody,

> I think it's more likely that you've got a problem
> with libraries and/or build procedures
> for the application.
You are right!

It's a problem with shared libs.
When I link static everything works now.
Thank you for your patience.

Bye
Uwe
