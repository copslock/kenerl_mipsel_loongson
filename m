Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 22 Mar 2005 18:42:23 +0000 (GMT)
Received: from mxout4.netvision.net.il ([IPv6:::ffff:194.90.9.27]:10965 "EHLO
	mxout4.netvision.net.il") by linux-mips.org with ESMTP
	id <S8227123AbVCVSmI>; Tue, 22 Mar 2005 18:42:08 +0000
Received: from [192.168.1.199] ([212.143.245.6]) by mxout4.netvision.net.il
 (Sun Java System Messaging Server 6.1 HotFix 0.09 (built Dec 14 2004))
 with ESMTP id <0IDR00MKVNY2VB70@mxout4.netvision.net.il> for
 linux-mips@linux-mips.org; Tue, 22 Mar 2005 20:42:02 +0200 (IST)
Date:	Tue, 22 Mar 2005 20:42:14 +0200
From:	Gilad Rom <gilad@romat.com>
Subject: Au1500 and 1Gbps
To:	"'linux-mips@linux-mips.org'" <linux-mips@linux-mips.org>
Message-id: <42406706.90409@romat.com>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1; format=flowed
Content-transfer-encoding: 7BIT
X-Accept-Language: en-us, en
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
Return-Path: <gilad@romat.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7506
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: gilad@romat.com
Precedence: bulk
X-list: linux-mips

Hello,

As a follow up to my last posting, I was wondering if anyone
ever actually benchmarked the Au1500 in terms of networking
throughput.

We make a custom board, based on the Au1500. 100Mbps
performance is 100% (100Mbps FTP transfers when using brctl to bridge
both ethernet MAC's), but What we would like to do, ultimately,
is build a board with two Gigabit MAC/PHY's and use our board
to construct a much more powerful gateway.

Any insight? can the Au1500 even try to handle 1000Mbps?

Thanks,
Gilad.
