Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 23 Jul 2005 22:47:02 +0100 (BST)
Received: from alpha.total-knowledge.com ([IPv6:::ffff:205.217.158.170]:47534
	"EHLO alpha.total-knowledge.com") by linux-mips.org with ESMTP
	id <S8225426AbVGWVqo>; Sat, 23 Jul 2005 22:46:44 +0100
Received: (qmail 32186 invoked from network); 23 Jul 2005 14:48:53 -0700
Received: from c-24-6-216-150.hsd1.ca.comcast.net (HELO ?192.168.0.238?) (24.6.216.150)
  by alpha.total-knowledge.com with SMTP; 23 Jul 2005 14:48:53 -0700
Message-ID: <42E2BB4F.7080301@total-knowledge.com>
Date:	Sat, 23 Jul 2005 14:49:03 -0700
From:	"Ilya A. Volynets-Evenbakh" <ilya@total-knowledge.com>
Organization: Total Knowledge
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050723)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To:	Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: Get rid of a warning
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <ilya@total-knowledge.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8628
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ilya@total-knowledge.com
Precedence: bulk
X-list: linux-mips

void functions shouldn't return values ;-)

-- 
Ilya A. Volynets-Evenbakh
Total Knowledge. CTO
http://www.total-knowledge.com


Index: arch/mips/au1000/pb1000/init.c
===================================================================
RCS file: /home/cvs/linux/arch/mips/au1000/pb1000/init.c,v
retrieving revision 1.10
diff -u -r1.10 init.c
--- arch/mips/au1000/pb1000/init.c      18 Nov 2003 01:17:46 -0000      1.10
+++ arch/mips/au1000/pb1000/init.c      23 Jul 2005 15:38:21 -0000
@@ -65,5 +65,4 @@
                memsize = simple_strtol(memsize_str, NULL, 0);
        }
        add_memory_region(0, memsize, BOOT_MEM_RAM);
-       return 0;
 }
