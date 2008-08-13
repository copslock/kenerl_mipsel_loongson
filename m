Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 13 Aug 2008 01:24:02 +0100 (BST)
Received: from mail.windriver.com ([147.11.1.11]:41983 "EHLO mail.wrs.com")
	by ftp.linux-mips.org with ESMTP id S28593019AbYHMAXz (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 13 Aug 2008 01:23:55 +0100
Received: from ALA-MAIL03.corp.ad.wrs.com (ala-mail03 [147.11.57.144])
	by mail.wrs.com (8.13.6/8.13.6) with ESMTP id m7D0NiTF011332;
	Tue, 12 Aug 2008 17:23:45 -0700 (PDT)
Received: from ala-mail06.corp.ad.wrs.com ([147.11.57.147]) by ALA-MAIL03.corp.ad.wrs.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Tue, 12 Aug 2008 17:23:44 -0700
Received: from [147.11.222.75] ([147.11.222.75]) by ala-mail06.corp.ad.wrs.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Tue, 12 Aug 2008 17:23:44 -0700
Message-ID: <48A2298F.6020601@loowit.net>
Date:	Tue, 12 Aug 2008 17:23:43 -0700
From:	James Perkins <james@loowit.net>
User-Agent: Thunderbird 2.0.0.14 (X11/20080501)
MIME-Version: 1.0
To:	Fahim Ansari <fahim@redback.com>
CC:	linux-mips@linux-mips.org
Subject: Re: Cavium support
References: <48A22045.4060503@redback.com>
In-Reply-To: <48A22045.4060503@redback.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 13 Aug 2008 00:23:44.0559 (UTC) FILETIME=[D882F3F0:01C8FCDA]
Return-Path: <james@loowit.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20195
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: james@loowit.net
Precedence: bulk
X-list: linux-mips

Fahim Ansari wrote:
> I want to build a kernel that will boot on a cavium octeon board. Is the 
> cavium octeon cpuset supported for the linux kernels available at 
> linux-mips.org.
> Or is such a kernel available at any other git repository?

I'm not aware of any public git repositories tracking OCTEON at present. The 
current linux-mips.org project has no support for Cavium Networks OCTEON. 
There are commercial ports available: Cavium's SDK, and in embedded Linux 
distributions from Wind River and Montavista. You may want to try contacting 
Cavium at their website.

Cheers,
James Perkins
james@loowit.net
