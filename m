Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 01 Oct 2003 14:36:34 +0100 (BST)
Received: from [IPv6:::ffff:193.232.173.35] ([IPv6:::ffff:193.232.173.35]:11770
	"EHLO tux.NIISI") by linux-mips.org with ESMTP id <S8225396AbTJANgX>;
	Wed, 1 Oct 2003 14:36:23 +0100
Received: from localhost (localhost.localdomain [127.0.0.1])
	by tux.NIISI (8.11.6/8.11.6) with ESMTP id h91DYQd30390;
	Wed, 1 Oct 2003 17:34:26 +0400
Date: Wed, 1 Oct 2003 17:34:26 +0400 (MSD)
From: Tommy Tovbin <tovbin@niisi.msk.ru>
X-X-Sender: tovbin@tux.NIISI
To: Keith Owens <kaos@sgi.com>
cc: linux-mips@linux-mips.org, <raiko@niisi.msk.ru>
Subject: Re: Problem with depmod 
In-Reply-To: <3680.1065008920@ocs3.intra.ocs.com.au>
Message-ID: <Pine.LNX.4.44.0310011729080.30245-100000@tux.NIISI>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <tovbin@niisi.msk.ru>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3346
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tovbin@niisi.msk.ru
Precedence: bulk
X-list: linux-mips

On Wed, 1 Oct 2003, Keith Owens wrote:

> On Wed, 1 Oct 2003 12:18:04 +0400 (MSD), 
> Tommy Tovbin <tovbin@niisi.msk.ru> wrote:
> >
> >Hi, I've recompiled whole RedHat 7.3 on MIPS. Well, when I try to startup 
> >my system I`m getting an error like this:
> >
> >Finding module dependencies:  depmod: cannot read ELF header from 
> >/lib/modules/2.4.18/modules.dep
> 
> Short answer: 'mkdir /lib/modules/2.4.18/kernel' or 'make modules_install'.

> 
> Long answer: You can feed depmod multiple module directories, so depmod
> has to look for directory 'kernel' to work out the top level of each tree.
> modules.dep and the other text files are only ignored at the top level
> of each tree.  You have no 'kernel' directory under /lib/modules/2.4.18
> so depmod does not ignore the text files.
> 
> 
> 

Thanks a lot! 


-- 
With regards, Tommy Tovbin. tovbin at niisi dot msk dot ru.
	Zz
       zZ
    |\ z    _,,,---,,_ /,`.-'`'_ ;-;;,_
   |,4-  ) )-,_..;\ (  `'_'
  '---''(_/--'  `-'\_)
