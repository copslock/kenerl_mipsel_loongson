Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f2SJolA14076
	for linux-mips-outgoing; Wed, 28 Mar 2001 11:50:47 -0800
Received: from gw-us4.philips.com (gw-us4.philips.com [63.114.235.90])
	by oss.sgi.com (8.11.3/8.11.3) with ESMTP id f2SJokM14073
	for <linux-mips@oss.sgi.com>; Wed, 28 Mar 2001 11:50:46 -0800
Received: from smtprelay-us1.philips.com (localhost.philips.com [127.0.0.1])
          by gw-us4.philips.com with ESMTP id NAA26312;
          Wed, 28 Mar 2001 13:50:32 -0600 (CST)
          (envelope-from rajesh.palani@philips.com)
From: rajesh.palani@philips.com
Received: from smtprelay-nam2.philips.com(167.81.233.16) by gw-us4.philips.com via mwrap (4.0a)
	id xma026310; Wed, 28 Mar 01 13:50:32 -0600
Received: from AMLMS01.DIAMOND.PHILIPS.COM (amlms01sv1.diamond.philips.com [161.88.79.213]) 
	by smtprelay-us1.philips.com (8.9.3/8.8.5-1.2.2m-19990317) with ESMTP id NAA29269; Wed, 28 Mar 2001 13:50:32 -0600 (CST)
Received: by AMLMS01.DIAMOND.PHILIPS.COM (Soft-Switch LMS 4.0) with snapi
          via AMEC id 0056910011132437; Wed, 28 Mar 2001 13:53:04 -0600
To: <linux-mips@oss.sgi.com>, <linux-mips@fnet.fr>
Subject: Problem with using modutils
Message-ID: <0056910011132437000002L172*@MHS>
Date: Wed, 28 Mar 2001 13:53:04 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; name="MEMO 03/28/01 13:50:07"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by oss.sgi.com id f2SJokM14074
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Hi,

   I am trying to use insmod on a MIPS platform.  I try to install a simple module & get the following errors:

   local symbol gcc2_compiled. with index 10 exceeds local_symtab_size 10
   local symbol __gnu_compiled_c with index 11 exceeds local_symtab_size 10

   I use the following line for generating the object file:
   mipsel-linux-gcc -D__KERNEL__  -DMODULE -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer  -G 0 -mno-abicalls -fno-pic -mcpu=r3000 -mlong-calls -mips1 -pipe  -c

   I am using modutils version 2.3.11.  We have tried both Debian and RedHat sources cross-compiled for MIPS with the following options:
CC=mipsel-linux-gcc CFLAGS="-I../linux/include -DMIPS" RANLIB=mipsel-linux-ranlib AR=mipsel-linux-ar ./configure  --disable-kerneld
--disable-compat-2-0 --enable-insmod-static --target=mipsel-linux
However the problem still remains.

   Any pointers would be greatly appreciated.

   Best regards,

   Rajesh
