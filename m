Received:  by oss.sgi.com id <S42232AbQJEKKr>;
	Thu, 5 Oct 2000 03:10:47 -0700
Received: from noose.gt.owl.de ([62.52.19.4]:12300 "HELO noose.gt.owl.de")
	by oss.sgi.com with SMTP id <S42201AbQJEKKW>;
	Thu, 5 Oct 2000 03:10:22 -0700
Received: by noose.gt.owl.de (Postfix, from userid 10)
	id 5E8487D9; Thu,  5 Oct 2000 12:09:39 +0200 (CEST)
Received: by paradigm.rfc822.org (Postfix, from userid 1000)
	id 1FA039014; Thu,  5 Oct 2000 12:08:43 +0200 (CEST)
Date:   Thu, 5 Oct 2000 12:08:43 +0200
From:   Florian Lohoff <flo@rfc822.org>
To:     linux-mips@oss.sgi.com
Subject: Current CVS kernel doesnt compile
Message-ID: <20001005120843.D346@paradigm.rfc822.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
User-Agent: Mutt/1.0.1i
Organization: rfc822 - pure communication
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing


/var/tmp/mips/src/linux-decr4k-current/include/asm/semaphore-helper.h: In function `waking_non_zero':
In file included from semaphore.c:7:
/var/tmp/mips/src/linux-decr4k-current/include/asm/semaphore-helper.h:95: warning: implicit declaration of function `__atomic_fool_gcc'
/var/tmp/mips/src/linux-decr4k-current/include/asm/semaphore-helper.h:96: output number 2 not directly addressable
make[1]: *** [semaphore.o] Error 1
make[1]: Leaving directory `/var/tmp/mips/src/linux-decr4k-current/arch/mips/kernel'
make: *** [_dir_arch/mips/kernel] Error 2
You have mail in /var/spool/mail/flo

-- 
Florian Lohoff		flo@rfc822.org		      	+49-5201-669912
      "Write only memory - Oops. Time for my medication again ..."
