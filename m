Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 05 Jul 2005 22:33:16 +0100 (BST)
Received: from wproxy.gmail.com ([IPv6:::ffff:64.233.184.194]:6386 "EHLO
	wproxy.gmail.com") by linux-mips.org with ESMTP id <S8226293AbVGEVc7> convert rfc822-to-8bit;
	Tue, 5 Jul 2005 22:32:59 +0100
Received: by wproxy.gmail.com with SMTP id i25so985807wra
        for <linux-mips@linux-mips.org>; Tue, 05 Jul 2005 14:33:12 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=GlYeJNwcN4Z/SMvm6vapKABwGvlR4tyYiMm/2Mh9e5EtQ+ns8g3r0rgNBHozkH6tlONMWVXnZTlLZWP+i/XmeeXR6b2g35VOOpVW1KARcL1TZ1MaTAipNz/skd22ou4sOpoQYI1yBbLOKPEw7tuZshGe/4igF/1ZpzN4TDqz0tE=
Received: by 10.54.143.4 with SMTP id q4mr4973209wrd;
        Tue, 05 Jul 2005 14:33:11 -0700 (PDT)
Received: by 10.54.41.29 with HTTP; Tue, 5 Jul 2005 14:33:11 -0700 (PDT)
Message-ID: <ecb4efd1050705143364160c24@mail.gmail.com>
Date:	Tue, 5 Jul 2005 17:33:11 -0400
From:	Clem Taylor <clem.taylor@gmail.com>
Reply-To: Clem Taylor <clem.taylor@gmail.com>
To:	linux-mips@linux-mips.org
Subject: can't print a mmaped region in gdb: Cannot access memory at address ...
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Return-Path: <clem.taylor@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8355
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: clem.taylor@gmail.com
Precedence: bulk
X-list: linux-mips

Hi,

I'm trying to debug some code with gdb that mmaps() PCI address space
and mmaps a kernel GFP_DMA buffer. Outside of gdb mmap() interface is
working just fine, but when I try to print the mmaped memory from gdb
I get a 'Cannot access memory at address ...'

Is this a kernel ptrace() issue or a gdb issue? I'm using linux-mips
2.6.11 from 2005.03.18 on an Alchemy Au1550. Google didn't turn up
anything interesting on this subject.

                           Thanks,
                           Clem
