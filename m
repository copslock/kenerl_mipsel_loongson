Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 09 Dec 2004 15:26:28 +0000 (GMT)
Received: from pimout3-ext.prodigy.net ([IPv6:::ffff:207.115.63.102]:29573
	"EHLO pimout3-ext.prodigy.net") by linux-mips.org with ESMTP
	id <S8225238AbULIP0X>; Thu, 9 Dec 2004 15:26:23 +0000
Received: from 127.0.0.1 (adsl-68-124-224-225.dsl.snfc21.pacbell.net [68.124.224.225])
	by pimout3-ext.prodigy.net (8.12.10 milter /8.12.10) with ESMTP id iB9FQFmu428704
	for <linux-mips@linux-mips.org>; Thu, 9 Dec 2004 10:26:21 -0500
Received: from  [63.194.214.47] by 127.0.0.1
  (ArGoSoft Mail Server Pro for WinNT/2000/XP, Version 1.8 (1.8.6.7)); Thu, 9 Dec 2004 07:28:11 -0800
Message-ID: <41B86E7D.3000609@embeddedalley.com>
Date: Thu, 09 Dec 2004 07:25:49 -0800
From: Pete Popov <ppopov@embeddedalley.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040913
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-mips@linux-mips.org
Subject: Re: fyi, syscall() somehow broken...
References: <1102602117.28707.49.camel@shswe.inso.tuwien.ac.at>
In-Reply-To: <1102602117.28707.49.camel@shswe.inso.tuwien.ac.at>
X-Enigmail-Version: 0.86.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-ArGoMail-Authenticated: ppopov@embeddedalley.com
Return-Path: <ppopov@embeddedalley.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6618
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ppopov@embeddedalley.com
Precedence: bulk
X-list: linux-mips


> jfyi, something broke w/ the following commit... most notably 'ls -l'
> doesn't work anymore... reverting to yesterdays cvs state fixes the
> issues... ;-)
> 
> Working file: arch/mips/kernel/scall32-o32.S
> head: 1.18
> revision 1.18
> date: 2004/12/08 14:32:30;  author: ths;  state: Exp;  lines: +85 -102
> Fix indirect syscalls for o32, improve syscall performance a bit,
> and general code cleanup.

Someone reported this problem on the Au1x boards. Anyone else seeing 
the problem on other MIPS32 boards?

Pete
