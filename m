Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 27 Jan 2005 21:02:11 +0000 (GMT)
Received: from eth13.com-link.com ([IPv6:::ffff:208.242.241.164]:58833 "EHLO
	real.realitydiluted.com") by linux-mips.org with ESMTP
	id <S8225244AbVA0VBy>; Thu, 27 Jan 2005 21:01:54 +0000
Received: from sjhill by real.realitydiluted.com with local (Exim 4.34 #1 (Debian))
	id 1CuGlf-0000cy-Pl; Thu, 27 Jan 2005 15:01:31 -0600
Subject: Re: [PATCH] ADM5120 for 2.6.10
In-Reply-To: <41F9503E.5030004@amsat.org>
To:	Jeroen Vreeken <pe1rxq@amsat.org>
Date:	Thu, 27 Jan 2005 15:01:31 -0600 (CST)
CC:	linux-mips@linux-mips.org
X-Mailer: ELM [version 2.4ME+ PL100 (25)]
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII
Message-Id: <E1CuGlf-0000cy-Pl@real.realitydiluted.com>
From:	sjhill@realitydiluted.com
Return-Path: <sjhill@realitydiluted.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7047
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sjhill@realitydiluted.com
Precedence: bulk
X-list: linux-mips

Greetings.

First, thank you for your patch. However, there are a number of things
that you have to do before it will be accepted.

   1) You should be creating your patch against the Linux/MIPS kernel
      tree present in CVS. You can go to http://www.linux-mips.org/
      to see how to get the latest code.

   2) Change your machine config definition of 'MIPS_AM5120' to be
      'MIPS_ADM5120' as it makes more sense.

   3) A number of your files, 'arch/mips/am5120/5120_rtc.c' for an
      example, has an unacceptable copyright banner in it. Your code
      will not be accepted unless it is licensed under GPL or a shared
      BSD style license. Please speak with your management and get
      approval. You will also need to sign off your code contribution.

   4) It might be good to have your serial driver up in 'drivers/serial'
      instead of down in 'arch/mips' somewhere. Perhaps someone else
      will have comments on that.

   5) Your PCI code should be located in 'arch/mips/pci'.

   6) Your change to 'include/linux/init.h' for early init calls
      is unnecessary. The latest tree already supports this and
      the linker script takes care of placing them in the proper
      section.

After you have addressed the issues above, please re-submit your patch.
Thanks!

-Steve
