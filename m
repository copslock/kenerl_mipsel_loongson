Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f7R6XRR15169
	for linux-mips-outgoing; Sun, 26 Aug 2001 23:33:27 -0700
Received: from dea.linux-mips.net (u-161-10.karlsruhe.ipdial.viaginterkom.de [62.180.10.161])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f7R6XKd15166
	for <linux-mips@oss.sgi.com>; Sun, 26 Aug 2001 23:33:21 -0700
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.1/8.11.1) id f7R6UHo02719;
	Mon, 27 Aug 2001 08:30:17 +0200
Date: Mon, 27 Aug 2001 08:30:17 +0200
From: Ralf Baechle <ralf@oss.sgi.com>
To: Atsushi Nemoto <nemoto@toshiba-tops.co.jp>
Cc: linux-mips@fnet.fr, linux-mips@oss.sgi.com
Subject: Re: scall_o32.S in 2.4.6 (or later)
Message-ID: <20010827083017.A2689@dea.linux-mips.net>
References: <20010827.101340.74756473.nemoto@toshiba-tops.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010827.101340.74756473.nemoto@toshiba-tops.co.jp>; from nemoto@toshiba-tops.co.jp on Mon, Aug 27, 2001 at 10:13:40AM +0900
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Mon, Aug 27, 2001 at 10:13:40AM +0900, Atsushi Nemoto wrote:

> After merging with 2.4.6, it seems that syscall destroy static
> registers.  Isnt't this needed?

Only if you insist on keeping register contents ;-)

The SAVE_STATIC was actually there, just at the wrong place, so the correct
patch is below.

Index: arch/mips/kernel/scall_o32.S
===================================================================
RCS file: /home/pub/cvs/linux/arch/mips/kernel/scall_o32.S,v
retrieving revision 1.16
diff -u -r1.16 scall_o32.S
--- arch/mips/kernel/scall_o32.S	2001/08/22 03:23:59	1.16
+++ arch/mips/kernel/scall_o32.S	2001/08/27 06:31:46
@@ -86,13 +86,13 @@
 	ori	t0, t0, 1
 	mtc0	t0, CP0_STATUS
 
+	SAVE_STATIC
 	move	a0, zero
 	move	a1, sp
 	jal	do_signal
 	b	restore_all
 
 o32_reschedule:
-	SAVE_STATIC
 	jal	schedule
 	b	o32_ret_from_sys_call
 

  Ralf
