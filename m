Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 07 Feb 2005 22:52:43 +0000 (GMT)
Received: from imap.gmx.net ([IPv6:::ffff:213.165.64.20]:62183 "HELO
	mail.gmx.net") by linux-mips.org with SMTP id <S8224935AbVBGWw2>;
	Mon, 7 Feb 2005 22:52:28 +0000
Received: (qmail invoked by alias); 07 Feb 2005 22:52:21 -0000
Received: from c162014.adsl.hansenet.de (EHLO [192.168.0.1]) (213.39.162.14)
  by mail.gmx.net (mp007) with SMTP; 07 Feb 2005 23:52:21 +0100
X-Authenticated: #947741
Message-ID: <4207F163.4010605@gmx.net>
Date:	Mon, 07 Feb 2005 23:53:23 +0100
From:	TheNop <TheNop@gmx.net>
User-Agent: Mozilla Thunderbird 0.7.3 (Windows/20040803)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To:	linux-mips@linux-mips.org
Subject: Kernel crash on yosemite
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Return-Path: <TheNop@gmx.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7192
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: TheNop@gmx.net
Precedence: bulk
X-list: linux-mips

Hi ,

This is my configuration:
~ yosemite board with RM9000 chip revision 1.1
~ BusyBox 1.0
~ Kernel 2.6.8.1

When I try to copy a large file (~ 3,5 Mb) within the NFS file system 
the kernel crashs without any output on the console.
It could be a problem with the titan_ge driver, but I have no idee how 
to solve the problem.

What can I do?

Best regards
TheNop
