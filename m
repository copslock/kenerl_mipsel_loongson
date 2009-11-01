Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 01 Nov 2009 15:18:31 +0100 (CET)
Received: from mail-pz0-f194.google.com ([209.85.222.194]:49696 "EHLO
	mail-pz0-f194.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1492455AbZKAOSY (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sun, 1 Nov 2009 15:18:24 +0100
Received: by pzk32 with SMTP id 32so2841335pzk.21
        for <linux-mips@linux-mips.org>; Sun, 01 Nov 2009 06:18:14 -0800 (PST)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type;
        bh=Rt2L/ZB+Z17wJIaWyEFr4okbRv6QaYlauMGBX+WpmUw=;
        b=xtrT4Bfb//mT/CwkehSmSCMzruCCyuxLMFPSSwzjOr5hHPVkmFrJ14V/VDFxOovf6m
         P6HFMavxM7x1+OW1dR/GYkNR7p+78Tf3hhhDxHkIdnhpMAk4bErP2EV1qH9hr1OZdNiZ
         wJWXM7g40HnB3X0TniU63nwd56L/7HMxzJHWI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=yDpl2u+Hj5iLSTRTekjQEW6SsaqOUG91d/zNnPgDMhAk8eDMqi5BXPU8FZfmEs6ggO
         t2LiTl6Rc+kyT6KvP5FvbqXsW5rQNl5ukgTNUhKJROc/f2XKOaLZqhdFLpUnYIJc/78K
         J8/atAyYEYjhEFpuah7Huz2eTcYQ9PEWE+7VE=
MIME-Version: 1.0
Received: by 10.142.152.1 with SMTP id z1mr324756wfd.322.1257085094528; Sun, 
	01 Nov 2009 06:18:14 -0800 (PST)
Date:	Sun, 1 Nov 2009 22:18:14 +0800
Message-ID: <3a665c760911010618u7216cd68wfbd02610d2029862@mail.gmail.com>
Subject: why we use multu to implement udelay
From:	loody <miloody@gmail.com>
To:	Linux MIPS Mailing List <linux-mips@linux-mips.org>
Content-Type: text/plain; charset=ISO-8859-1
Return-Path: <miloody@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24599
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: miloody@gmail.com
Precedence: bulk
X-list: linux-mips

Dear all:
If I search the right place in mip kernel, I find the kernel implement
udelay by multu and bnez looping, in 32-bits mode.
	if (sizeof(long) == 4)
		__asm__("multu\t%2, %3"
		: "=h" (usecs), "=l" (lo)
		: "r" (usecs), "r" (lpj)
		: GCC_REG_ACCUM);
	else if (sizeof(long) == 8)
		__asm__("dmultu\t%2, %3"
		: "=h" (usecs), "=l" (lo)
		: "r" (usecs), "r" (lpj)
		: GCC_REG_ACCUM);

	__delay(usecs);
why we doing so instead of using kernel timer function and the
precision will be incorrect if the cpu runs faster or slower, right?
appreciate your help,
miloody
