Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g0BKqLs31186
	for linux-mips-outgoing; Fri, 11 Jan 2002 12:52:21 -0800
Received: from mailhost.taec.toshiba.com (mailhost.taec.com [209.243.128.33])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g0BKqEg31181
	for <linux-mips@oss.sgi.com>; Fri, 11 Jan 2002 12:52:14 -0800
Received: from hdqmta.taec.com (hdqmta [209.243.180.59])
	by mailhost.taec.toshiba.com (8.8.8+Sun/8.8.8) with ESMTP id LAA03237
	for <linux-mips@oss.sgi.com>; Fri, 11 Jan 2002 11:52:05 -0800 (PST)
Subject: libtool warning on redhat 7.1 native mipsel compile
To: linux-mips@oss.sgi.com
X-Mailer: Lotus Notes Release 5.0.3  March 21, 2000
Message-ID: <OFC2A7FD37.680D7B25-ON88256B3E.00695F38@taec.com>
From: Adrian.Hulse@taec.toshiba.com
Date: Fri, 11 Jan 2002 11:53:42 -0800
X-MIMETrack: Serialize by Router on HDQMTA/TOSHIBA_TAEC(Release 5.0.8 |June 18, 2001) at
 01/11/2002 11:51:00 AM
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


I have come across many libtool warnings when native compiling redhat 7.1
packages on my mips board.

An example warning is :

*** Warning: This library needs some functionality provided by -lc
*** I have the capability to make that library automatically link in when
*** you link to this library. But I can only do this if you have a
*** shared version of the library, which you do not appear to have.

So I ran file on libc-2.2.4.so, and it gave me the following output :

/lib/libc-2.2.4.so: ELF 32-bit LSB mips-1 shared object, MIPS R3000_LE [bfd
bug], version 1 (SYSV), not stripped

Which I believe is telling me the library is shared. A search on the web
revealed some passed problems with file and libtool, but going by my
libtool's version number I should be OK.
To cut a long story short I traced the problem to a number of script files
which define a string to be :

     ELF [0-9][0-9]*-bit [LM]SB (shared object | dynamic lib)

When this is used as a match against libc-2.2.4.so's output the "mips-1"
part causes a mismatch and libtool complains the library is not a shared
library file. Note, as far as I have checked most of the library files in
the redhat 7.1 distribution include this "mips-1".

As dirty fix I hand hacked all occurences of

     ELF [0-9][0-9]*-bit [LM]SB (shared object | dynamic lib)

and changed them to

     ELF [0-9][0-9]*-bit [LM]SB mips-1 (shared object | dynamic lib)

and sure enough all but one of the libtool warnings went away. The only one
reamining was directed towards linking against libgcc, which is an archive
so I'll let that one go.

Not understanding the workings of everything, my simple analysis of this
problem is that :

"if file did not output "mips-1" the problem would not exist".

Does anyone know why mips-1 is there ? Should it be there because it has
the potential to break a lot of scripts out there.

Does anyone know how to fix either the libraries or the program "file" so
that "mips-1" is not output.

Any help on this will be greatly appreciated

TIA
