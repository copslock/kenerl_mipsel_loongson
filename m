Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 11 Jun 2004 12:49:59 +0100 (BST)
Received: from web12006.mail.yahoo.com ([IPv6:::ffff:216.136.172.214]:46776
	"HELO web12006.mail.yahoo.com") by linux-mips.org with SMTP
	id <S8225924AbUFKLtz>; Fri, 11 Jun 2004 12:49:55 +0100
Message-ID: <20040611114948.22634.qmail@web12006.mail.yahoo.com>
Received: from [128.107.253.44] by web12006.mail.yahoo.com via HTTP; Fri, 11 Jun 2004 04:49:48 PDT
Date: Fri, 11 Jun 2004 04:49:48 -0700 (PDT)
From: "Ashok.A" <ashok_kumar_ak@yahoo.com>
Subject: Is "memory" clobber required for all inline asm which does atomic operation???
To: linux-mips@linux-mips.org
Cc: ashok_kumar_ak@yahoo.com
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-Path: <ashok_kumar_ak@yahoo.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5283
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ashok_kumar_ak@yahoo.com
Precedence: bulk
X-list: linux-mips

Hello Folks,

I am working on inline asm related staff. I couldn't
get proper answer for this question. So posting this
question here..... Expecting good response from you.

* Should we use "memory" clobber in *every* inline asm
  which does atomic operation? (In MIPS, 'll'/'sc'
  instructions are used to provide atomic operation)

As per my understanding, "memory" clobber will be
required for inline asm only if the corresponding
functions can be used to implement *lock* and *unlock*
primitives (or) memory modified by the inline asm
is *unknown*. Please correct me if I am wrong.

In the following URL, "memory" clobber has been
specified in the functions 'atomic_add_return' and
'atomic_sub_return'. But it is *not* specified in
the functions 'atomic_add' and 'atomic_sub'. WHY?

http://lxr.linux.no/source/include/asm-mips/atomic.h?v=2.6.5

Does it mean that 'atomic_add'/'atomic_sub' (which
returns 'void') can't be used to implement *lock*
and *unlock* primitives?

Please clarify it. Thanks in advance!

Expecting your responses ...

-AshokA


	
		
__________________________________
Do you Yahoo!?
Friends.  Fun.  Try the all-new Yahoo! Messenger.
http://messenger.yahoo.com/ 
