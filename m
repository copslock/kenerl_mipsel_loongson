Received:  by oss.sgi.com id <S554057AbQKISUt>;
	Thu, 9 Nov 2000 10:20:49 -0800
Received: from gatekeep.ti.com ([192.94.94.61]:16840 "EHLO gatekeep.ti.com")
	by oss.sgi.com with ESMTP id <S554054AbQKISUm>;
	Thu, 9 Nov 2000 10:20:42 -0800
Received: from dlep7.itg.ti.com ([157.170.134.103])
	by gatekeep.ti.com (8.11.1/8.11.1) with ESMTP id eA9IKan26298
	for <linux-mips@oss.sgi.com>; Thu, 9 Nov 2000 12:20:37 -0600 (CST)
Received: from dlep7.itg.ti.com (localhost [127.0.0.1])
	by dlep7.itg.ti.com (8.9.3/8.9.3) with ESMTP id MAA00390
	for <linux-mips@oss.sgi.com>; Thu, 9 Nov 2000 12:20:36 -0600 (CST)
Received: from dlep3.itg.ti.com (dlep3-maint.itg.ti.com [157.170.133.16])
	by dlep7.itg.ti.com (8.9.3/8.9.3) with ESMTP id MAA00347
	for <linux-mips@oss.sgi.com>; Thu, 9 Nov 2000 12:20:35 -0600 (CST)
Received: from ti.com (IDENT:bbrown@bbrowndt.sc.ti.com [158.218.100.180])
	by dlep3.itg.ti.com (8.9.3/8.9.3) with ESMTP id MAA01290
	for <linux-mips@oss.sgi.com>; Thu, 9 Nov 2000 12:20:35 -0600 (CST)
Message-ID: <3A0AEAEC.FE3E5152@ti.com>
Date:   Thu, 09 Nov 2000 11:20:28 -0700
From:   Brady Brown <bbrown@ti.com>
Organization: Texas Instruments
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.14-5.0 i686)
X-Accept-Language: en
MIME-Version: 1.0
To:     SGI news group <linux-mips@oss.sgi.com>
Subject: egcs-1.0.3a-2 mipsel binary?
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

I am upgrading our Atlas board (mipsel r4kc core) to the 'recommended'
tool chain to be able to do some native re-compiles of several userland
packages. As far as I have been able to determine the rev's that I am
looking for are:

binutils-2.8.1-2.mipsel.rpm
glibc-2.0.6-5lm.mipsel.rpm

and egcs-1.0.3a-2

Does this rev of egcs exist as a binary native install for mipsel
anywhere or the web? If not, what tool-chain/library and environment is
needed to correctly build it? Seems to be a bit of a chicken and egg
problem to me.

Is there any particular order that I need to follow to do these updates?

--
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Brady Brown (bbrown@ti.com)       Work:(801)619-6103
Texas Instruments: Broadband Access Group
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
