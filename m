Received:  by oss.sgi.com id <S305179AbQCVStg>;
	Wed, 22 Mar 2000 10:49:36 -0800
Received: from deliverator.sgi.com ([204.94.214.10]:15740 "EHLO
        deliverator.sgi.com") by oss.sgi.com with ESMTP id <S305174AbQCVStT>;
	Wed, 22 Mar 2000 10:49:19 -0800
Received: from cthulhu.engr.sgi.com (gate3-relay.engr.sgi.com [130.62.1.234]) by deliverator.sgi.com (980309.SGI.8.8.8-aspam-6.2/980310.SGI-aspam) via ESMTP id KAA15996; Wed, 22 Mar 2000 10:44:40 -0800 (PST)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id KAA66587
	for linux-list;
	Wed, 22 Mar 2000 10:29:46 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id KAA32151
	for <linux@cthulhu.engr.sgi.com>;
	Wed, 22 Mar 2000 10:29:34 -0800 (PST)
	mail_from (gnava@sirio.tecmor.mx)
Received: from sirio.tecmor.mx (sirio.tecmor.mx [200.33.171.1]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id KAA03599
	for <linux@cthulhu.engr.sgi.com>; Wed, 22 Mar 2000 10:28:38 -0800 (PST)
	mail_from (gnava@sirio.tecmor.mx)
Received: from localhost (gnava@localhost)
	by sirio.tecmor.mx (8.9.3/8.9.3) with ESMTP id MAA01258;
	Wed, 22 Mar 2000 12:32:11 -0600
Date:   Wed, 22 Mar 2000 12:32:11 -0600 (CST)
From:   Gabriel Nava Vazquez <gnava@sirio.tecmor.mx>
To:     Enrico Canardi <knix_erik@hotmail.com>
cc:     linux@cthulhu.engr.sgi.com
Subject: Re: Indy probs
In-Reply-To: <20000321172223.72976.qmail@hotmail.com>
Message-ID: <Pine.LNX.4.10.10003221230130.1248-100000@sirio.tecmor.mx>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing

Hello

i had a similar problem, i just disconnected one disk, (the one who
caused the crash) and i could install hard hat.

But i have now other problem, i boot via bootp():/vmlinux root=/dev/sda1
and the system hangs with the message:

can't open an initial consolo

what can i do?

thanks

Gabriel Nava
Instituto Tecnologico de Morelia

On Tue, 21 Mar 2000, Enrico Canardi wrote:

> Hi all
> 
> I managed to get the first install screen un my Indy R4600.
> (hardhat 5.1).
> When it asks me which disk is going to be used (i have two disks, the second 
> one empty and partitioned as described in the README file) and I answer 
> /dev/sdc it crashes (also if i select /dev/sda !).
> 
> Whi???????
> 
> Thanks Enrico
> ______________________________________________________
> Get Your Private, Free Email at http://www.hotmail.com
> 
