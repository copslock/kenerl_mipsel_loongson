Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (970321.SGI.8.8.5/960327.SGI.AUTOCF) via SMTP id NAA12273; Thu, 17 Jul 1997 13:56:38 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id NAA21983 for linux-list; Thu, 17 Jul 1997 13:55:51 -0700
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id NAA21932 for <linux@engr.sgi.com>; Thu, 17 Jul 1997 13:55:45 -0700
Received: from neon.ingenia.ca (neon.ingenia.ca [205.207.220.57]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id NAA06073
	for <linux@engr.sgi.com>; Thu, 17 Jul 1997 13:55:44 -0700
	env-from (shaver@neon.ingenia.ca)
Received: (from shaver@localhost) by neon.ingenia.ca (8.8.5/8.7.3) id QAA11880 for linux@engr.sgi.com; Thu, 17 Jul 1997 16:50:54 -0400
From: Mike Shaver <shaver@neon.ingenia.ca>
Message-Id: <199707172050.QAA11880@neon.ingenia.ca>
Subject: strace 'LOOP' for MIPS
To: linux@cthulhu.engr.sgi.com (Linux/SGI list)
Date: Thu, 17 Jul 1997 16:50:54 -0400 (EDT)
X-Mailer: ELM [version 2.4ME+ PL28 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

>From strace/util.c:
#ifdef I386
#define LOOP	0x0000feeb
#else /* !I386 */
#ifdef M68K
#define LOOP	0x60fe0000
#else /* !M68K */
#ifdef ALPHA
#define LOOP    0xc3ffffff
#endif /* ALPHA */
#endif /* !M68K */
#endif /* !I386 */

What should LOOP be for the MIPS?
It appears to be the address of the breakpoint handler, but I'm not
sure:
	ptrace(PTRACE_POKETEXT, tcp->pid, (char *) tcp->baddr, LOOP);
	if (errno) {
		perror("setbpt: ptrace(PTRACE_POKETEXT, ...)");
		return -1;
	}

Mike

-- 
#> Mike Shaver (shaver@ingenia.com) Ingenia Communications Corporation 
#>                   Welcome to the technocracy.
#>                                                                     
#> "you'd be so disappointed
#>              to find out that the magic was not
#>                          really meant for you" - OLP
