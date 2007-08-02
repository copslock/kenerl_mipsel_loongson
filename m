Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 02 Aug 2007 13:22:13 +0100 (BST)
Received: from web94304.mail.in2.yahoo.com ([203.104.16.214]:27064 "HELO
	web94304.mail.in2.yahoo.com") by ftp.linux-mips.org with SMTP
	id S20022098AbXHBMWL (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 2 Aug 2007 13:22:11 +0100
Received: (qmail 23059 invoked by uid 60001); 2 Aug 2007 12:21:03 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.co.in;
  h=X-YMail-OSG:Received:Date:From:Subject:To:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID;
  b=GV6FwinZS8cXbzrlmE5F4lai+Uz0JXWjtVwHI+bIF3or9pY+6zWFb9cSukQsmk1ICIYCyDPh7UEyWEgQPKKkw9wZFpBaYDLeFukeUIC9HIH9FVCT73X0Dd4svyxZVRHO36vdBnsi6xhpaQU0B7Lh3H4NfzdY0mzlSxYCAu4GOGY=;
X-YMail-OSG: mLBIhP0VM1maCZXQ_HdfZjUVQbgo13_RMCsFChBsuI2z1Pf5VO7kIqGVWiv1MNUerIXGRyrpjD_98NWo6TCGOZCJgOCmKjzNHGxzudfTURqAq3qzFx0a0HwNFSrWxQ--
Received: from [59.92.85.76] by web94304.mail.in2.yahoo.com via HTTP; Thu, 02 Aug 2007 13:21:03 BST
Date:	Thu, 2 Aug 2007 13:21:03 +0100 (BST)
From:	saravanan <sar_van81@yahoo.co.in>
Subject: Re: desktop environments in MIPS
To:	linux-mips@linux-mips.org
In-Reply-To: <004e01c7d34b$deae20b0$10eca8c0@grendel>
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-890436882-1186057263=:23010"
Content-Transfer-Encoding: 8bit
Message-ID: <264155.23010.qm@web94304.mail.in2.yahoo.com>
Return-Path: <sar_van81@yahoo.co.in>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16022
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sar_van81@yahoo.co.in
Precedence: bulk
X-list: linux-mips

--0-890436882-1186057263=:23010
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

hi,
 
 i debugged using GDB and go the following output.:
 
 (gdb) continue
 Continuing.
 Error while mapping shared library sections:
 /mnt/again/opt/QtPalmtop/lib/libqpe.so.1: No such file or directory.
 Error while mapping shared library sections:
 /mnt/again/opt/QtPalmtop/lib/libopiecore2.so.1: No such file or directory.
 Error while mapping shared library sections:
 /mnt/again/opt/QtPalmtop/lib/libopieui2.so.1: No such file or directory.
 Error while mapping shared library sections:
 /mnt/again/opt/QtPalmtop/lib/libopiesecurity2.so.0: No such file or directory.
 Error while mapping shared library sections:
 /usr/local/qt-embedded/lib/libqte.so.2: No such file or directory.
 Error while mapping shared library sections:
 /lib/libstdc++.so.6: No such file or directory.
 Error while mapping shared library sections:
 /lib/libm.so.0: No such file or directory.
 Error while mapping shared library sections:
 /lib/libc.so.0: No such file or directory.
 Error while mapping shared library sections:
 /lib/libcrypt.so.0: No such file or directory.
 Error while mapping shared library sections:
 /lib/libdl.so.0: No such file or directory.
 Error while mapping shared library sections:
 /mnt/again/opt/QtPalmtop/lib/libopiepim2.so.1: No such file or directory.
 Error while mapping shared library sections:
 /lib/ld-uClibc.so.0: No such file or directory.
 Error while reading shared library symbols:
 /mnt/again/opt/QtPalmtop/lib/libqpe.so.1: No such file or directory.
 Error while reading shared library symbols:
 /mnt/again/opt/QtPalmtop/lib/libopiecore2.so.1: No such file or directory.
 Error while reading shared library symbols:
 /mnt/again/opt/QtPalmtop/lib/libopieui2.so.1: No such file or directory.
 Error while reading shared library symbols:
 /mnt/again/opt/QtPalmtop/lib/libopiesecurity2.so.0: No such file or directory.
 Error while reading shared library symbols:
 /usr/local/qt-embedded/lib/libqte.so.2: No such file or directory.
 Error while reading shared library symbols:
 /lib/libstdc++.so.6: No such file or directory.
 Error while reading shared library symbols:
 /lib/libm.so.0: No such file or directory.
 (no debugging symbols found)
 Error while reading shared library symbols:
 /lib/libc.so.0: No such file or directory.
 Error while reading shared library symbols:
 /lib/libcrypt.so.0: No such file or directory.
 Error while reading shared library symbols:
 /lib/libdl.so.0: No such file or directory.
 Error while reading shared library symbols:
 /mnt/again/opt/QtPalmtop/lib/libopiepim2.so.1: No such file or directory.
 Error while reading shared library symbols:
 /lib/ld-uClibc.so.0: No such file or directory.
 
 Program received signal SIGFPE, Arithmetic exception.
 0x2af9a6ec in ?? ()
 (gdb)                                 


 the libraries are present in that directories. but i'm confused as to why is it saying "No such file or directory ".
 . i had also compiled both qt-2.3.10 and OPIE with shared library support only.
 
 can anyone provide me any suggestions or solutions for this ?
 
 thanks in advance,
 
 saravanan.

       
---------------------------------
 Unlimited freedom, unlimited storage. Get it now
--0-890436882-1186057263=:23010
Content-Type: text/html; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

hi,<br> <br> i debugged using GDB and go the following output.:<br> <br> (gdb) continue<br> Continuing.<br> Error while mapping shared library sections:<br> /mnt/again/opt/QtPalmtop/lib/libqpe.so.1: No such file or directory.<br> Error while mapping shared library sections:<br> /mnt/again/opt/QtPalmtop/lib/libopiecore2.so.1: No such file or directory.<br> Error while mapping shared library sections:<br> /mnt/again/opt/QtPalmtop/lib/libopieui2.so.1: No such file or directory.<br> Error while mapping shared library sections:<br> /mnt/again/opt/QtPalmtop/lib/libopiesecurity2.so.0: No such file or directory.<br> Error while mapping shared library sections:<br> /usr/local/qt-embedded/lib/libqte.so.2: No such file or directory.<br> Error while mapping shared library sections:<br> /lib/libstdc++.so.6: No such file or directory.<br> Error while mapping shared library sections:<br> /lib/libm.so.0: No such file or directory.<br> Error while mapping shared library sections:<br>
 /lib/libc.so.0: No such file or directory.<br> Error while mapping shared library sections:<br> /lib/libcrypt.so.0: No such file or directory.<br> Error while mapping shared library sections:<br> /lib/libdl.so.0: No such file or directory.<br> Error while mapping shared library sections:<br> /mnt/again/opt/QtPalmtop/lib/libopiepim2.so.1: No such file or directory.<br> Error while mapping shared library sections:<br> /lib/ld-uClibc.so.0: No such file or directory.<br> Error while reading shared library symbols:<br> /mnt/again/opt/QtPalmtop/lib/libqpe.so.1: No such file or directory.<br> Error while reading shared library symbols:<br> /mnt/again/opt/QtPalmtop/lib/libopiecore2.so.1: No such file or directory.<br> Error while reading shared library symbols:<br> /mnt/again/opt/QtPalmtop/lib/libopieui2.so.1: No such file or directory.<br> Error while reading shared library symbols:<br> /mnt/again/opt/QtPalmtop/lib/libopiesecurity2.so.0: No such file or directory.<br> Error while
 reading shared library symbols:<br> /usr/local/qt-embedded/lib/libqte.so.2: No such file or directory.<br> Error while reading shared library symbols:<br> /lib/libstdc++.so.6: No such file or directory.<br> Error while reading shared library symbols:<br> /lib/libm.so.0: No such file or directory.<br> (no debugging symbols found)<br> Error while reading shared library symbols:<br> /lib/libc.so.0: No such file or directory.<br> Error while reading shared library symbols:<br> /lib/libcrypt.so.0: No such file or directory.<br> Error while reading shared library symbols:<br> /lib/libdl.so.0: No such file or directory.<br> Error while reading shared library symbols:<br> /mnt/again/opt/QtPalmtop/lib/libopiepim2.so.1: No such file or directory.<br> Error while reading shared library symbols:<br> /lib/ld-uClibc.so.0: No such file or directory.<br> <br> Program received signal SIGFPE, Arithmetic exception.<br> 0x2af9a6ec in ?? ()<br>
 (gdb)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <br><br><b><i></i></b><br> the libraries are present in that directories. but i'm confused as to why is it saying "No such file or directory ".<br> . i had also compiled both qt-2.3.10 and OPIE with shared library support only.<br> <br> can anyone provide me any suggestions or solutions for this ?<br> <br> thanks in advance,<br> <br> saravanan.<br><p>&#32;


      <!--2--><hr size=1></hr> Unlimited freedom, unlimited storage. <a href="http://in.rd.yahoo.com/tagline_mail_2/*http://help.yahoo.com/l/in/yahoo/mail/yahoomail/tools/tools-08.html/">Get it now</a>
--0-890436882-1186057263=:23010--
