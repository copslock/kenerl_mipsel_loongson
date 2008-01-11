Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 11 Jan 2008 12:30:39 +0000 (GMT)
Received: from mail.gmx.net ([213.165.64.20]:13967 "HELO mail.gmx.net")
	by ftp.linux-mips.org with SMTP id S28579017AbYAKMab (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 11 Jan 2008 12:30:31 +0000
Received: (qmail invoked by alias); 11 Jan 2008 12:30:24 -0000
Received: from dslb-088-074-241-028.pools.arcor-ip.net (EHLO [192.168.1.100]) [88.74.241.28]
  by mail.gmx.net (mp052) with SMTP; 11 Jan 2008 13:30:24 +0100
X-Authenticated: #44099387
X-Provags-ID: V01U2FsdGVkX18e2fZIv4AeMT2KTuoAJ9uHABDwWNSUbY0Zq+5iSZ
	A05MqADIqsAw3b
Message-ID: <47876160.90702@gmx.net>
Date:	Fri, 11 Jan 2008 13:30:24 +0100
From:	Andi <opencode@gmx.net>
User-Agent: Thunderbird 2.0.0.6 (X11/20071022)
MIME-Version: 1.0
To:	linux-mips@linux-mips.org
Subject: Re: memory dump on mips
References: <4783754D.8010007@gmx.net>
In-Reply-To: <4783754D.8010007@gmx.net>
X-Enigmail-Version: 0.95.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Return-Path: <opencode@gmx.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17984
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: opencode@gmx.net
Precedence: bulk
X-list: linux-mips

Hello,

we now figured out how to dump the memory at a certain address.
As I already said we want to create dump the kernel running on the
system. Unfortunately we don't know the "magic code" to look for in the
dump in order to find the starting position of the image.
I couldn't find a ".ELF" in the dump, so far.

Can you please point me to where I can find the right information how
such a kernel-image might look like?


Thank you very much in advance

Regards,

Andi
