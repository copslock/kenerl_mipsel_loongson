Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 29 Jan 2004 07:26:58 +0000 (GMT)
Received: from [IPv6:::ffff:65.205.244.70] ([IPv6:::ffff:65.205.244.70]:19330
	"EHLO envy.pioneer-pra.com") by linux-mips.org with ESMTP
	id <S8224985AbUA2H05>; Thu, 29 Jan 2004 07:26:57 +0000
Received: from localhost (localhost.localdomain [127.0.0.1])
	by envy.pioneer-pra.com (Postfix) with ESMTP id D168A3778C
	for <linux-mips@linux-mips.org>; Wed, 28 Jan 2004 23:26:30 -0800 (PST)
Received: from envy.pioneer-pra.com ([127.0.0.1])
 by localhost (envy.pioneer-pra.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 14536-01 for <linux-mips@linux-mips.org>;
 Wed, 28 Jan 2004 23:26:29 -0800 (PST)
Received: from pioneer-pra.com (host-186.int.pioneer-pra.com [10.0.2.186])
	by envy.pioneer-pra.com (Postfix) with ESMTP id 8EAA03775A
	for <linux-mips@linux-mips.org>; Wed, 28 Jan 2004 23:26:29 -0800 (PST)
Message-ID: <4018B5C6.6080109@pioneer-pra.com>
Date: Wed, 28 Jan 2004 23:27:02 -0800
From: Russell Berkoff <rberkoff@pioneer-pra.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20020830
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-mips@linux-mips.org
Subject: /proc/net/softnet_stat
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: by amavisd-new at pioneer-pra.com
Return-Path: <rberkoff@pioneer-pra.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4183
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rberkoff@pioneer-pra.com
Precedence: bulk
X-list: linux-mips

Hi,

netdev_rx_stat[...].total++; in net/core/dev.c.

Appears to be redundant increment in: netif_rx() and netif_receive_skb().

Regards,
rb
