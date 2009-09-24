Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 25 Sep 2009 00:27:37 +0200 (CEST)
Received: from mail.upwardaccess.com ([70.89.180.121]:3273 "EHLO
	upwardaccess.com" rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org
	with ESMTP id S2097344AbZIXW1b (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 25 Sep 2009 00:27:31 +0200
Received: from hawaii.upwardaccess.com (unverified [10.61.7.126]) 
	by upwardaccess.com (SurgeMail 3.9e) with ESMTP id 926945-1847469 
	for <linux-mips@linux-mips.org>; Thu, 24 Sep 2009 15:27:19 -0700
Received: by hawaii.upwardaccess.com (Postfix, from userid 500)
	id 6E11835425C; Thu, 24 Sep 2009 15:27:19 -0700 (PDT)
Date:	Thu, 24 Sep 2009 15:27:19 -0700
From:	Mark Mason <mmason@upwardaccess.com>
To:	linux-mips@linux-mips.org
Subject: linux-mips.git broken compiling for smp targets
Message-ID: <20090924222719.GA18095@upwardaccess.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Originating-IP: 10.61.7.126
X-Authenticated-User: mmason@upwardaccess.com 
Return-Path: <mason@upwardaccess.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24096
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mmason@upwardaccess.com
Precedence: bulk
X-list: linux-mips

Hello all,

I'm getting the following compiling for my bcm1480:

  CALL    scripts/checksyscalls.sh
  CHK     include/linux/compile.h
  CC      arch/mips/kernel/smp.o
arch/mips/kernel/smp.c: In function `arch_send_call_function_single_ipi':
arch/mips/kernel/smp.c:140: error: incompatible type for argument 1 of indirect function call
make[1]: *** [arch/mips/kernel/smp.o] Error 1
make: *** [arch/mips/kernel] Error 2

Anyone else running into this?

Thanks,
Mark
