Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 12 Oct 2006 22:43:45 +0100 (BST)
Received: from farad.aurel32.net ([82.232.2.251]:24044 "EHLO farad.aurel32.net")
	by ftp.linux-mips.org with ESMTP id S20038516AbWJLVnl (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 12 Oct 2006 22:43:41 +0100
Received: from bode.aurel32.net ([2001:618:400:fc13:211:9ff:feed:c498] helo=[IPv6:2001:618:400:fc13:211:9ff:feed:c498])
	by farad.aurel32.net with esmtps (TLS-1.0:DHE_RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1GY8L2-00038s-3q; Thu, 12 Oct 2006 23:43:36 +0200
Message-ID: <452EB653.7070604@aurel32.net>
Date:	Thu, 12 Oct 2006 23:40:35 +0200
From:	Aurelien Jarno <aurelien@aurel32.net>
User-Agent: Thunderbird 1.5.0.7 (X11/20060927)
MIME-Version: 1.0
To:	linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Subject: SYS_personality does not work correctly on mips(el)64
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <aurelien@aurel32.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12924
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: aurelien@aurel32.net
Precedence: bulk
X-list: linux-mips

Hi all,

On mips(el), when doing multiple call to the syscall SYS_personality in 
order to get the current personality (using 0xffffffff for the first 
argument), on a 64-bit kernel, the second and subsequent syscalls are 
failing. That works correctly with a 32-bit kernels and on other 
architectures.

Here is a small test below:

#include <sys/personality.h>
#include <stdio.h>

void main()
{
   printf("%i\n", personality(0xFFFFFFFF));
   printf("%i\n", personality(0xFFFFFFFF));
}


Bye,
Aurelien
-- 
   .''`.  Aurelien Jarno	            | GPG: 1024D/F1BCDB73
  : :' :  Debian developer           | Electrical Engineer
  `. `'   aurel32@debian.org         | aurelien@aurel32.net
    `-    people.debian.org/~aurel32 | www.aurel32.net
