Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 28 Aug 2009 08:41:58 +0200 (CEST)
Received: from mail-px0-f172.google.com ([209.85.216.172]:36654 "EHLO
	mail-px0-f172.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1492384AbZH1Glv (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 28 Aug 2009 08:41:51 +0200
Received: by pxi2 with SMTP id 2so1676819pxi.0
        for <linux-mips@linux-mips.org>; Thu, 27 Aug 2009 23:41:41 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type;
        bh=mrZAndV42GxvsASaBpCiRp75DrHOCIxYDKnBWTRTUKY=;
        b=ImXWTXAwrV2C7Sz0lfOlJ1PopJuiL0x5ULCBwto1ruWcZMyUQGLe92AeNTUqQKfME0
         yeCs1TBGtdPMVjkL44u2OYp6amtVLrwWikxPPEeE8kXSxe8keE4idicnjbkCBnSgnGjK
         /3HfZghJv+ed2eKnYe0gbourYvBrXgsIh/2aI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=axPLC1PtzQhf5JNHPWrhaVeQISiBElptwo8oiS1qqMXwFlay6a7NxZCMJB/kcoRtFw
         4LrLp4FWbqATRgkpjHJyrWuudiH/2m5JdZ4pHVgsRET3l73ix7cxm1ExGdNhBxPWMRx5
         OcP+I88EhB4OwwArd5HenQeq8JNEETLl+cZMQ=
MIME-Version: 1.0
Received: by 10.142.209.19 with SMTP id h19mr40444wfg.129.1251441701631; Thu, 
	27 Aug 2009 23:41:41 -0700 (PDT)
Date:	Fri, 28 Aug 2009 14:41:41 +0800
Message-ID: <3a665c760908272341h1b3d21afmda7415282c40261b@mail.gmail.com>
Subject: how to make /dev/random work?
From:	loody <miloody@gmail.com>
To:	Kernel Newbies <kernelnewbies@nl.linux.org>,
	Linux MIPS Mailing List <linux-mips@linux-mips.org>
Content-Type: text/plain; charset=ISO-8859-1
Return-Path: <miloody@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23947
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: miloody@gmail.com
Precedence: bulk
X-list: linux-mips

Dear all:
I made linux running on Mips machine.
Right now I found the /dev/random doesn't work properly, since I use
"dd if=/dev/random of=/tmp/random.txt", it stops working.
If I use "cat /dev/random", it will not pop out anything.

Is there any setting I forget while make menuconfig or should i add
another driver for /dev/random such that I can make /dev/random work?
appreciate your help,
miloody
