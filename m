Received:  by oss.sgi.com id <S42222AbQGYPRT>;
	Tue, 25 Jul 2000 08:17:19 -0700
Received: from jester.ti.com ([192.94.94.1]:2792 "EHLO jester.ti.com")
	by oss.sgi.com with ESMTP id <S42210AbQGYPQn>;
	Tue, 25 Jul 2000 08:16:43 -0700
Received: from dlep8.itg.ti.com ([157.170.134.88])
	by jester.ti.com (8.10.1/8.10.1) with ESMTP id e6PFFGX28832
	for <linux-mips@oss.sgi.com>; Tue, 25 Jul 2000 10:15:16 -0500 (CDT)
Received: from dlep8.itg.ti.com (localhost [127.0.0.1])
	by dlep8.itg.ti.com (8.9.3/8.9.3) with ESMTP id KAA11655
	for <linux-mips@oss.sgi.com>; Tue, 25 Jul 2000 10:15:51 -0500 (CDT)
Received: from dlep3.itg.ti.com (dlep3.itg.ti.com [157.170.188.62])
	by dlep8.itg.ti.com (8.9.3/8.9.3) with ESMTP id KAA11650
	for <linux-mips@oss.sgi.com>; Tue, 25 Jul 2000 10:15:51 -0500 (CDT)
Received: from ti.com (IDENT:bbrown@bbrown.sc.ti.com [158.218.100.128])
	by dlep3.itg.ti.com (8.9.3/8.9.3) with ESMTP id KAA10011
	for <linux-mips@oss.sgi.com>; Tue, 25 Jul 2000 10:16:14 -0500 (CDT)
Message-ID: <397DAF60.13B16812@ti.com>
Date:   Tue, 25 Jul 2000 09:16:48 -0600
From:   Brady Brown <bbrown@ti.com>
Organization: Texas Instruments
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.14-5.0 i686)
X-Accept-Language: en
MIME-Version: 1.0
To:     SGI news group <linux-mips@oss.sgi.com>
Subject: IP Masquerading with 2.4 kernel
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

Has anybody setup IP masquerading with the 2.4 kernel (using netfilter
and iptables) on a little endian R4Kc MIPS 32 architecture? I'm looking
for either compiled iptables binaries (or MIPS patched source) and
information about which kernel options need to be enabled.
I could also possibly use ipchains with the 2.4 kernel if anybody has
information/success with that.
--
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Brady Brown (bbrown@ti.com)       Work:(801)619-6103
Texas Instruments: Broadband Access Group
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
