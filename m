Received:  by oss.sgi.com id <S305184AbPLIVCE>;
	Thu, 9 Dec 1999 13:02:04 -0800
Received: from deliverator.sgi.com ([204.94.214.10]:10793 "EHLO
        deliverator.sgi.com") by oss.sgi.com with ESMTP id <S305163AbPLIVBu>;
	Thu, 9 Dec 1999 13:01:50 -0800
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by deliverator.sgi.com (980309.SGI.8.8.8-aspam-6.2/980310.SGI-aspam) via ESMTP id NAA28839; Thu, 9 Dec 1999 13:05:08 -0800 (PST)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id NAA17385
	for linux-list;
	Thu, 9 Dec 1999 13:00:48 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id NAA58460
	for <linux@cthulhu.engr.sgi.com>;
	Thu, 9 Dec 1999 13:00:29 -0800 (PST)
	mail_from (Harald.Koerfgen@home.ivm.de)
Received: from mail.ivm.net (mail.ivm.net [62.204.1.4]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id NAA07625
	for <linux@cthulhu.engr.sgi.com>; Thu, 9 Dec 1999 13:00:17 -0800 (PST)
	mail_from (Harald.Koerfgen@home.ivm.de)
Received: from franz.no.dom (port13.koeln.ivm.de [195.247.239.13])
	by mail.ivm.net (8.8.8/8.8.8) with ESMTP id VAA31924;
	Thu, 9 Dec 1999 21:59:48 +0100
X-To:   linux@cthulhu.engr.sgi.com
Message-ID: <XFMail.991209220002.Harald.Koerfgen@home.ivm.de>
X-Mailer: XFMail 1.3 [p0] on Linux
X-Priority: 3 (Normal)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
In-Reply-To: <19991209164908.A3212@paradigm.rfc822.org>
Date:   Thu, 09 Dec 1999 22:00:02 +0100 (MET)
Reply-To: "Harald Koerfgen" <Harald.Koerfgen@home.ivm.de>
Organization: none
From:   Harald Koerfgen <Harald.Koerfgen@home.ivm.de>
To:     Florian Lohoff <flo@rfc822.org>
Subject: Re: Snapshot
Cc:     linux-mips@vger.rutgers.edu, linux-mips@fnet.fr,
        linux@cthulhu.engr.sgi.com, Ralf Baechle <ralf@oss.sgi.com>
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing


On 09-Dec-99 Florian Lohoff wrote:
> On Mon, Dec 06, 1999 at 09:44:29PM -0200, Ralf Baechle wrote:
>> I've put a snapshot of current CVS kernel sources into
>> oss.sgi.com:/pub/linux/mips/src/kernel/linux-19991206.tar.gz.
> 
> Short resume:
> 
> Doesnt work on Decstation 5000/150 Mips R4000 ...
> Reboots immediatly after end of tftp download ...
> 
> KN04 V2.1k    (PC: 0x8005c044, SP: 0x838a9de0)
> 
> -tftp boot(3), bootp 193.189.250.46:/boot/vmlinux-2.3.21-decR4k.ecoff
> -tftp load 1222624+0+369568
> 
> KN04 V2.1k    (PC: 0x8005c044, SP: 0x80047f78)
> 
> -tftp boot(3), bootp 193.189.250.46:/boot/vmlinux-2.3.21-decR4k.ecoff
> -tftp load 1222624+0+369568
> 
> So long ...

http://oss.sgi.com/www.linux.sgi.com/mips/mips-howto.html

" 6.2 Self compiled kernels crash when booting.

When I build my own kernel, it crashes. On an Indy the crash message looks like
the following; the same problem hits other machines as well but may look
completely different. 

 [...]

This problem is caused by a still unfixed bug in Binutils newer than version
2.7. As a workaround, change the following line in arch/mips/Makefile from: 

   LINKFLAGS       = -static -N
 
to: 

   LINKFLAGS       = -static"

BTW, little endian semaphores for R4xxx and TLB miss handlers for R3xxx are
broken in this snapshot. This is fixed since yesterday and 2.3.21 is happily
running on a /260 and a /133. If you want to play around with recent kernels I
suggest a fresh cvs checkout. Instructions can be found at the above URL.

Hope this helps.

---
Regards,
Harald
