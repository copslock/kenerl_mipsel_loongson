Received:  by oss.sgi.com id <S553733AbQKIHGY>;
	Wed, 8 Nov 2000 23:06:24 -0800
Received: from router.isratech.ro ([193.226.114.69]:30738 "EHLO
        router.isratech.ro") by oss.sgi.com with ESMTP id <S553714AbQKIHGG>;
	Wed, 8 Nov 2000 23:06:06 -0800
Received: from isratech.ro (calin.cs.tuiasi.ro [193.231.15.163])
	by router.isratech.ro (8.10.2/8.10.2) with ESMTP id eA974og06131;
	Thu, 9 Nov 2000 09:04:50 +0200
Message-ID: <3A0ABB53.92D39438@isratech.ro>
Date:   Thu, 09 Nov 2000 09:57:23 -0500
From:   Nicu Popovici <octavp@isratech.ro>
X-Mailer: Mozilla 4.74 [en] (X11; U; Linux 2.2.15-2.5.0 i686)
X-Accept-Language: en
MIME-Version: 1.0
To:     Ralf Baechle <ralf@uni-koblenz.de>, linux-mips@oss.sgi.com
Subject: Re: MIPS kernel!
References: <3A09753F.DB2457EE@isratech.ro> <004101c04969$b744b160$0323c0d8@Ulysses> <20001108151048.A13841@bacchus.dhis.org> <3A09D68C.AF1D5AAA@isratech.ro> <20001108205319.A870@bacchus.dhis.org>
Content-Type: multipart/mixed;
 boundary="------------2FF99F9F47D290EEF8EEBEF6"
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

This is a multi-part message in MIME format.
--------------2FF99F9F47D290EEF8EEBEF6
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Ralf Baechle wrote:

> On Wed, Nov 08, 2000 at 05:41:16PM -0500, Nicu Popovici wrote:
>
> > I managed to pass that stage with crosscompiler.
> > I managed to make the following thing
> > make CROSS_COMPILE=mips-linux-
> >
> > and I get the follwing error.
>
> What kernel are you trying to build and where did you download it from?
>
>   Ralf

I try to compile the linux 2.2.13 and   I got that one from ftp.lineo.com.
I also tried to cross compile the linux_2_2 from CVS repository from
oss.sgi.com and I managed but that one does not have support for my
ATLAS borad and I can not run it on my machine.

Regards,
Nicu

--------------2FF99F9F47D290EEF8EEBEF6
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

--------------2FF99F9F47D290EEF8EEBEF6--
