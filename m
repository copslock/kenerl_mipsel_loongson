Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 24 Mar 2004 21:03:25 +0000 (GMT)
Received: from punt-2.aladdin.de ([IPv6:::ffff:195.124.73.2]:60105 "HELO
	punt.aladdin.de") by linux-mips.org with SMTP id <S8225539AbUCXVDU>;
	Wed, 24 Mar 2004 21:03:20 +0000
Received: by punt.aladdin.de; id WAA28029; Wed, 24 Mar 2004 22:06:00 +0100
Received: from caligula.groessler.org(10.23.1.2) by punt.aladdin.de via smap (3.2)
	id xma028027; Wed, 24 Mar 04 22:05:52 +0100
Received: from langhals (langhals.groessler.org [10.23.1.27])
	by Caligula.groessler.org (8.12.10/8.12.9) with ESMTP id i2OL35fM000660;
	Wed, 24 Mar 2004 22:03:05 +0100 (CET)
	(envelope-from cpg@aladdin.de)
Received: from langhals ([127.0.0.1] helo=langhals.aladdin.de)
	by langhals with esmtp (Exim 3.36 #1 (Debian))
	id 1B6FXT-0001Se-00; Wed, 24 Mar 2004 22:03:51 +0100
To: linux-mips@linux-mips.org
Subject: cannot compile 2.6.4 cvs version for Decstation
From: Christian Groessler <cpg@aladdin.de>
Date: 24 Mar 2004 22:03:50 +0100
Message-ID: <87lllqarex.fsf@aladdin.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-Path: <cpg@aladdin.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4628
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: cpg@aladdin.de
Precedence: bulk
X-list: linux-mips

Hi,

I get


  CC      drivers/tc/lk201.o
drivers/tc/lk201.c:19:26: linux/kbd_ll.h: No such file or directory
drivers/tc/lk201.c:23:26: asm/keyboard.h: No such file or directory
In file included from drivers/tc/lk201.c:27:
drivers/tc/zs.h:152: error: field `tqueue' has incomplete type
drivers/tc/zs.h:153: error: field `tqueue_hangup' has incomplete type
drivers/tc/lk201.c: In function `parse_kbd_rate':
drivers/tc/lk201.c:189: error: structure has no member named `rate'
drivers/tc/lk201.c:190: error: structure has no member named `rate'
drivers/tc/lk201.c:190: error: structure has no member named `rate'
drivers/tc/lk201.c:196: error: structure has no member named `rate'
drivers/tc/lk201.c:197: error: structure has no member named `rate'
drivers/tc/lk201.c:198: error: structure has no member named `rate'
drivers/tc/lk201.c:199: error: structure has no member named `rate'
drivers/tc/lk201.c:200: error: structure has no member named `rate'
drivers/tc/lk201.c:201: error: structure has no member named `rate'
drivers/tc/lk201.c: In function `write_kbd_rate':
drivers/tc/lk201.c:211: error: structure has no member named `rate'
drivers/tc/lk201.c: In function `lk201_kbd_rx_char':
drivers/tc/lk201.c:365: warning: implicit declaration of function `handle_scancode'
drivers/tc/lk201.c: In function `lk201_init':
drivers/tc/lk201.c:409: error: invalid lvalue in assignment
drivers/tc/lk201.c:410: error: invalid lvalue in assignment
make[2]: *** [drivers/tc/lk201.o] Error 1
make[1]: *** [drivers/tc] Error 2
make: *** [drivers] Error 2

Please cc answers as I'm not on the list.

regards,
chris
