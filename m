Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 11 Sep 2002 21:06:09 +0200 (CEST)
Received: from real.realitydiluted.com ([208.242.241.164]:60124 "EHLO
	real.realitydiluted.com") by linux-mips.org with ESMTP
	id <S1122960AbSIKTGI>; Wed, 11 Sep 2002 21:06:08 +0200
Received: from localhost.localdomain ([127.0.0.1] helo=realitydiluted.com)
	by real.realitydiluted.com with esmtp (Exim 3.22 #1 (Red Hat Linux))
	id 17p87y-0007kV-00; Wed, 11 Sep 2002 09:05:58 -0500
Message-ID: <3D7F9414.2020305@realitydiluted.com>
Date: Wed, 11 Sep 2002 14:05:56 -0500
From: "Steven J. Hill" <sjhill@realitydiluted.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020615 Debian/1.0.0-3
X-Accept-Language: en
MIME-Version: 1.0
To: uclibc.@uclibc.org,  linux-mips@linux-mips.org
Subject: New uClibc-0.9.15 cross toolchains for MIPS...
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sjhill@realitydiluted.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 158
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sjhill@realitydiluted.com
Precedence: bulk
X-list: linux-mips

Greetings.

I am pleased to announce new cross toolchains for uClibc
based MIPS big and little endian compilers. These RPMS
are for installation on a x86 host to produce uClibc
binaries for MIPS targets. They can be downloaded from
the following URL:

    ftp://ftp.realitydiluted.com/Linux/uclibc/

The RPMS are based off of the uClibc toolchain builder
found at:

    http://www.us.kernel.org/pub/linux/libs/uclibc/toolchain/

This toolchain uses the following tool versions:

    binutils-2.13
    gcc-3.2
    uClibc-0.9.15 w/patches to uClibc CVS as of yesterday

These toolchains can also be used to compile Linux MIPS
kernels which I have been doing with no problems at all.
Thanks and enjoy!

-Steve
