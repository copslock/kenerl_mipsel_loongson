Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 26 Mar 2004 14:10:53 +0000 (GMT)
Received: from [IPv6:::ffff:145.253.187.130] ([IPv6:::ffff:145.253.187.130]:6665
	"EHLO proxy.baslerweb.com") by linux-mips.org with ESMTP
	id <S8225255AbUCZOKw>; Fri, 26 Mar 2004 14:10:52 +0000
Received: from comm1.baslerweb.com ([172.16.13.2]) by proxy.baslerweb.com
          (Post.Office MTA v3.5.3 release 223 ID# 0-0U10L2S100V35)
          with ESMTP id com; Fri, 26 Mar 2004 15:10:56 +0100
Received: from 172.16.13.253 (localhost [172.16.13.253]) by comm1.baslerweb.com with SMTP (Microsoft Exchange Internet Mail Service Version 5.5.2657.72)
	id H3NK0Z5A; Fri, 26 Mar 2004 15:10:51 +0100
From: Thomas Koeller <thomas.koeller@baslerweb.com>
Organization: Basler AG
To: lachwani@pmc-sierra.com
Subject: titan ethernet driver
Date: Fri, 26 Mar 2004 15:12:06 +0100
User-Agent: KMail/1.5.2
Cc: linux-mips@linux-mips.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200403261512.06502.thomas.koeller@baslerweb.com>
Return-Path: <thomas.koeller@baslerweb.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4656
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: thomas.koeller@baslerweb.com
Precedence: bulk
X-list: linux-mips

Hi Manish,

I am trying to use your titan ethernet driver. I
found that I could not compile it for a 2.6.4
kernel, because it uses 2.4 kernel APIs. When
fixing that I found that the code contains
obvious errors; it does not even compile unchanged.
This makes me a bit uneasy. Would you mind
commenting on the state of this driver? Are there
any newer sources than those contained in CVS at
linux-mips.org?

tk
-- 
--------------------------------------------------

Thomas Koeller, Software Development
Basler Vision Technologies

thomas dot koeller at baslerweb dot com
http://www.baslerweb.com

==============================
