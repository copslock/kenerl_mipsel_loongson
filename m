Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 01 Oct 2003 09:20:07 +0100 (BST)
Received: from [IPv6:::ffff:193.232.173.35] ([IPv6:::ffff:193.232.173.35]:56823
	"EHLO tux.NIISI") by linux-mips.org with ESMTP id <S8225200AbTJAIUA>;
	Wed, 1 Oct 2003 09:20:00 +0100
Received: from localhost (localhost.localdomain [127.0.0.1])
	by tux.NIISI (8.11.6/8.11.6) with ESMTP id h918I4d21482
	for <linux-mips@linux-mips.org>; Wed, 1 Oct 2003 12:18:06 +0400
Date: Wed, 1 Oct 2003 12:18:04 +0400 (MSD)
From: Tommy Tovbin <tovbin@niisi.msk.ru>
X-X-Sender: tovbin@tux.NIISI
To: linux-mips@linux-mips.org
Subject: Problem with depmod
Message-ID: <Pine.LNX.4.44.0310011211090.21478-100000@tux.NIISI>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <tovbin@niisi.msk.ru>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3342
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tovbin@niisi.msk.ru
Precedence: bulk
X-list: linux-mips


Hi, I've recompiled whole RedHat 7.3 on MIPS. Well, when I try to startup 
my system I`m getting an error like this:

Finding module dependencies:  depmod: cannot read ELF header from 
/lib/modules/2.4.18/modules.dep
depmod: cannot read ELF header from 
/lib/modules/2.4.18/modules.generic_string
depmod: /lib/modules/2.4.18/modules.ieee1394map is not an ELF file
depmod: /lib/modules/2.4.18/modules.isapnpmap is not an ELF file
depmod: cannot read ELF header from /lib/modules/2.4.18/modules.parportmap
depmod: /lib/modules/2.4.18/modules.pcimap is not an ELF file
depmod: cannot read ELF header from /lib/modules/2.4.18/modules.pnpbiosmap
depmod: /lib/modules/2.4.18/modules.usbmap is not an ELF file
[FAILED]

Can somebody help me?

PS: I've got the NULL modules.dep, because I havn't any modules, but I 
need kernel with LKM support.

Thx.

-- 
With regards, Tommy Tovbin. tovbin at niisi dot msk dot ru.
	Zz
       zZ
    |\ z    _,,,---,,_ /,`.-'`'_ ;-;;,_
   |,4-  ) )-,_..;\ (  `'_'
  '---''(_/--'  `-'\_)
