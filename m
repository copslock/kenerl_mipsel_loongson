Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 20 Oct 2004 18:48:45 +0100 (BST)
Received: from [IPv6:::ffff:145.253.187.134] ([IPv6:::ffff:145.253.187.134]:933
	"EHLO mail01.baslerweb.com") by linux-mips.org with ESMTP
	id <S8225228AbUJTRsk>; Wed, 20 Oct 2004 18:48:40 +0100
Received: from mail01.baslerweb.com (localhost.localdomain [127.0.0.1])
	by localhost.domain.tld (Basler) with ESMTP
	id 5E6BC13402D; Wed, 20 Oct 2004 19:47:52 +0200 (CEST)
Received: from comm1.baslerweb.com (unknown [172.16.13.2])
	by mail01.baslerweb.com (Basler) with ESMTP
	id 5BCA513402C; Wed, 20 Oct 2004 19:47:52 +0200 (CEST)
Received: from vclinux-1.basler.corp (localhost [172.16.13.253]) by comm1.baslerweb.com with SMTP (Microsoft Exchange Internet Mail Service Version 5.5.2657.72)
	id 4YRPMXKB; Wed, 20 Oct 2004 19:48:29 +0200
From: Thomas Koeller <thomas.koeller@baslerweb.com>
Organization: Basler AG
To: Manish Lachwani <mlachwani@mvista.com>
Subject: yosemite interrupt setup
Date: Wed, 20 Oct 2004 19:52:29 +0200
User-Agent: KMail/1.6.2
Cc: linux-mips@linux-mips.org
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200410201952.29205.thomas.koeller@baslerweb.com>
Return-Path: <thomas.koeller@baslerweb.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6131
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: thomas.koeller@baslerweb.com
Precedence: bulk
X-list: linux-mips

Hi Manish,

may I ask you to help me with this:

I am currently analyzing the yosemite interrupt handling
code. So far I have not been able to find the point
where the association between a particular external or
message interrupt and its vector is established. It seems
that the corresponding OCD address definitions from
asm-mips/titan_dep.h, such as RM9000x2_OCD_INTPIN0, are
not used anywhere in the code. I guess the kernel does
not rely on PMON having set up this before, or does it?

thanks,
Thomas

-- 
--------------------------------------------------

Thomas Koeller, Software Development
Basler Vision Technologies

thomas dot koeller at baslerweb dot com
http://www.baslerweb.com

==============================
