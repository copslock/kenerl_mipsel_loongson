Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g4UHrVnC025954
	for <linux-mips-outgoing@oss.sgi.com>; Thu, 30 May 2002 10:53:31 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g4UHrVxh025953
	for linux-mips-outgoing; Thu, 30 May 2002 10:53:31 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from pop3.inreach.com (pop3.inreach.com [209.142.2.35])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g4UHrOnC025949
	for <linux-mips@oss.sgi.com>; Thu, 30 May 2002 10:53:25 -0700
Received: (qmail 26522 invoked from network); 30 May 2002 17:54:53 -0000
Received: from unknown (HELO w2k30g) (209.142.39.228)
  by pop3.inreach.com with SMTP; 30 May 2002 17:54:53 -0000
Message-ID: <001601c20803$339e4650$0b01a8c0@w2k30g>
From: "David Christensen" <dpchrist@holgerdanske.com>
To: <linux-mips@oss.sgi.com>
Subject: cross-compiler for MIPS_RedHat7.1_Release-01.00 on Atlas/4Kc using RH7.3-i386 host
Date: Thu, 30 May 2002 10:54:55 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

linux-mips@oss.sgi.com:

I have downloaded ftp://ftp.mips.com/pub/linux/mips/installation/redhat7
.1/01.00/MIPS_RedHat7.1_Release-01.00.iso, burned a CD, and followed the
instructions provided on the CD (/linux/installation/README) to install
Linux (little-endian) on a MIPS Atlas/4Kc board with a SCSI disk.  I
would now like to recompile the kernel to experiment with sound.  I have
posted to this mailing list before and was informed that I need a cross-
compiler, available on oss.sgi.com.  My host is Red Hat Linux-i386 7.3.


Following the instructions provided in Chapter 10 of the Linux/MIPS
HOWTO (http://oss.sgi.com/mips/mips-howto.html), I have located these
files:

    ftp://oss.sgi.com/pub/linux/mips/crossdev/i386-linux/mipsel-linux/
        binutils-mipsel-linux-2.8.1-2.i386.rpm

    ftp://oss.sgi.com/pub/linux/mips/crossdev/i386-linux/mipsel-linux/
        egcs-mipsel-linux-1.1.2-4.i386.rpm

    ftp://oss.sgi.com/pub/linux/mips/glibc/mipsel-linux/
        glibc-2.0.6-5lm.mipsel.rpm


I am unable to find:

    glibc-crypt-2.0.6.tar.gz

    glibc-localedata-2.0.6.tar.gz

    glibc-linuxthreads-2.0.6.tar.gz


Does anybody have any comments or suggestions?


TIA,

David Christensen
dpchrist@holgerdanske.com
