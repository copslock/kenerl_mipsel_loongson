Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 31 Mar 2009 20:44:22 +0100 (BST)
Received: from static-72-72-73-123.bstnma.east.verizon.net ([72.72.73.123]:44206
	"EHLO imap-1.sicortex.com") by ftp.linux-mips.org with ESMTP
	id S20023325AbZCaToP (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 31 Mar 2009 20:44:15 +0100
Received: from localhost (localhost [127.0.0.1])
	by imap-1.sicortex.com (Postfix) with ESMTP id 2EC8BB9E61;
	Tue, 31 Mar 2009 15:44:08 -0400 (EDT)
X-Virus-Scanned: amavisd-new at sicortex.com
Received: from imap-1.sicortex.com ([127.0.0.1])
	by localhost (imap-1.sicortex.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id VMPyfMIWAtvd; Tue, 31 Mar 2009 15:44:03 -0400 (EDT)
Received: from [10.0.1.104] (gs104.sicortex.com [10.0.1.104])
	by imap-1.sicortex.com (Postfix) with ESMTP id 0CC3FB9E53;
	Tue, 31 Mar 2009 15:43:50 -0400 (EDT)
Message-ID: <49D27275.6060006@sicortex.com>
Date:	Tue, 31 Mar 2009 15:43:49 -0400
From:	Peter Watkins <pwatkins@sicortex.com>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050831)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To:	colin@realtek.com.tw
CC:	linux-mips@linux-mips.org
Subject: Re: The impact to change page size to 16k for cache alias
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <pwatkins@sicortex.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22220
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: pwatkins@sicortex.com
Precedence: bulk
X-list: linux-mips

Hi Colin,

When we went to 64K pages we had to get a firmware upgrade for a myrinet card. As I recall it was already OK for 16K pages. 

For mellanox cards we had to set a .ini parameter, log2_uar_bar_megabytes. Send me a note if you want more details.

Other than that, the drivers we tried just worked (qla24xxx, e1000, tg3, sata sil, sil24).

--Peter
