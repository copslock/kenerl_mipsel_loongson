Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 18 Nov 2004 20:13:51 +0000 (GMT)
Received: from pop.gmx.de ([IPv6:::ffff:213.165.64.20]:1668 "HELO mail.gmx.net")
	by linux-mips.org with SMTP id <S8224937AbUKRUNr>;
	Thu, 18 Nov 2004 20:13:47 +0000
Received: (qmail 12381 invoked by uid 65534); 18 Nov 2004 20:13:40 -0000
Received: from c210132.adsl.hansenet.de (EHLO [192.168.0.1]) (213.39.210.132)
  by mail.gmx.net (mp013) with SMTP; 18 Nov 2004 21:13:40 +0100
X-Authenticated: #947741
Message-ID: <419D03DE.8090403@gmx.net>
Date: Thu, 18 Nov 2004 21:19:42 +0100
From: TheNop <TheNop@gmx.net>
User-Agent: Mozilla Thunderbird 0.7.3 (Windows/20040803)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-mips@linux-mips.org
Subject: Titan ethernet driver broken
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <TheNop@gmx.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6358
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: TheNop@gmx.net
Precedence: bulk
X-list: linux-mips

Hello,

using DHCP support on the yosemite target with the current sources did 
not work anymore.
The DHCP request timed out.
Using the sources from cvs lable linux_2_6_8_1 for the titan ethernet 
driver works around this problem.

Best regards
TheNop
