Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 24 Sep 2004 13:11:19 +0100 (BST)
Received: from the-doors.enix.org ([IPv6:::ffff:62.210.169.120]:44446 "EHLO
	the-doors.enix.org") by linux-mips.org with ESMTP
	id <S8224944AbUIXMLN>; Fri, 24 Sep 2004 13:11:13 +0100
Received: by the-doors.enix.org (Postfix, from userid 1105)
	id 4D0B61F02E; Fri, 24 Sep 2004 14:11:07 +0200 (CEST)
Date: Fri, 24 Sep 2004 14:11:07 +0200
From: Thomas Petazzoni <thomas.petazzoni@enix.org>
To: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc: linux-mips@linux-mips.org, mentre@tcl.ite.mee.com
Subject: Re: "Can't analyze prologue code ..." at boot time
Message-ID: <20040924121107.GB24730@enix.org>
References: <20040924085240.GP24730@enix.org> <20040924.190640.09669815.nemoto@toshiba-tops.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040924.190640.09669815.nemoto@toshiba-tops.co.jp>
User-Agent: Mutt/1.5.4i
Return-Path: <thomas@the-doors.enix.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5883
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: thomas.petazzoni@enix.org
Precedence: bulk
X-list: linux-mips

Hello,

On Fri, Sep 24, 2004 at 07:06:40PM +0900, Atsushi Nemoto wrote :

> I rewrote get_wchan() to handle this problem.  Please try this patch.

This patch works for me. At least, the "Couldn't analyze prologue code
at ..." message doesn't appear anymore.

Thanks,

Thomas
-- 
PETAZZONI Thomas - thomas.petazzoni@enix.org 
http://thomas.enix.org - Jabber: kos_tom@sourcecode.de
KOS: http://kos.enix.org/ - Lolut: http://lolut.utbm.info
Fingerprint : 0BE1 4CF3 CEA4 AC9D CC6E  1624 F653 CB30 98D3 F7A7
