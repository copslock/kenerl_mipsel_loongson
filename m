Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 20 Feb 2003 21:15:13 +0000 (GMT)
Received: from port48.ds1-vbr.adsl.cybercity.dk ([IPv6:::ffff:212.242.58.113]:45886
	"EHLO valis.localnet") by linux-mips.org with ESMTP
	id <S8225198AbTBTVPM>; Thu, 20 Feb 2003 21:15:12 +0000
Received: from murphy.dk (brm@brian.localnet [10.0.0.2])
	by valis.localnet (8.12.7/8.12.7/Debian-2) with ESMTP id h1KLDt6n014046;
	Thu, 20 Feb 2003 22:13:55 +0100
Message-ID: <3E55455A.8080403@murphy.dk>
Date: Thu, 20 Feb 2003 22:15:06 +0100
From: Brian Murphy <brian@murphy.dk>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020623 Debian/1.0.0-0.woody.1
MIME-Version: 1.0
To: Jun Sun <jsun@mvista.com>
CC: linux-mips@linux-mips.org
Subject: Re: [PATCH] allow CROSS_COMPILE override
References: <20030220124703.H7466@mvista.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <brian@murphy.dk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1490
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: brian@murphy.dk
Precedence: bulk
X-list: linux-mips

Jun Sun wrote:

>Anybody would object this?  It allows one to override
>
Why not but this is less messy:

--- arch/mips/Makefile  13 Dec 2002 23:41:09 -0000      1.1.1.8
+++ arch/mips/Makefile  20 Feb 2003 21:10:30 -0000
@@ -23,7 +23,7 @@
 endif
 
 ifdef CONFIG_CROSSCOMPILE
-CROSS_COMPILE  = $(tool-prefix)
+CROSS_COMPILE ?= $(tool-prefix)
 endif
 
 #

/Brian
