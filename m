Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 10 Jun 2003 13:39:27 +0100 (BST)
Received: from mailout02.sul.t-online.com ([IPv6:::ffff:194.25.134.17]:32643
	"EHLO mailout02.sul.t-online.com") by linux-mips.org with ESMTP
	id <S8224827AbTFJMjY>; Tue, 10 Jun 2003 13:39:24 +0100
Received: from fwd01.aul.t-online.de 
	by mailout02.sul.t-online.com with smtp 
	id 19PiP8-0004Vy-09; Tue, 10 Jun 2003 14:39:10 +0200
Received: from denx.de (rw9RGuZfwepaNAtzXq7Hp01P1Wxj+fOl8f3f1IoA5By5jN5uwpc1gJ@[217.235.217.122]) by fmrl01.sul.t-online.com
	with esmtp id 19PiOm-1kvqDI0; Tue, 10 Jun 2003 14:38:48 +0200
Received: from atlas.denx.de (atlas.denx.de [10.0.0.14])
	by denx.de (Postfix) with ESMTP
	id 3948E429AA; Tue, 10 Jun 2003 14:38:46 +0200 (MEST)
Received: by atlas.denx.de (Postfix, from userid 15)
	id CDE2EC5FD7; Tue, 10 Jun 2003 14:38:43 +0200 (MEST)
Received: from atlas.denx.de (localhost [127.0.0.1])
	by atlas.denx.de (Postfix) with ESMTP
	id C9ABFC5492; Tue, 10 Jun 2003 14:38:43 +0200 (MEST)
To: Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>
Cc: Baruch Chaikin <bchaikin@il.marvell.com>,
	linux-mips@linux-mips.org, Rabeeh Khoury <rabeeh@galileo.co.il>
From: Wolfgang Denk <wd@denx.de>
Subject: Re: Building a stand-alone FS on a very limited flash (newbie question) 
X-Mailer: exmh version 1.6.4 10/10/1995
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
Content-transfer-encoding: 8bit
In-reply-to: Your message of "Mon, 09 Jun 2003 18:56:12 +0200."
             <20030609165612.GE32450@rembrandt.csv.ica.uni-stuttgart.de> 
Date: Tue, 10 Jun 2003 14:38:38 +0200
Message-Id: <20030610123843.CDE2EC5FD7@atlas.denx.de>
X-Seen: false
X-ID: rw9RGuZfwepaNAtzXq7Hp01P1Wxj+fOl8f3f1IoA5By5jN5uwpc1gJ@t-dialin.net
Return-Path: <wd@denx.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2579
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wd@denx.de
Precedence: bulk
X-list: linux-mips

In message <20030609165612.GE32450@rembrandt.csv.ica.uni-stuttgart.de> you wrote:
> Baruch Chaikin wrote:
> > Hi all,
> > 
> > I'm using MIPS kernel 2.4.18 with NFS file system mounted on a RedHat 
> > machine. This works fine, but is unsuitable for system deployment. Do 
> > you have hints for me where to start, in order to put the file system on 
> > flash? The platform I'm using is very limited - only one MTD block of 
> > 2.5 MB is available for the file system, out of a 4 MB flash:
> >    0.5 MB is allocated for the firmware code
> >    1.0 MB for the compressed kernel image
> >    2.5 MB for the (compressed?) file system
> > 
> > For example, I've noticed LibC itself is ~5 MB !
> 
> You'll need a smaller libc, dietlibc comes to mind.
> http://www.dietlibc.org/

I don't really understand what all this discussion is about.

2.5 MB is plenty of space for a compressed ramdisk  image  using  the
standard  C  library. The ramdisk image included with our ELDK is 1.3
MB:

	-> ls -l /opt/eldk/mips_4KC/images/ramdisk_image.gz
	-rw-r--r--    1 root     root      1370532 Mar 18 18:09 /opt/eldk/mips_4KC/images/ram

It is based on Busybox, but also includes  standard  login  with  PAM
support, xinetd plus telnet and FTP.


Yes, libc _is_ big. But 5 MB is wrong. Remember that  you  can  strip
the library for the starget system. In our ramdisk image we get:

# ls -l lib | grep -v '^[ld]'
total 2433
-rwxr-xr-x    1 root     root        97308 Jan  1  1970 ld-2.2.5.so
-rwxr-xr-x    1 root     root      1448336 Jan  1  1970 libc-2.2.5.so
-rwxr-xr-x    1 root     root        28544 Jan  1  1970 libcrypt-2.2.5.so
-rwxr-xr-x    1 root     root        14204 Jan  1  1970 libdl-2.2.5.so
-rwxr-xr-x    1 root     root       515740 Jan  1  1970 libm-2.2.5.so
-rwxr-xr-x    1 root     root        99156 Jan  1  1970 libnsl-2.2.5.so
-rwxr-xr-x    1 root     root        62132 Jan  1  1970 libnss_compat-2.2.5.so
-rwxr-xr-x    1 root     root        56376 Jan  1  1970 libnss_files-2.2.5.so
-rwxr-xr-x    1 root     root        40897 Jan  1  1970 libpam.so.0.75
-rwxr-xr-x    1 root     root        13886 Jan  1  1970 libpam_misc.so.0.75
-rwxr-xr-x    1 root     root        75068 Jan  1  1970 libresolv-2.2.5.so
-rwxr-xr-x    1 root     root        12788 Jan  1  1970 libutil-2.2.5.so



So just use the standard libraries - it will fit easily.


Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
Hindsight is an exact science.
