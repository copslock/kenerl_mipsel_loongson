Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 09 Sep 2004 21:57:14 +0100 (BST)
Received: from 64-60-250-34.cust.telepacific.net ([IPv6:::ffff:64.60.250.34]:25920
	"EHLO panta-1.pantasys.com") by linux-mips.org with ESMTP
	id <S8225203AbUIIU5J>; Thu, 9 Sep 2004 21:57:09 +0100
Received: from [10.1.40.165] ([10.1.40.1]) by panta-1.pantasys.com with Microsoft SMTPSVC(5.0.2195.6713);
	 Thu, 9 Sep 2004 13:50:15 -0700
Message-ID: <4140C398.5070307@pantasys.com>
Date: Thu, 09 Sep 2004 13:56:56 -0700
From: Peter Buckingham <peter@pantasys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040820 Debian/1.7.2-4
X-Accept-Language: en
MIME-Version: 1.0
To: Peter Buckingham <peter@pantasys.com>
CC: Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: Re: [PATCH 2.6] make the bcm1250 work
References: <4140C205.7020405@pantasys.com>
In-Reply-To: <4140C205.7020405@pantasys.com>
Content-Type: multipart/mixed;
 boundary="------------010800030904020308090704"
X-OriginalArrivalTime: 09 Sep 2004 20:50:15.0578 (UTC) FILETIME=[9BCFCFA0:01C496AE]
Return-Path: <peter@pantasys.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5811
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: peter@pantasys.com
Precedence: bulk
X-list: linux-mips

This is a multi-part message in MIME format.
--------------010800030904020308090704
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hi Ralf,

the second patch has some cruft in it. could you apply the
following instead.

thanks,

peter

Signed-off-by: Peter Buckingham <peter@pantasys.com>


--------------010800030904020308090704
Content-Type: text/plain;
 name="p1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="p1"

Index: arch/mips/pci/pci-sb1250.c
===================================================================
RCS file: /home/cvs/linux/arch/mips/pci/pci-sb1250.c,v
retrieving revision 1.9
diff -p -u -r1.9 pci-sb1250.c
--- arch/mips/pci/pci-sb1250.c	26 Aug 2004 20:18:00 -0000	1.9
+++ arch/mips/pci/pci-sb1250.c	9 Sep 2004 20:55:20 -0000
@@ -37,6 +37,7 @@
 #include <linux/init.h>
 #include <linux/mm.h>
 #include <linux/console.h>
+#include <linux/tty.h>
 
 #include <asm/io.h>
 

--------------010800030904020308090704--
