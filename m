Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.5/8.12.5) with ESMTP id g6B1QHRw030096
	for <linux-mips-outgoing@oss.sgi.com>; Wed, 10 Jul 2002 18:26:17 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.5/8.12.3/Submit) id g6B1QHMI030094
	for linux-mips-outgoing; Wed, 10 Jul 2002 18:26:17 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from deliverator.sgi.com (deliverator.SGI.COM [204.94.214.10] (may be forged))
	by oss.sgi.com (8.12.5/8.12.5) with SMTP id g6B1Q6Rw030067;
	Wed, 10 Jul 2002 18:26:07 -0700
Received: from av.mvista.com (gateway-1237.mvista.com [12.44.186.158]) 
	by deliverator.sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id SAA00424; Wed, 10 Jul 2002 18:30:37 -0700 (PDT)
	mail_from (jsun@mvista.com)
Received: from mvista.com (av [127.0.0.1])
	by av.mvista.com (8.9.3/8.9.3) with ESMTP id SAA26657;
	Wed, 10 Jul 2002 18:25:31 -0700
Message-ID: <3D2CDCD0.7040704@mvista.com>
Date: Wed, 10 Jul 2002 18:18:08 -0700
From: Jun Sun <jsun@mvista.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.2.1) Gecko/20010901
X-Accept-Language: en-us
MIME-Version: 1.0
To: "H. J. Lu" <hjl@lucon.org>, Ralf Baechle <ralf@oss.sgi.com>
CC: linux-mips@oss.sgi.com
Subject: Re: Malta crashes on the latest 2.4 kernel
References: <3D2CBF73.50001@mvista.com> <20020710164900.A28911@lucon.org>
Content-Type: multipart/mixed;
 boundary="------------090008060701090105000000"
X-Spam-Status: No, hits=-3.7 required=5.0 tests=MAY_BE_FORGED,UNIFIED_PATCH version=2.20
X-Spam-Level: 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


This is a multi-part message in MIME format.
--------------090008060701090105000000
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

H. J. Lu wrote:

> On Wed, Jul 10, 2002 at 04:12:51PM -0700, Jun Sun wrote:
> 
>>See the crash scene.  Anybody knows the cause?  It is strange to see the 
>>reserved exception.
>>
>>
> 
> The 2.4 kernel checked out around Jul  4 09:28 PDT works fine on Malta.
> 


Ralf,

Apparently this is a well-known problem.  So *please* apply this patch or give 
  some constructive advice if the patch cannot be applied as it is.

Jun


--------------090008060701090105000000
Content-Type: text/plain;
 name="junk"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="junk"

diff -Nru arch/mips/mm/tlb-r4k.c.orig arch/mips/mm/tlb-r4k.c
--- arch/mips/mm/tlb-r4k.c.orig	Thu Jun 27 14:12:40 2002
+++ arch/mips/mm/tlb-r4k.c	Wed Jul 10 18:06:34 2002
@@ -125,6 +125,7 @@
 				BARRIER;
 				/* Make sure all entries differ. */
 				set_entryhi(KSEG0+idx*0x2000);
+				BARRIER;
 				tlb_write_indexed();
 				BARRIER;
 			}

--------------090008060701090105000000--
