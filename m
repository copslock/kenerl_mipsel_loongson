Received:  by oss.sgi.com id <S305168AbQCORMm>;
	Wed, 15 Mar 2000 09:12:42 -0800
Received: from deliverator.sgi.com ([204.94.214.10]:40056 "EHLO
        deliverator.sgi.com") by oss.sgi.com with ESMTP id <S305156AbQCORMa>;
	Wed, 15 Mar 2000 09:12:30 -0800
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by deliverator.sgi.com (980309.SGI.8.8.8-aspam-6.2/980310.SGI-aspam) via ESMTP id JAA13628; Wed, 15 Mar 2000 09:07:52 -0800 (PST)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id JAA70050
	for linux-list;
	Wed, 15 Mar 2000 09:01:32 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id JAA06751
	for <linux@engr.sgi.com>;
	Wed, 15 Mar 2000 09:01:26 -0800 (PST)
	mail_from (gnava@sirio.tecmor.mx)
Received: from sirio.tecmor.mx (sirio.tecmor.mx [200.33.171.1]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id JAA02626
	for <linux@engr.sgi.com>; Wed, 15 Mar 2000 09:01:20 -0800 (PST)
	mail_from (gnava@sirio.tecmor.mx)
Received: from localhost (gnava@localhost)
	by sirio.tecmor.mx (8.9.3/8.9.3) with ESMTP id LAA15539
	for <linux@engr.sgi.com>; Wed, 15 Mar 2000 11:05:12 -0600
Date:   Wed, 15 Mar 2000 11:05:12 -0600 (CST)
From:   Gabriel Nava Vazquez <gnava@sirio.tecmor.mx>
To:     linux@cthulhu.engr.sgi.com
Subject: instalation crashes 
Message-ID: <Pine.LNX.4.10.10003151104410.15537-100000@sirio.tecmor.mx>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing

Hello 

I'm installing sgi-linux on an Indy (R4600), in a Seagate disk.

I changed the id for sda1 from EFS to Linux Native, i also tryied
creating a smaller partition in sda1 and 'w', then i pressed 'done' 
and the instalation program crashes with the next error:

Oops: 0000

$0 : 00000000 1000fc00 00001000 ffffffe0
$4 : 00000020 00000000 1000fc00 1000fc00
$8 : 00000010 881095c0 00000001 00000001
$12: 00000001 fffffffc 1000fc01 89e31864
$16: 00000000 00001000 a9f5e000 89f5c800
$20: 89f5fe70 bfbc0003 00000000 bfb90000
$24: 00000001 2abe2f30
$28: 89e88000 89e89b98 89f5fe70 880fa8c4
epc	: 88020f80
Status	: 1000fc02
Cause   : 00000008
install exited abnormally -- received signal 11
sendig termination signals.. done
sending kill signals.. done
unmounting filesistems.. done
/proc
unmount failed /tmp
you may safely reboot your system
--------
 
in Alt-f2, the message is the same, but preceded by:
<1> Unable to handle the kernel paging request at virtual adress 00000000,
epc==88020f80, ra== 880fa8c4

What can i do?

Thanks for help

Gabriel Nava Vazquez
Instituto Tecnologico de Morelia, Mexico
