Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 18 Oct 2002 18:02:29 +0200 (CEST)
Received: from [64.238.111.99] ([64.238.111.99]:52750 "EHLO mail.ivivity.com")
	by linux-mips.org with ESMTP id <S1122962AbSJRQC2>;
	Fri, 18 Oct 2002 18:02:28 +0200
Received: by ATLOPS with Internet Mail Service (5.5.2653.19)
	id <414L5NCG>; Fri, 18 Oct 2002 12:02:20 -0400
Message-ID: <AEC4671C8179D61194DE0002B328BDD2070C7A@ATLOPS>
From: Dinesh Nagpure <dinesh_nagpure@ivivity.com>
To: linux-mips@linux-mips.org
Subject: memcpy( ) and alignment.
Date: Fri, 18 Oct 2002 12:02:19 -0400
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Return-Path: <dinesh_nagpure@ivivity.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 478
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dinesh_nagpure@ivivity.com
Precedence: bulk
X-list: linux-mips

Hello,

While compiling Kernel v2.4.16 for RM5231A using gcc-3.0.2, I am running
into some problems which I think are related to gcc, as a result memcpy( )
does not work well for me. Here is what happens,

I see all zeros in tty_std_termios.c_cc even after memcpy( ) is called to
copy the default termios string.

The code snippet is as below:
void __init console_init(void)
{

   memset(ldiscs, 0, sizeof(ldiscs));
  (void) tty_register_ldisc(N_TTY, &tty_ldisc_N_TTY);

   memset(&tty_std_termios, 0, sizeof(struct termios));
   memcpy(tty_std_termios.c_cc, INIT_C_CC, NCCS);


   printk("tty_std_termios is at %p\n", &tty_std_termios);
		|
		few more printk( ) calls etc.
}

The tty_std_termios is of type struct termios which is defined as below:

typedef unsigned char cc_t;
typedef unsigned long speed_t;
typedef unsigned long tcflag_t;

/*
 * The ABI says nothing about NCC but seems to use NCCS as
 * replacement for it in struct termio
 */
#define NCCS    23
struct termios {
        tcflag_t c_iflag;               /* input mode flags */
        tcflag_t c_oflag;               /* output mode flags */
        tcflag_t c_cflag;               /* control mode flags */
        tcflag_t c_lflag;               /* local mode flags */

        // cc_t c_cc[NCCS];                /* control characters */

        /*
         * Seems nonexistent in the ABI, but Linux assumes existence ...
         */
        cc_t c_line;                    /* line discipline */
        cc_t c_cc[NCCS];                /* control characters */
};

And the source string is:
#define INIT_C_CC 
"\003\034\177\025\1\0\0\0\021\023\032\0\022\017\027\026\004\0"

Because of the c_line member, c_cc is not word aligned and memcpy somehow
fails to do a copy there. If I swap c_cc and c_line memcpy does work. I also
tried -mmemcpy switch with the same results. Assembly dump shows proper
pointers being passed (unaligned) to memcpy but it fails. Swapping the
structure members can't be my solution because this must be happening at
many other places.

Is this really coming from GCC? Is there a way to fix this? 

Any hints/pointers will be greatly appreciated.

Dinesh


 
