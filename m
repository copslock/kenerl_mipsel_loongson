Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 26 Jul 2004 17:16:02 +0100 (BST)
Received: from dfpost.ru ([IPv6:::ffff:194.85.103.225]:51099 "EHLO
	mail.postwin.ru") by linux-mips.org with ESMTP id <S8225230AbUGZQP5>;
	Mon, 26 Jul 2004 17:15:57 +0100
Received: by mail.postwin.ru (Postfix, from userid 7896)
	id E95D8844F8; Mon, 26 Jul 2004 20:13:41 +0400 (MSD)
Received: from [192.168.9.60] (unknown [192.168.9.60])
	by mail.postwin.ru (Postfix) with ESMTP id D6AC9844F5
	for <linux-mips@linux-mips.org>; Mon, 26 Jul 2004 20:13:41 +0400 (MSD)
Message-ID: <41056663.6000304@dfpost.ru>
Date: Mon, 26 Jul 2004 20:15:31 +0000
From: Dmitriy Tochansky <toch@dfpost.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.1) Gecko/20040723
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-mips@linux-mips.org
Subject: assembler problem
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <toch@dfpost.ru>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5557
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: toch@dfpost.ru
Precedence: bulk
X-list: linux-mips

Hello!
I have some problem with assembling my program.

Here is a string from source:
*//*/ jal             sdram_memory_test/

in .lst file I got:

/101 00c8 7600000C              jal             sdram_memory_test/

Looking for sdram_memory_test below....

/295 01d8 0000083C              la      ADDR, _etext            /* Start 
addr of test *//

Hm...

Upload test2.bin in 0xbfc00000 on flash. Starting. Debugging....

Everything goes fine but when become time to jump on sdram_memory_test 
it jumps at 0xb00001d8
but I think it must jump to 0xbfc001d8 where real sdram_test is.

Where is the problem?

Dmitriy
