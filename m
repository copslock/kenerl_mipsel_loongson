Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 30 Mar 2004 23:47:51 +0100 (BST)
Received: from zcars0m9.nortelnetworks.com ([IPv6:::ffff:47.129.242.157]:37793
	"EHLO zcars0m9.nortelnetworks.com") by linux-mips.org with ESMTP
	id <S8225479AbUC3Wru>; Tue, 30 Mar 2004 23:47:50 +0100
Received: from zcard309.ca.nortel.com (zcard309.ca.nortel.com [47.129.242.69])
	by zcars0m9.nortelnetworks.com (Switch-2.2.6/Switch-2.2.0) with ESMTP id i2UMlfk22053
	for <linux-mips@linux-mips.org>; Tue, 30 Mar 2004 17:47:41 -0500 (EST)
Received: from zcard0k6.ca.nortel.com ([47.129.242.158]) by zcard309.ca.nortel.com with SMTP (Microsoft Exchange Internet Mail Service Version 5.5.2653.13)
	id GXT6MLK3; Tue, 30 Mar 2004 17:47:42 -0500
Received: from americasm01.nt.com (wcary3hh.ca.nortel.com [47.129.112.118]) by zcard0k6.ca.nortel.com with SMTP (Microsoft Exchange Internet Mail Service Version 5.5.2653.13)
	id DNVQHQSJ; Tue, 30 Mar 2004 17:47:41 -0500
Message-ID: <4069F90D.9060903@americasm01.nt.com>
Date: Tue, 30 Mar 2004 17:47:41 -0500
X-Sybari-Space: 00000000 00000000 00000000 00000000
From: "Lijun Chen" <chenli@nortelnetworks.com>
Organization: Nortel Networks
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.2) Gecko/20021120 Netscape/7.01
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-mips@linux-mips.org
Subject: exception priority for BCM1250
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <chenli@nortelnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4701
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: chenli@nortelnetworks.com
Precedence: bulk
X-list: linux-mips

Hi,

Does anybody know which mips family SB1 core on bcm1250 falls into?
It is a MIPS64 processor, does it belong to 5K family or 20Kc?

What about the exception priorities, such as cache error exception, bus 
error
exception, and so on? Are they maskable or non-maskable? It is not clear 
from
BCM1250 and sb1 core manuals.

Thanks a lot.

Lijun
