Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g4UJUhnC000628
	for <linux-mips-outgoing@oss.sgi.com>; Thu, 30 May 2002 12:30:43 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g4UJUhZX000627
	for linux-mips-outgoing; Thu, 30 May 2002 12:30:43 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from pop3.inreach.com (pop3.inreach.com [209.142.2.35])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g4UJUZnC000623
	for <linux-mips@oss.sgi.com>; Thu, 30 May 2002 12:30:35 -0700
Received: (qmail 3439 invoked from network); 30 May 2002 19:32:04 -0000
Received: from unknown (HELO w2k30g) (209.142.39.228)
  by pop3.inreach.com with SMTP; 30 May 2002 19:32:04 -0000
Message-ID: <002401c20810$c73edd40$0b01a8c0@w2k30g>
From: "David Christensen" <dpchrist@holgerdanske.com>
To: <linux-mips@oss.sgi.com>
References: <001601c20803$339e4650$0b01a8c0@w2k30g>
Subject: Re: cross-compiler for MIPS_RedHat7.1_Release-01.00 on Atlas/4Kc using RH7.3-i386 host
Date: Thu, 30 May 2002 12:32:29 -0700
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

I tried installing the three packages anyway.  binutils and egcs
installed fine.  They contain files and directories with "mips-linux",
etc., in their names, so they don't conflict with my native i386
installation:

    root@r7320g:~# rpm -ihv binutils-mipsel-linux-2.8.1-2.i386.rpm
    Preparing...                ########################################
### [100%]
       1:binutils-mipsel-linux  ########################################
### [100%]

    root@r7320g:~# rpm -ihv egcs-mipsel-linux-1.1.2-4.i386.rpm
    Preparing...                ########################################
### [100%]
       1:egcs-mipsel-linux      ########################################
### [100%]


But glibc has problems:

    root@r7320g:~# rpm -ihv glibc-2.0.6-5lm.mipsel.rpm
    error: failed dependencies:
            glibc < 2.2.5 conflicts with glibc-common-2.2.5-34
            glibc < 2.1.90 conflicts with db1-1.85-8
            glibc < 2.1.90 conflicts with db2-2.4.14-10
            glibc < 2.1.90 conflicts with gnome-libs-1.4.1.2.90-14


Looking at the contents:

    root@r7320g:~# rpm -q -l -p glibc-2.0.6-5lm.mipsel.rpm | head
    /etc/nsswitch.conf
    /etc/rpc
    /lib/ld-2.0.6.so
    /lib/ld.so.1
    /lib/libBrokenLocale-2.0.6.so
    /lib/libBrokenLocale.so.1
    /lib/libc-2.0.6.so
    /lib/libc.so.6
    /lib/libcrypt-2.0.6.so
    /lib/libcrypt.so.1


It contains files that would break my native i386 installation:

    root@r7320g:~# ls -1 /etc/nsswitch.conf /etc/rpc /lib/ld*
    /etc/nsswitch.conf
    /etc/rpc
    /lib/ld-2.2.5.so
    /lib/ld-linux.so.2


Any comments or suggestions?


TIA,

David Christensen
dpchrist@holgerdanske.com
