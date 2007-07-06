Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 06 Jul 2007 10:06:54 +0100 (BST)
Received: from web94306.mail.in2.yahoo.com ([203.104.16.216]:42625 "HELO
	web94306.mail.in2.yahoo.com") by ftp.linux-mips.org with SMTP
	id S20022521AbXGFJGt (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 6 Jul 2007 10:06:49 +0100
Received: (qmail 93775 invoked by uid 60001); 6 Jul 2007 09:05:41 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.co.in;
  h=X-YMail-OSG:Received:Date:From:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID;
  b=To5hA1YWgGRGGlq/dMBBMwSQjuBDkDgWGdxgGMfrF8BILeIu3gf7LBsE+zvq1nSw323FA+3kYQZCke+XOOB3zO0DNnEDfTXUiAS1SG1IL0LvWhF6l/Kl257rvXBnkSptLoFd5tu5kGTNsFP8715fd8EWEPZPZylbUoWrM6swnRY=;
X-YMail-OSG: hFugb.kVM1kAlQzveD3S9D.KT_Tqn9nEpI6rZQmaGOO1osEcsUrJ1ZehbnHWFW1LEw--
Received: from [59.92.93.181] by web94306.mail.in2.yahoo.com via HTTP; Fri, 06 Jul 2007 10:05:41 BST
Date:	Fri, 6 Jul 2007 10:05:41 +0100 (BST)
From:	saravanan <sar_van81@yahoo.co.in>
Subject: error in crosscompiling autoboot for MIPS
To:	linux-mips@linux-mips.org
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-2053808565-1183712741=:93280"
Content-Transfer-Encoding: 8bit
Message-ID: <357682.93280.qm@web94306.mail.in2.yahoo.com>
Return-Path: <sar_van81@yahoo.co.in>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15628
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sar_van81@yahoo.co.in
Precedence: bulk
X-list: linux-mips

--0-2053808565-1183712741=:93280
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

hi,
 
 i download(au1xxx-booter-src-1.0-r000007.tar.gz ) an tried to cross compile for MIPS DBAU1200 board, but was nto succesfull. i used to toolchain created using buildroot. the following is the error message i got:
 
 Building /home/LINUXAU1200/autobootloader/Booter_Common_Au1xxx_00.00.07/applications/booter/obj/DB1200/EL/booter/sd.o
      Building /home/LINUXAU1200/autobootloader/Booter_Common_Au1xxx_00.00.07/applications/booter/obj/DB1200/EL/booter/booter.o
      Building /home/LINUXAU1200/autobootloader/Booter_Common_Au1xxx_00.00.07/applications/booter/obj/DB1200/EL/booter/DB1200_booter.rec
 /home/LINUXAU1200/oldbuildroot/secondbuild/buildroot/build_mipsel/staging_dir/bin/mipsel-linux-uclibc-ld: section .data [000000009fd08778 -> 000000009fd08807] overlaps section .MIPS.stubs [000000009fd08778 -> 000000009fd08787]
 /home/LINUXAU1200/oldbuildroot/secondbuild/buildroot/build_mipsel/staging_dir/bin/mipsel-linux-uclibc-ld: /home/LINUXAU1200/autobootloader/Booter_Common_Au1xxx_00.00.07/applications/booter/obj/DB1200/EL/booter/DB1200_booter.rec.elf: The first section in the PT_DYNAMIC segment is not the .dynamic section
 /home/LINUXAU1200/oldbuildroot/secondbuild/buildroot/build_mipsel/staging_dir/bin/mipsel-linux-uclibc-ld: final link failed: Bad value
 make[3]: *** [/home/LINUXAU1200/autobootloader/Booter_Common_Au1xxx_00.00.07/applications/booter/obj/DB1200/EL/booter/DB1200_booter.rec] Error 1
 rm /home/LINUXAU1200/autobootloader/Booter_Common_Au1xxx_00.00.07/applications/booter/obj/DB1200/EL/booter/fat.o /home/LINUXAU1200/autobootloader/Booter_Common_Au1xxx_00.00.07/applications/booter/obj/DB1200/EL/booter/flash.o /home/LINUXAU1200/autobootloader/Booter_Common_Au1xxx_00.00.07/applications/booter/obj/DB1200/EL/booter/booter.o /home/LINUXAU1200/autobootloader/Booter_Common_Au1xxx_00.00.07/applications/booter/obj/DB1200/EL/booter/partition.o /home/LINUXAU1200/autobootloader/Booter_Common_Au1xxx_00.00.07/applications/booter/obj/DB1200/EL/booter/filesystem.o /home/LINUXAU1200/autobootloader/Booter_Common_Au1xxx_00.00.07/applications/booter/obj/DB1200/EL/booter/sd.o /home/LINUXAU1200/autobootloader/Booter_Common_Au1xxx_00.00.07/applications/booter/obj/DB1200/EL/booter/srec.o /home/LINUXAU1200/autobootloader/Booter_Common_Au1xxx_00.00.07/applications/booter/obj/DB1200/EL/booter/bin.o
 /home/LINUXAU1200/autobootloader/Booter_Common_Au1xxx_00.00.07/applications/booter/obj/DB1200/EL/booter/elf.o /home/LINUXAU1200/autobootloader/Booter_Common_Au1xxx_00.00.07/applications/booter/obj/DB1200/EL/booter/util.o /home/LINUXAU1200/autobootloader/Booter_Common_Au1xxx_00.00.07/applications/booter/obj/DB1200/EL/booter/functions.o
 make[3]: Leaving directory `/home/LINUXAU1200/autobootloader/Booter_Common_Au1xxx_00.00.07/applications/booter'
 make[2]: *** [all] Error 2
 make[2]: Leaving directory `/home/LINUXAU1200/autobootloader/Booter_Common_Au1xxx_00.00.07/applications'
 make[1]: *** [apps] Error 2
 make[1]: Leaving directory `/home/LINUXAU1200/autobootloader/Booter_Common_Au1xxx_00.00.07'
 make: *** [all] Error 2
 linux:/home/LINUXAU1200/autobootloader/Booter_Common_Au1xxx_00.00.07 # ..
 linux:/home/LINUXAU1200/autobootloader #
 
 
 i think there is memory range overlapping between the two sections.
 
 can anyone suggest me any solution or suggestion for this ?
 
 thanks in advance,
 
 saravanan.
 
 Send free SMS to your Friends on Mobile from your Yahoo! Messenger. Download Now! http://messenger.yahoo.com/download.php
--0-2053808565-1183712741=:93280
Content-Type: text/html; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

hi,<br> <br> i download(au1xxx-booter-src-1.0-r000007.tar.gz ) an tried to cross compile for MIPS DBAU1200 board, but was nto succesfull. i used to toolchain created using buildroot. the following is the error message i got:<br> <br> Building /home/LINUXAU1200/autobootloader/Booter_Common_Au1xxx_00.00.07/applications/booter/obj/DB1200/EL/booter/sd.o<br> &nbsp;&nbsp;&nbsp;&nbsp; Building /home/LINUXAU1200/autobootloader/Booter_Common_Au1xxx_00.00.07/applications/booter/obj/DB1200/EL/booter/booter.o<br> &nbsp;&nbsp;&nbsp;&nbsp; Building /home/LINUXAU1200/autobootloader/Booter_Common_Au1xxx_00.00.07/applications/booter/obj/DB1200/EL/booter/DB1200_booter.rec<br> /home/LINUXAU1200/oldbuildroot/secondbuild/buildroot/build_mipsel/staging_dir/bin/mipsel-linux-uclibc-ld: section .data [000000009fd08778 -&gt; 000000009fd08807] overlaps section .MIPS.stubs [000000009fd08778 -&gt; 000000009fd08787]<br>
 /home/LINUXAU1200/oldbuildroot/secondbuild/buildroot/build_mipsel/staging_dir/bin/mipsel-linux-uclibc-ld: /home/LINUXAU1200/autobootloader/Booter_Common_Au1xxx_00.00.07/applications/booter/obj/DB1200/EL/booter/DB1200_booter.rec.elf: The first section in the PT_DYNAMIC segment is not the .dynamic section<br> /home/LINUXAU1200/oldbuildroot/secondbuild/buildroot/build_mipsel/staging_dir/bin/mipsel-linux-uclibc-ld: final link failed: Bad value<br> make[3]: *** [/home/LINUXAU1200/autobootloader/Booter_Common_Au1xxx_00.00.07/applications/booter/obj/DB1200/EL/booter/DB1200_booter.rec] Error 1<br> rm /home/LINUXAU1200/autobootloader/Booter_Common_Au1xxx_00.00.07/applications/booter/obj/DB1200/EL/booter/fat.o /home/LINUXAU1200/autobootloader/Booter_Common_Au1xxx_00.00.07/applications/booter/obj/DB1200/EL/booter/flash.o /home/LINUXAU1200/autobootloader/Booter_Common_Au1xxx_00.00.07/applications/booter/obj/DB1200/EL/booter/booter.o
 /home/LINUXAU1200/autobootloader/Booter_Common_Au1xxx_00.00.07/applications/booter/obj/DB1200/EL/booter/partition.o /home/LINUXAU1200/autobootloader/Booter_Common_Au1xxx_00.00.07/applications/booter/obj/DB1200/EL/booter/filesystem.o /home/LINUXAU1200/autobootloader/Booter_Common_Au1xxx_00.00.07/applications/booter/obj/DB1200/EL/booter/sd.o /home/LINUXAU1200/autobootloader/Booter_Common_Au1xxx_00.00.07/applications/booter/obj/DB1200/EL/booter/srec.o /home/LINUXAU1200/autobootloader/Booter_Common_Au1xxx_00.00.07/applications/booter/obj/DB1200/EL/booter/bin.o /home/LINUXAU1200/autobootloader/Booter_Common_Au1xxx_00.00.07/applications/booter/obj/DB1200/EL/booter/elf.o /home/LINUXAU1200/autobootloader/Booter_Common_Au1xxx_00.00.07/applications/booter/obj/DB1200/EL/booter/util.o /home/LINUXAU1200/autobootloader/Booter_Common_Au1xxx_00.00.07/applications/booter/obj/DB1200/EL/booter/functions.o<br> make[3]: Leaving directory
 `/home/LINUXAU1200/autobootloader/Booter_Common_Au1xxx_00.00.07/applications/booter'<br> make[2]: *** [all] Error 2<br> make[2]: Leaving directory `/home/LINUXAU1200/autobootloader/Booter_Common_Au1xxx_00.00.07/applications'<br> make[1]: *** [apps] Error 2<br> make[1]: Leaving directory `/home/LINUXAU1200/autobootloader/Booter_Common_Au1xxx_00.00.07'<br> make: *** [all] Error 2<br> linux:/home/LINUXAU1200/autobootloader/Booter_Common_Au1xxx_00.00.07 # ..<br> linux:/home/LINUXAU1200/autobootloader #<br> <br> <br> i think there is memory range overlapping between the two sections.<br> <br> can anyone suggest me any solution or suggestion for this ?<br> <br> thanks in advance,<br> <br> saravanan.<br> <p>&#32;Send free SMS to your Friends on Mobile from your Yahoo! Messenger. Download Now! http://messenger.yahoo.com/download.php
--0-2053808565-1183712741=:93280--
