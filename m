Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 19 Nov 2003 01:40:48 +0000 (GMT)
Received: from avtrex.com ([IPv6:::ffff:216.102.217.178]:62797 "EHLO
	avtrex.com") by linux-mips.org with ESMTP id <S8225397AbTKSBkg>;
	Wed, 19 Nov 2003 01:40:36 +0000
Received: from avtrex.com ([192.168.0.111] RDNS failed) by avtrex.com with Microsoft SMTPSVC(5.0.2195.6713);
	 Tue, 18 Nov 2003 17:40:31 -0800
Message-ID: <3FBACA0F.7070207@avtrex.com>
Date: Tue, 18 Nov 2003 17:40:31 -0800
From: David Daney <ddaney@avtrex.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021130
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-mips@linux-mips.org
Subject: How reliable is GCC-3.3.1 wrt building mipsel-linux kernel?
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 19 Nov 2003 01:40:31.0858 (UTC) FILETIME=[1E733D20:01C3AE3E]
Return-Path: <ddaney@avtrex.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3641
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@avtrex.com
Precedence: bulk
X-list: linux-mips

The subject line kind of says it all.

We are running linux 2.4.18 on a mips4Kc core (ATI Xilleon 225) and find 
it to be quite stable when compiled with gcc 2.96/binutils 2.11.92.0.10

When the kernel is compiled with gcc 3.3.1/binutils 2.14.90.0.5 it also 
seems to be quite stable, except for when one certian driver is used 
(basically an mpeg decoder driver).  Under certian conditions the system 
seems to "freeze" (no messages printed anywhere and only a hard reset 
will recover).

Yeah that is a good bug report...

But my main question is this:  Have other people experienced 
miscompilation (ie bad code generation) with gcc 3.3.1?

One thing I am aware of is that if -fno-common is not used, bad code is 
generated for accessing some large structures.  But I we use -fno-common 
for all compilation.

I am trying to figrue out if I should be looking more at bugs in the 
driver, or if I should give up on gcc 3.3.1 and be done with it.

Thanks in advance for any insight.

David Daney.
