Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 23 Apr 2003 08:23:31 +0100 (BST)
Received: from f23.law11.hotmail.com ([IPv6:::ffff:64.4.17.23]:19467 "EHLO
	hotmail.com") by linux-mips.org with ESMTP id <S8225209AbTDWHXa>;
	Wed, 23 Apr 2003 08:23:30 +0100
Received: from mail pickup service by hotmail.com with Microsoft SMTPSVC;
	 Wed, 23 Apr 2003 00:23:19 -0700
Received: from 203.197.124.190 by lw11fd.law11.hotmail.msn.com with HTTP;
	Wed, 23 Apr 2003 07:23:19 GMT
X-Originating-IP: [203.197.124.190]
X-Originating-Email: [debashismahata@hotmail.com]
From: "Debashis Mahata" <debashismahata@hotmail.com>
To: linux-mips@linux-mips.org
Subject: Need help: LEXRA
Date: Wed, 23 Apr 2003 12:53:19 +0530
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <Law11-F23vBGtWva7DY00002848@hotmail.com>
X-OriginalArrivalTime: 23 Apr 2003 07:23:19.0816 (UTC) FILETIME=[37291080:01C30969]
Return-Path: <debashismahata@hotmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2150
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: debashismahata@hotmail.com
Precedence: bulk
X-list: linux-mips


Hi all,

I have a doubt regarding linux support on Lexra processor.
I am trying to enbale interrupts on that boards.

Do I strictly need to use the Lexra specific registers and instructions 
(e.g. mflxc0
etc) to enable the interrupts(specifically timer interrupt)?

Is it possible to enable the timer interrupt in Lexra by using normal cp0 
registers,
which is supported by the general mips architecture?

Is their any toolchain is available which lexra support?

Any other hints/suggestoin are welcome.


Thanks in advance.

Regards,
debashis


_________________________________________________________________
MSN Instyle. Keeps you in sync. http://server1.msn.co.in/instyle/index.asp 
Always!
