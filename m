Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 10 May 2003 05:18:51 +0100 (BST)
Received: from smtp-out.comcast.net ([IPv6:::ffff:24.153.64.116]:22338 "EHLO
	smtp-out.comcast.net") by linux-mips.org with ESMTP
	id <S8225278AbTEJESs>; Sat, 10 May 2003 05:18:48 +0100
Received: from gentoo.org
 (pcp02545003pcs.waldrf01.md.comcast.net [68.48.92.102])
 by mtaout01.icomcast.net
 (iPlanet Messaging Server 5.2 HotFix 1.12 (built Feb 13 2003))
 with ESMTP id <0HEN00DUTL9XC2@mtaout01.icomcast.net> for
 linux-mips@linux-mips.org; Sat, 10 May 2003 00:17:57 -0400 (EDT)
Date: Sat, 10 May 2003 00:20:49 -0400
From: Kumba <kumba@gentoo.org>
Subject: OpenSSL/Binutils Issues
To: linux-mips@linux-mips.org
Reply-to: linux-mips@linux-mips.org
Message-id: <3EBC7E21.6040109@gentoo.org>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii; format=flowed
Content-transfer-encoding: 7BIT
X-Accept-Language: en-us, en
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.3)
 Gecko/20030312
Return-Path: <kumba@gentoo.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2331
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kumba@gentoo.org
Precedence: bulk
X-list: linux-mips


	Greetings all,

	Having some issues with Binutils and OpenSSL on mips.  Trying to 
bootstrap a machine using binutils-2.14.90.0.1, gcc-3.2.3, & 
glibc-2.3.2, and use -mips3 -mabi=32.  It's working good so far, I 
almost have a complete system built in chroot, only problem is OpenSSL 
doesn't seem to coorperate well with the latest Binutils.

	OpenSSL itself builds, but other programs have issues attempting to 
make use of it.  I've known of the issue since one user said OpenSSH 
doesn't work, but this time, while building wget, wget's configure 
program was unable to use OpenSSL.  The Error messages are below.

	Wget's configure builds this code as "conftest.c":

		#include "confdefs.h"

		int RSA_new();
		int SSL_new();
		main(){return 0;}

	And Compiles it with:

		gcc -o conftest -O3 -mips3 -mabi=32 -mtune=r4400 -pipe
		-fomit-frame-pointer -I/usr/include/openssl 3.c  -lssl
		-lcrypto -ldl

	Which builds fine.  Then the error hits when attempting to execute the 
"conftest" executable:

		./conftest: error while loading shared libraries:
		usr/lib/libcrypto.so.0.9.6: unexpected reloc type 0x68


	Has anyone seen anything like this?  My base mips install on my SGI 
Indigo2 is built using binutils-2.13.90.0.16, which builds everything 
fine, just doesn't cooperate well with -mips3 or higher options.  I'm 
not sure if this is mips-specific, or if I need to bother the OpenSSL 
team about it.

	Ideas?

--Kumba
