Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 29 Oct 2002 23:53:56 +0100 (CET)
Received: from atlrel9.hp.com ([156.153.255.214]:14538 "HELO atlrel9.hp.com")
	by linux-mips.org with SMTP id <S1121743AbSJ2Wxz>;
	Tue, 29 Oct 2002 23:53:55 +0100
Received: from xatlrelay2.atl.hp.com (xatlrelay2.atl.hp.com [15.45.89.191])
	by atlrel9.hp.com (Postfix) with ESMTP id B723CE00E5B
	for <linux-mips@linux-mips.org>; Tue, 29 Oct 2002 17:53:44 -0500 (EST)
Received: from xatlbh3.atl.hp.com (xatlbh3.atl.hp.com [15.45.89.188])
	by xatlrelay2.atl.hp.com (Postfix) with ESMTP id C570E4000B8
	for <linux-mips@linux-mips.org>; Tue, 29 Oct 2002 17:53:28 -0500 (EST)
Received: by xatlbh3.atl.hp.com with Internet Mail Service (5.5.2655.55)
	id <VV3680AR>; Tue, 29 Oct 2002 17:53:19 -0500
Message-ID: <CBD6266EA291D5118144009027AA63353F9412@xboi05.boi.hp.com>
From: "TWEDE,ROGER (HP-Boise,ex1)" <roger_twede@hp.com>
To: "'linux-mips@linux-mips.org'" <linux-mips@linux-mips.org>
Subject: Recent Kernel Page Fault Problems Spawning Init?
Date: Tue, 29 Oct 2002 17:53:15 -0500
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2655.55)
Content-Type: text/plain;
	charset="iso-8859-1"
Return-Path: <roger_twede@hp.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 536
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: roger_twede@hp.com
Precedence: bulk
X-list: linux-mips

I would be appreciative of any advice anyone can offer in this regard.

Were any fundamental kernel changes made in the 2.4.17 through 2.4.19
timeframe which could explain why the spawning of init would hang?

After mounting a root filesystem and attempting to spawn init, 3 or 4 page
faults occur.  The entry point of init, its bss section and an elf loader
.text section get hit, etc.  followed by an endless series of page faults to
a bad address which just faults repeatedly, never allowing init or the elf
loader to proceed.

I've tried a RM 7000A and 20KC based boards so far with apparently identical
behavior on both.

Thanks,

Roger Twede
Hewlett Packard
