Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 21 Jul 2005 19:19:17 +0100 (BST)
Received: from mail.gmx.de ([IPv6:::ffff:213.165.64.20]:44733 "HELO
	mail.gmx.net") by linux-mips.org with SMTP id <S8225225AbVGUSTC>;
	Thu, 21 Jul 2005 19:19:02 +0100
Received: (qmail invoked by alias); 21 Jul 2005 18:20:55 -0000
Received: from d075225.adsl.hansenet.de (EHLO [192.168.0.1]) [80.171.75.225]
  by mail.gmx.net (mp029) with SMTP; 21 Jul 2005 20:20:55 +0200
X-Authenticated: #947741
Message-ID: <42DFE794.70001@gmx.net>
Date:	Thu, 21 Jul 2005 20:21:08 +0200
From:	TheNop <TheNop@gmx.net>
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
X-Accept-Language: de-DE, de, en-us, en
MIME-Version: 1.0
To:	linux-mips@linux-mips.org
Subject: Problems with virtual terminal
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Return-Path: <TheNop@gmx.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8590
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: TheNop@gmx.net
Precedence: bulk
X-list: linux-mips

Hi all,

I want to use virtual terminal to get tty support for using Xorg on a fb 
device.
I' m using linux-mips 2.6.12-rc4.
When I enable the virtual terminal option in the kernel config the 
kernel hangs directly after boot. The console parameter is set to ttyS0, 
so I expect some output on the serial port, but nothing happens.

Is there someone using virtual terminals?
Any ideas what went wrong with vt?

Beste regards
TheNop
