Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 01 Oct 2002 10:40:36 +0200 (CEST)
Received: from h24-83-212-10.vc.shawcable.net ([24.83.212.10]:12539 "EHLO
	bard.illuminatus.org") by linux-mips.org with ESMTP
	id <S1122978AbSJAIkf>; Tue, 1 Oct 2002 10:40:35 +0200
Received: from templar ([10.0.0.2])
	by bard.illuminatus.org with esmtp (Exim 3.35 #1 (Debian))
	id 17wHnS-0003hp-00
	for <linux-mips@linux-mips.org>; Tue, 01 Oct 2002 00:50:22 -0700
Subject: pckbd_rate
From: Mike Nugent <mips@illuminatus.org>
To: linux-mips@linux-mips.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 01 Oct 2002 01:38:50 -0700
Message-Id: <1033461530.13264.86.camel@templar>
Mime-Version: 1.0
Return-Path: <mips@illuminatus.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 317
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mips@illuminatus.org
Precedence: bulk
X-list: linux-mips



I was compiling 2.4.18 and I ran into this (this was all done after the
symbolic links were set up to the mips directories):

When compiling /usr/src/kernel-source-2.4.18/drivers/char/keyboard.c:

Included in this order
#include <asm/keyboard.h>
...stuff...
#include <linux/vt_kern.h>

/usr/src/kernel-source-2.4.18/include/linux/vt_kern.h:35: `pckbd_rate'
redeclared as different kind of symbol
/usr/src/kernel-source-2.4.18/include/asm/keyboard.h:30: previous
declaration of `pckbd_rate'

in asm/keyboard.h
extern int pckbd_rate(struct kbd_repeat *rep);
#define kbd_rate                pckbd_rate

In that order, but, as I understand, the preprocessor will make a pass
and substitution before the c compiler is called so effectively
extern int kbd_rate(struct kbd_repeat *rep);

and in linux/vt_kern.h

extern int (*kbd_rate)(struct kbd_repeat *rep);

As you can see, the first is the variable and the second is a pointer. 
Which is right?

I commented out the pointer, chosen at random and crashed a bit later at
pc_keyb.c.  So I went back and commented out the first one.  Crashed in
the same place.  So I grabbed my keyboard.h from my 2.4.16 kernel and
copied it in.  It works fine.

Is this just me?

-- 
Mike Nugent
Programmer/Author
mike@illuminatus.org
"I believe the use of noise to make music will increase until we reach a
music produced through the aid of electrical instruments which will make
available for musical purposes any and all sounds that can be heard."
 -- composer John Cage, 1937
