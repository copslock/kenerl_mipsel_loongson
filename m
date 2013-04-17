Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 23 Apr 2013 17:09:13 +0200 (CEST)
Received: from smtp-gw21.han.skanova.net ([81.236.55.21]:53678 "EHLO
        smtp-gw21.han.skanova.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6823703Ab3DQSLySNSr1 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 17 Apr 2013 20:11:54 +0200
Received: from [172.16.1.1] (217.210.186.205) by smtp-gw21.han.skanova.net (8.5.133)
        id 516D06FA000EB0F7; Wed, 17 Apr 2013 20:11:48 +0200
Message-ID: <516EE5E4.1010605@corelatus.se>
Date:   Wed, 17 Apr 2013 20:11:48 +0200
From:   Thomas Lange <thomas@corelatus.se>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:10.0.12) Gecko/20130116 Icedove/10.0.12
MIME-Version: 1.0
To:     ralf@linux-mips.org
CC:     linux-mips@linux-mips.org
Subject: c17a6554 broke 64BIT_PHYS_ADDR for 32 bit systems
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <thomas@corelatus.se>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36286
X-Approved-By: ralf@linux-mips.org
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: thomas@corelatus.se
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

Dear Ralf,

commit c17a6554 unintentionally(?) modified the PAGE_MASK type
from (int) to (long unsigned int).

This breaks ioremap (and possibly more) when using 64BIT_PHYS_ADDR on
32 bit systems.
Example of failing code from ioremap.c:

	phys_addr &= PAGE_MASK;

Since phys_addr is 64 bit (unsigned long long) when 64BIT_PHYS_ADDR and
PAGE_MASK is 32bit (long unsigned int), the upper 32 bits will always
be zeroed which is not what we want/expect.

The code above works if PAGE_MASK is a _signed_ 32bit int though.

Some possible fixes:

A) Simply revert the commit. Makes ioremap work again, but then PAGE_MASK
    is a signed int. Do we really want a mask that is 'signed'?

B) Don't use PAGE_MASK for physical addresses. x86 defines this:

   /* Cast PAGE_MASK to a signed type so that it is sign-extended if
      virtual addresses are 32-bits but physical addresses are larger
      (ie, 32-bit PAE). */
   #define PHYSICAL_PAGE_MASK	(((signed long)PAGE_MASK) & __PHYSICAL_MASK)

   Perhaps mips need something similar?


This is an issue with 3.8 and doesn't seem to be solved in master either.

Regards,
/Thomas
