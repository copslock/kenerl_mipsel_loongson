Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 14 Jan 2004 06:36:50 +0000 (GMT)
Received: from bay10-f117.bay10.hotmail.com ([IPv6:::ffff:64.4.37.117]:41746
	"EHLO hotmail.com") by linux-mips.org with ESMTP
	id <S8225240AbUANGgr>; Wed, 14 Jan 2004 06:36:47 +0000
Received: from mail pickup service by hotmail.com with Microsoft SMTPSVC;
	 Tue, 13 Jan 2004 22:36:39 -0800
Received: from 63.203.69.252 by by10fd.bay10.hotmail.msn.com with HTTP;
	Wed, 14 Jan 2004 06:36:39 GMT
X-Originating-IP: [63.203.69.252]
X-Originating-Email: [sagarwal10@hotmail.com]
X-Sender: sagarwal10@hotmail.com
From: "Samuel Agarwal" <sagarwal10@hotmail.com>
To: linux-mips@linux-mips.org, linuxppc-embedded@lists.linuxppc.org
Subject: Intel Pro 82546 chipset performance
Date: Wed, 14 Jan 2004 06:36:39 +0000
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <BAY10-F117sntMQN8zy00008864@hotmail.com>
X-OriginalArrivalTime: 14 Jan 2004 06:36:39.0628 (UTC) FILETIME=[C3FFC8C0:01C3DA68]
Return-Path: <sagarwal10@hotmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3935
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sagarwal10@hotmail.com
Precedence: bulk
X-list: linux-mips

Hi

We're trying to use the Intel Pro 1000 adapters with the 82546 chipset
for a packet switching application. Has anyone investigated performance
on this chipset? With minimum sized ethernet frames, the maximum throughput
I can get is about 1 million packets per second (versus a 1.4 mill for line 
rate
on a gigethernet) and it looks that performance is skewed towards receiving
traffic (rather than sending out).

If anyone has any opinions or thoughts I'd appreciate them. It's hard to
get information out of Intel.

_________________________________________________________________
Find out everything you need to know about Las Vegas here for that getaway.  
http://special.msn.com/msnbc/vivalasvegas.armx
