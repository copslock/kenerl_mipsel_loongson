Received:  by oss.sgi.com id <S553720AbQJRMbf>;
	Wed, 18 Oct 2000 05:31:35 -0700
Received: from router.isratech.ro ([193.226.114.69]:22276 "EHLO
        router.isratech.ro") by oss.sgi.com with ESMTP id <S553712AbQJRMbO>;
	Wed, 18 Oct 2000 05:31:14 -0700
Received: from isratech.ro (calin.cs.tuiasi.ro [193.231.15.163])
	by router.isratech.ro (8.10.2/8.10.2) with ESMTP id e9ICUiZ18340
	for <linux-mips@oss.sgi.com>; Wed, 18 Oct 2000 10:30:46 -0200
Message-ID: <39ED962F.3230FDEE@isratech.ro>
Date:   Wed, 18 Oct 2000 15:23:11 +0300
From:   Nicu Popovici <octavp@isratech.ro>
X-Mailer: Mozilla 4.74 [en] (X11; U; Linux 2.2.16 i686)
X-Accept-Language: en
MIME-Version: 1.0
To:     linux-mips@oss.sgi.com
Subject: CrossGcc Kernel fail.
Content-Type: multipart/mixed;
 boundary="------------211CCA9BDFF832D2DFF474DC"
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

This is a multi-part message in MIME format.
--------------211CCA9BDFF832D2DFF474DC
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Hello once again,

In all the documentation found on the web it says that after building
binutils and gcc I should be able to compile the MIPS Kernel sources. Or
my problem is that I can not compile the sources. Any ideas why ?
The compilation gives me the following error:

cc1: warnings being treated as errors.

I used binutils 2.8.1 with the patch and egcs 1.0.3a along with add-ons
( crypt and linuxthreads ).

Another question : in all the docs that I found says apply patch
binutils-<version>-mips.patch, gcc-<version>-mips.patch and the same for
glibc. I did a search for binutils-2.8.1-mips.patch and I did not find
anything. Can anyone tell me where to find those patches ?

Regards,
Nicu




--------------211CCA9BDFF832D2DFF474DC
Content-Type: text/x-vcard; charset=us-ascii;
 name="octavp.vcf"
Content-Transfer-Encoding: 7bit
Content-Description: Card for Nicu Popovici
Content-Disposition: attachment;
 filename="octavp.vcf"

begin:vcard 
n:Popovici;Nicu
tel;cell:+40 93 605020
x-mozilla-html:FALSE
org:SC Silicon Service SRL;software 
adr:;;;IASI;IASI;6600;ROMANIA
version:2.1
email;internet:octavp@isratech.ro
title:software engineer
x-mozilla-cpt:;0
fn:Nicu Popovici
end:vcard

--------------211CCA9BDFF832D2DFF474DC--
