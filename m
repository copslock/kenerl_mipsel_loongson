Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 05 Jul 2010 07:27:39 +0200 (CEST)
Received: from na3sys009aog102.obsmtp.com ([74.125.149.69]:50975 "HELO
        na3sys009aog102.obsmtp.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with SMTP id S1491115Ab0GEF1g (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 5 Jul 2010 07:27:36 +0200
Received: from source ([209.85.214.178]) by na3sys009aob102.postini.com ([74.125.148.12]) with SMTP
        ID DSNKTDFtRXhlHCXfFhNCq6uksoDF25uci35M@postini.com; Sun, 04 Jul 2010 22:27:35 PDT
Received: by iwn9 with SMTP id 9so1138661iwn.9
        for <linux-mips@linux-mips.org>; Sun, 04 Jul 2010 22:27:33 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.231.14.201 with SMTP id h9mr2942851iba.129.1278307652856; Sun, 
        04 Jul 2010 22:27:32 -0700 (PDT)
Received: by 10.231.173.21 with HTTP; Sun, 4 Jul 2010 22:27:32 -0700 (PDT)
Date:   Mon, 5 Jul 2010 10:27:32 +0500
Message-ID: <AANLkTilZw7Zc9kfZzd-Xle7W3lHN9MSRaXQjv3SQNafj@mail.gmail.com>
Subject: Issue with RLIMIT Identifiers
From:   adnan iqbal <adnan.iqbal@seecs.edu.pk>
To:     linux-mips@linux-mips.org
Content-Type: multipart/alternative; boundary=00221534d4d38fedae048a9d315e
Return-Path: <adnan.iqbal@seecs.edu.pk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 27307
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: adnan.iqbal@seecs.edu.pk
Precedence: bulk
X-list: linux-mips

--00221534d4d38fedae048a9d315e
Content-Type: text/plain; charset=ISO-8859-1

>
> Dear all,


I am using debian/octeon box.

In the file /usr/local/asm-generic.h , RLIMIT_NOFILE   is defined to be
equal to 7.

In
/usr/local/Cavium_Networks/OCTEON-SDK/tools/usr/include/asm/resource.h:#define
RLIMIT_NOFILE         5

In
/usr/local/Cavium_Networks/OCTEON-SDK/tools/usr/include/asm-generic/resource.h:#
define RLIMIT_NOFILE                7
i have confirmed through C program that the operating system is using
RLIMIT_NOFILE=5. I need help to figure out which header files are actually
being used by the kernel to get exact Resource Identifier.

Regards
Adnan

--00221534d4d38fedae048a9d315e
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div class=3D"gmail_quote">
<blockquote class=3D"gmail_quote" style=3D"PADDING-LEFT: 1ex; MARGIN: 0px 0=
px 0px 0.8ex; BORDER-LEFT: #ccc 1px solid">Dear all,</blockquote>
<div>=A0</div>
<div>I am using debian/octeon box. </div>
<div>=A0</div>
<div>In the file /usr/local/asm-generic.h ,=A0RLIMIT_NOFILE=A0=A0=A0is defi=
ned to be equal to 7. </div>
<div>=A0</div>
<div>In /usr/local/Cavium_Networks/OCTEON-SDK/tools/usr/include/asm/resourc=
e.h:#define RLIMIT_NOFILE=A0=A0=A0=A0=A0=A0=A0=A0 5 </div>
<div>=A0</div>
<div>In /usr/local/Cavium_Networks/OCTEON-SDK/tools/usr/include/asm-generic=
/resource.h:# define RLIMIT_NOFILE=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0 7<br></div>
<div>i have confirmed through C program that the operating system is using =
RLIMIT_NOFILE=3D5. I need help to figure out which header files are actuall=
y being used by the kernel to get exact Resource Identifier.</div>
<div>=A0</div>
<div>Regards</div>
<div>Adnan<br></div></div>

--00221534d4d38fedae048a9d315e--
