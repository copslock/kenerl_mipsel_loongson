Received:  by oss.sgi.com id <S553964AbQLENtp>;
	Tue, 5 Dec 2000 05:49:45 -0800
Received: from router.isratech.ro ([193.226.114.69]:17930 "EHLO
        router.isratech.ro") by oss.sgi.com with ESMTP id <S553692AbQLENtW>;
	Tue, 5 Dec 2000 05:49:22 -0800
Received: from isratech.ro (calin.cs.tuiasi.ro [193.231.15.163])
	by router.isratech.ro (8.10.2/8.10.2) with ESMTP id eB5DmnV10622
	for <linux-mips@oss.sgi.com>; Tue, 5 Dec 2000 15:48:49 +0200
Message-ID: <3A2D60BB.311D4ECA@isratech.ro>
Date:   Tue, 05 Dec 2000 16:40:11 -0500
From:   Nicu Popovici <octavp@isratech.ro>
X-Mailer: Mozilla 4.74 [en] (X11; U; Linux 2.2.15-2.5.0 i686)
X-Accept-Language: en
MIME-Version: 1.0
To:     linux-mips@oss.sgi.com
Subject: MIPS ext2fs problem.
Content-Type: multipart/mixed;
 boundary="------------B8002E3D75EB3A6D39F5DC8D"
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

This is a multi-part message in MIME format.
--------------B8002E3D75EB3A6D39F5DC8D
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Hello,

I did port the ATLAS support from linux-2.2.12 kernel into linux-2.2.14
. I saw that there is a problem, if I reset the computer in an unusual
way  then at restart it tries to do e2fsck on the hdd. My problem is
that when I run linux 2.2.14 ( for ATLAS , that we ported ) it get
stucked in running e2fsck. Do you have any ideea of what is happening ?

Regards,
Nicu

--------------B8002E3D75EB3A6D39F5DC8D
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

--------------B8002E3D75EB3A6D39F5DC8D--
