Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 26 Jan 2010 22:19:39 +0100 (CET)
Received: from smtp6-g21.free.fr ([212.27.42.6]:52040 "EHLO smtp6-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1493441Ab0AZVTg (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 26 Jan 2010 22:19:36 +0100
Received: from smtp6-g21.free.fr (localhost [127.0.0.1])
        by smtp6-g21.free.fr (Postfix) with ESMTP id 5F9BBE080B8;
        Tue, 26 Jan 2010 22:19:31 +0100 (CET)
Received: from p11 (rob92-10-88-171-126-4.fbx.proxad.net [88.171.126.4])
        by smtp6-g21.free.fr (Postfix) with ESMTP id E4F85E080A9;
        Tue, 26 Jan 2010 22:19:28 +0100 (CET)
Message-Id: <i8xpr4wftsy.fsf@pabr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Date:   Tue, 26 Jan 2010 22:19:22 +0100
From:   pascal@pabr.org
To:     Manuel Lauss <manuel.lauss@googlemail.com>
Cc:     linux-mips@linux-mips.org
Subject: Re: [RFC] Support 36-bit iomem on 32-bit Au1x00
In-Reply-To: <f861ec6f1001261246y545e7a9ahe11eaf16fd587959@mail.gmail.com>
References: <hhq35v$m1q$1@ger.gmane.org>
        <f861ec6f1001261246y545e7a9ahe11eaf16fd587959@mail.gmail.com>
X-archive-position: 25692
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: pascal@pabr.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 16953

Manuel Lauss writes:
 > Have you tried to register a platform device above the 4G line?  I get an oops
 > inside the platform device match code  when I do.  I'll try to figure out why.

Yes, I used these patches on top of 2.6.33-rc2 and 2.6.33-rc2-next-20100101
for an ethernet chip at 0xd:1000:0000 on a Au1250 board.

I don't remember seeing oopses while I was figuring out how to get
36-bit I/O working.  arch/x86 and arch/powerpc have been supporting
32-bit processors with 64-bit physical addresses for a long time,
so I would expect the generic resource management code to be reliable.
There are other changes in my tree, but I can't think of anything
which might affect this.  Let me know if I can help further.

Pascal
