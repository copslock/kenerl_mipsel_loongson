Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 01 Oct 2003 12:49:05 +0100 (BST)
Received: from mail.ocs.com.au ([IPv6:::ffff:203.34.97.2]:46094 "HELO
	mail.ocs.com.au") by linux-mips.org with SMTP id <S8225371AbTJALsw>;
	Wed, 1 Oct 2003 12:48:52 +0100
Received: (qmail 24194 invoked from network); 1 Oct 2003 11:48:42 -0000
Received: from ocs3.intra.ocs.com.au (192.168.255.3)
  by mail.ocs.com.au with SMTP; 1 Oct 2003 11:48:42 -0000
Received: by ocs3.intra.ocs.com.au (Postfix, from userid 16331)
	id D25D9C02B9; Wed,  1 Oct 2003 21:48:41 +1000 (EST)
Received: from ocs3.intra.ocs.com.au (localhost [127.0.0.1])
	by ocs3.intra.ocs.com.au (Postfix) with ESMTP
	id A66F2140111; Wed,  1 Oct 2003 21:48:41 +1000 (EST)
X-Mailer: exmh version 2.5 01/15/2001 with nmh-1.0.4
From: Keith Owens <kaos@sgi.com>
To: Tommy Tovbin <tovbin@niisi.msk.ru>
Cc: linux-mips@linux-mips.org
Subject: Re: Problem with depmod 
In-reply-to: Your message of "Wed, 01 Oct 2003 12:18:04 +0400."
             <Pine.LNX.4.44.0310011211090.21478-100000@tux.NIISI> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 01 Oct 2003 21:48:40 +1000
Message-ID: <3680.1065008920@ocs3.intra.ocs.com.au>
Return-Path: <kaos@sgi.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3344
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kaos@sgi.com
Precedence: bulk
X-list: linux-mips

On Wed, 1 Oct 2003 12:18:04 +0400 (MSD), 
Tommy Tovbin <tovbin@niisi.msk.ru> wrote:
>
>Hi, I've recompiled whole RedHat 7.3 on MIPS. Well, when I try to startup 
>my system I`m getting an error like this:
>
>Finding module dependencies:  depmod: cannot read ELF header from 
>/lib/modules/2.4.18/modules.dep

Short answer: 'mkdir /lib/modules/2.4.18/kernel' or 'make modules_install'.

Long answer: You can feed depmod multiple module directories, so depmod
has to look for directory 'kernel' to work out the top level of each tree.
modules.dep and the other text files are only ignored at the top level
of each tree.  You have no 'kernel' directory under /lib/modules/2.4.18
so depmod does not ignore the text files.
