Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 30 Mar 2004 00:39:27 +0100 (BST)
Received: from zcars04e.nortelnetworks.com ([IPv6:::ffff:47.129.242.56]:47014
	"EHLO zcars04e.nortelnetworks.com") by linux-mips.org with ESMTP
	id <S8225462AbUC2Xj0>; Tue, 30 Mar 2004 00:39:26 +0100
Received: from zcard307.ca.nortel.com (zcard307.ca.nortel.com [47.129.242.67])
	by zcars04e.nortelnetworks.com (Switch-2.2.6/Switch-2.2.0) with ESMTP id i2TNdHR13909
	for <linux-mips@linux-mips.org>; Mon, 29 Mar 2004 18:39:17 -0500 (EST)
Received: from zcard0k6.ca.nortel.com ([47.129.242.158]) by zcard307.ca.nortel.com with SMTP (Microsoft Exchange Internet Mail Service Version 5.5.2653.13)
	id GXWMPHD9; Mon, 29 Mar 2004 18:39:17 -0500
Received: from americasm01.nt.com (wcary3hh.ca.nortel.com [47.129.112.118]) by zcard0k6.ca.nortel.com with SMTP (Microsoft Exchange Internet Mail Service Version 5.5.2653.13)
	id DNVQH3W0; Mon, 29 Mar 2004 18:39:17 -0500
Message-ID: <4068B3A4.4000204@americasm01.nt.com>
Date: Mon, 29 Mar 2004 18:39:16 -0500
X-Sybari-Space: 00000000 00000000 00000000 00000000
From: "Lijun Chen" <chenli@nortelnetworks.com>
Organization: Nortel Networks
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.2) Gecko/20021120 Netscape/7.01
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-mips@linux-mips.org
Subject: NMI handling in MIPS64
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <chenli@nortelnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4684
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: chenli@nortelnetworks.com
Precedence: bulk
X-list: linux-mips

Hi,

I noticed there is a NMI handler in mips32 kernel tree (arch/mips/kernel/head.S and traps.c).
But there is not a counterpart in mips64. Do we need one?
From Ralf's earlier emails, the execution of NMI will pass through the firmware. Does that
mean just the firmware handles the NMI? And if the NMI can be enabled/disabled?
My testing system is BCM1250 with SB1 cores.

Thanks in advance,
Lijun
