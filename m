Received:  by oss.sgi.com id <S553842AbQKCN06>;
	Fri, 3 Nov 2000 05:26:58 -0800
Received: from router.isratech.ro ([193.226.114.69]:23816 "EHLO
        router.isratech.ro") by oss.sgi.com with ESMTP id <S553839AbQKCN0u>;
	Fri, 3 Nov 2000 05:26:50 -0800
Received: from isratech.ro (calin.cs.tuiasi.ro [193.231.15.163])
	by router.isratech.ro (8.10.2/8.10.2) with ESMTP id eA3DQDA12440
	for <linux-mips@oss.sgi.com>; Fri, 3 Nov 2000 15:26:14 +0200
Message-ID: <3A032BBF.4D0613B5@isratech.ro>
Date:   Fri, 03 Nov 2000 16:18:55 -0500
From:   Nicu Popovici <octavp@isratech.ro>
X-Mailer: Mozilla 4.74 [en] (X11; U; Linux 2.2.15-2.5.0 i686)
X-Accept-Language: en
MIME-Version: 1.0
To:     linux-mips@oss.sgi.com
Subject: ATLAS board!
Content-Type: multipart/mixed;
 boundary="------------B20037D365E5BA09C0C07B32"
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

This is a multi-part message in MIME format.
--------------B20037D365E5BA09C0C07B32
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Hello ,

I have an Atlas board with a mips processor. I managed to cross compile
a MIPS kernel on our I686 machines but when I try to load the kernel
image on the mips with the following command ( I do not know other way
and if there is one please let me know ) "load
tftp:/linux/mipseb/vmlinux "  I get the following error

About to load tftp://192.168.200.1/linux/mipseb/di_vmlinux5000
Press Ctrl-C to break
Error : Line too long
Diag  : Line 1, ELF

Can anyone help me ?

Regards,
Nicu

--------------B20037D365E5BA09C0C07B32
Content-Type: text/x-vcard; charset=us-ascii;
 name="octavp.vcf"
Content-Transfer-Encoding: 7bit
Content-Description: Card for Nicu Popovici
Content-Disposition: attachment;
 filename="octavp.vcf"

begin:vcard 
n:POPOVICI;Nicolae Octavian 
tel;cell:+40 93 605020
x-mozilla-html:FALSE
org:SC Silicon Service SRL;Software
adr:;;;;;;
version:2.1
email;internet:octavp@isratech.ro
title:Software engineer
x-mozilla-cpt:;0
fn:Nicolae Octavian POPOVICI
end:vcard

--------------B20037D365E5BA09C0C07B32--
