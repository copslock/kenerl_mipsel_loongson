Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 20 Apr 2004 23:45:35 +0100 (BST)
Received: from amsfep12-int.chello.nl ([IPv6:::ffff:213.46.243.18]:13841 "EHLO
	amsfep12-int.chello.nl") by linux-mips.org with ESMTP
	id <S8225525AbUDTWpe>; Tue, 20 Apr 2004 23:45:34 +0100
Received: from node-d-8d2e.a2000.nl ([62.195.141.46])
          by amsfep12-int.chello.nl
          (InterMail vM.6.00.05.02 201-2115-109-103-20031105) with ESMTP
          id <20040420224526.FLAG18840.amsfep12-int.chello.nl@node-d-8d2e.a2000.nl>;
          Wed, 21 Apr 2004 00:45:26 +0200
Subject: locking problems with mips atomicity ?
From: Harm Verhagen <hverhagen@dse.nl>
To: linux-mips@linux-mips.org
Content-Type: text/plain
Organization: 
Message-Id: <1082501074.13783.54.camel@node-d-8d2e.a2000.nl>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 21 Apr 2004 00:44:34 +0200
Content-Transfer-Encoding: 7bit
Return-Path: <hverhagen@dse.nl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4824
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hverhagen@dse.nl
Precedence: bulk
X-list: linux-mips

Hi folks,

I noticed the following thread "locking problem with mips atomicity" on
the GCC mailing list, and I started to wonder if the linux kernel has
the same problem.

http://gcc.gnu.org/ml/gcc/2004-03/threads.html#01061


It about the problem that gcc can generate loads (using AT) in between
the ll and sc instructions (which is not legal according to the MIPS
spec) This can happen when  incorrect constraints are used with the
inline assembly, and the inline assembly happens to be in an inline
functions.

The code from linux 2.4.26 arch-mips/atomic.h looks _very_ similar to
the code described in the thread that has a BUG.

static __inline__ void atomic_add(int i, atomic_t * v)
{
	unsigned long temp;

	__asm__ __volatile__(
		"1:   ll      %0, %1      # atomic_add\n"
		"     addu    %0, %2                  \n"
		"     sc      %0, %1                  \n"
		"     beqz    %0, 1b                  \n"
		: "=&r" (temp), "=m" (v->counter)
		: "Ir" (i), "m" (v->counter));
}

So I wonder if there is a bug here. 
Can some MIPS guru check ? :)


Please copy me on replies as I'm not subscribed

Kind regards,
Harm Verhagen
