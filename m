Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 18 Apr 2011 20:27:57 +0200 (CEST)
Received: from mail-wy0-f177.google.com ([74.125.82.177]:47802 "EHLO
        mail-wy0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1493116Ab1DRS1v (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 18 Apr 2011 20:27:51 +0200
Received: by wyb28 with SMTP id 28so5306004wyb.36
        for <linux-mips@linux-mips.org>; Mon, 18 Apr 2011 11:27:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=8hLX4ZiK/XW7ZNxY60elYzUZ4UbxZzBRpS1POsBw0Zs=;
        b=N3S23RLFClf/yVDkiiWkPwXtJqMxcsIIydbgwTZTuu2REaj0aQ02qA8lCj/P0WzRaM
         aCuT1ggg+d1cygF/2MqDE9Y/tLiHOJVP+G3R6bSZg+4qayUnkSnBFE38nQjRScD5P44X
         6uceyhzy8qXeWZKw8zpeAWNUNGJPmk8aXuwVY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=dPyl8SWdl32WGK5ttVU9phmS0zjIFGhuxCe1nUqYCWS4VN1Mifz76LFOlHu3ZrSHZp
         Wb+Z0+H5+stWzsMbPglrBjROOBR4bbsn5v3lZfh6ntZL/mm8OpzM4Mc6AEj8LqRQGZi/
         PeaMIIaDPxzYtHd/EAHPeGsAjPC/Zu2rcYO74=
MIME-Version: 1.0
Received: by 10.216.144.134 with SMTP id n6mr5380392wej.27.1303151266327; Mon,
 18 Apr 2011 11:27:46 -0700 (PDT)
Received: by 10.216.237.218 with HTTP; Mon, 18 Apr 2011 11:27:46 -0700 (PDT)
In-Reply-To: <AEA634773855ED4CAD999FBB1A66D07601988EC8@CORPEXCH1.na.ads.idt.com>
References: <AEA634773855ED4CAD999FBB1A66D07601988DFA@CORPEXCH1.na.ads.idt.com>
        <BANLkTi=QLZe68o2=1Vk+4QTu-ru1T6H=vQ@mail.gmail.com>
        <AEA634773855ED4CAD999FBB1A66D07601988EC8@CORPEXCH1.na.ads.idt.com>
Date:   Mon, 18 Apr 2011 20:27:46 +0200
Message-ID: <BANLkTims95JZfPfAM5Qk9+pVrqsoQ2J3SA@mail.gmail.com>
Subject: Re: How can I access h/w registers in user space?
From:   Manuel Lauss <manuel.lauss@googlemail.com>
To:     "Ardelean, Andrei" <Andrei.Ardelean@idt.com>
Cc:     linux-mips@linux-mips.org
Content-Type: text/plain; charset=ISO-8859-1
Return-Path: <manuel.lauss@googlemail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29781
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: manuel.lauss@googlemail.com
Precedence: bulk
X-list: linux-mips

On Mon, Apr 18, 2011 at 8:14 PM, Ardelean, Andrei
<Andrei.Ardelean@idt.com> wrote:
> Mmap() worked fine for one io memory region, but when I tried to open
> twice for different io memory regions with different base addresses and
> sizes it didn't work. It returned the same memory pointer value in both
> cases. In my design the h/w guys put those h/w registers in two distinct
> memory mapped regions with a large reserved area in between. Is it any
> solution for this case?

This works for me.  Unlike QNX, you can only map multiples of the page size
and the base must also be aligned on a page boundary:

#define MMIO    0x11900000    /* SYS_xxx */
#define MMIO2   0x14000000   /* MEM_xxx */

memfd = open("/dev/mem", O_RDWR);
pgsize = sysconf(_SC_PAGESIZE);
mmio = (unsigned long)mmap(0, pgsize, PROT_READ | PROT_WRITE,
                                        MAP_SHARED, memfd, MMIO);
mmio2 = (unsigned long)mmap(0, 2 * pgsize, PROT_READ | PROT_WRITE,
                                        MAP_SHARED, memfd, MMIO2);

Manuel
