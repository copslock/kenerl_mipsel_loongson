Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 24 Sep 2003 07:05:11 +0100 (BST)
Received: from web2307.mail.yahoo.co.jp ([IPv6:::ffff:211.14.15.227]:19814
	"HELO web2307.mail.yahoo.co.jp") by linux-mips.org with SMTP
	id <S8225406AbTIXGFJ>; Wed, 24 Sep 2003 07:05:09 +0100
Message-ID: <20030924060456.11903.qmail@web2307.mail.yahoo.co.jp>
Received: from [150.87.248.20] by web2307.mail.yahoo.co.jp via HTTP; Wed, 24 Sep 2003 15:04:56 JST
Date: Wed, 24 Sep 2003 15:04:56 +0900 (JST)
From: =?ISO-2022-JP?B?GyRCOXVERRsoQiAbJEI0cExvGyhC?= 
	<mips4700@yahoo.co.jp>
Subject: mips inline asm question
To: linux-mips@linux-mips.org
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-2022-jp
Return-Path: <mips4700@yahoo.co.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3284
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mips4700@yahoo.co.jp
Precedence: bulk
X-list: linux-mips

Hi, all;

The following code is from
linux-2.4.20/include/asm-mips/mipsregs.h.
Could anyone tell how the difference between %z0 ("Jr")
and %0 ("r") is?
I compiled this code and deassemble the object, but I
can't find any 
difference with my toolchains(gcc-2.95.3, binutils-2.11).

static inline void set_context(unsigned long val)
{
        __asm__ __volatile__(
                ".set push\n\t"
                ".set reorder\n\t"
                "mtc0 %z0, $4\n\t"
                ".set pop"
                : : "Jr" (val));
}

Thanks in advance
mips4700


__________________________________________________
Do You Yahoo!?
Yahoo! BB is Broadband by Yahoo!
http://bb.yahoo.co.jp/
