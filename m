Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 23 Apr 2004 04:22:48 +0100 (BST)
Received: from ispmxmta06-srv.alltel.net ([IPv6:::ffff:166.102.165.167]:43395
	"EHLO ispmxmta06-srv.alltel.net") by linux-mips.org with ESMTP
	id <S8224770AbUDWDWr>; Fri, 23 Apr 2004 04:22:47 +0100
Received: from lahoo.priv ([162.39.1.206]) by ispmxmta06-srv.alltel.net
          with ESMTP
          id <20040423032239.QXNV24676.ispmxmta06-srv.alltel.net@lahoo.priv>
          for <linux-mips@linux-mips.org>; Thu, 22 Apr 2004 22:22:39 -0500
Received: from prefect.priv ([10.1.1.141] helo=prefect)
	by lahoo.priv with smtp (Exim 3.36 #1 (Debian))
	id 1BGr1R-0005hF-00
	for <linux-mips@linux-mips.org>; Thu, 22 Apr 2004 23:06:37 -0400
Message-ID: <06d601c428e2$3ba1dcc0$8d01010a@prefect>
From: "Bradley D. LaRonde" <brad@laronde.org>
To: <linux-mips@linux-mips.org>
Subject: inconsistent operand constraints in 'asm' in unaligned.h:66 using gcc 3.4
Date: Thu, 22 Apr 2004 23:22:40 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1409
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1409
Return-Path: <brad@laronde.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4845
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: brad@laronde.org
Precedence: bulk
X-list: linux-mips

gcc 3.4 complians about:

include/asm/unaligned.h:66: error: inconsistent operand constraints in an
`asm'

from linux CVS 2.4 branch.  That's:

/*
 * Store doubleword ununaligned.
 */
static inline void __stq_u(unsigned long __val, unsigned long long * __addr)
{
        __asm__("usw\t%1, %0\n\t"
                "usw\t%D1, 4+%0"
                : "=m" (*__addr)
                : "r" (__val));
}

I was baffled by the "%D1" syntax until Thiemo Seufer pointed out that %D1
assembled to "one register higher than the register chosen for %1".
Ooooookay.  But gcc complains about a constraint problem.  Maybe "r" and
"%Dn" don't get along (long)?

Anyway... what about __val's type?  I would expect that to be "unsigned long
long" for -mabi=32.  Otherwise will "%D" get what the asm author expected?
If I do change it to "unsigned long long" then I get two of the constraint
errors.  Ooooookay.  Anyone got a constraint that means "consecutive
register pair"?

I finally decided to punt and write:

static inline void __stq_u(unsigned long long __val, unsigned long long *
__addr)
{
        *__addr = __val;
}

Is this OK?  Is there a better solution?


Regards,
Brad
