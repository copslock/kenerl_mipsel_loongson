Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 27 Oct 2003 23:11:06 +0000 (GMT)
Received: from m205-235.dsl.tsoft.com ([IPv6:::ffff:198.144.205.235]:18324
	"EHLO lists.herlein.com") by linux-mips.org with ESMTP
	id <S8225405AbTJ0XLE>; Mon, 27 Oct 2003 23:11:04 +0000
Received: from io.herlein.com (io.herlein.com [192.168.70.244])
	by lists.herlein.com (Postfix) with ESMTP id 42135A33
	for <linux-mips@linux-mips.org>; Mon, 27 Oct 2003 15:19:32 -0800 (PST)
Date: Mon, 27 Oct 2003 11:15:30 -0800 (PST)
From: Greg Herlein <gherlein@herlein.com>
To: Linux MIPS mailing list <linux-mips@linux-mips.org>
Subject: Pb1500 and PCMCIA booting?
Message-ID: <Pine.LNX.4.44.0310271113460.604-100000@io.herlein.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <gherlein@herlein.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3526
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: gherlein@herlein.com
Precedence: bulk
X-list: linux-mips

Does anyone have advice/experience in what's the best way to get 
linux booting from the Pb1500 development board directly off 
PCMCIA?  I'm susepcting that getting a bootable filesystem rigged 
up on a CF card and using my handy CF <-> PCMCIA adapter card to 
get it onto the bus.  

Any advice/gotchas/hints as I start down this path?

Thanks in advance,

Greg
