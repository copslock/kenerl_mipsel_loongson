Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 20 May 2003 14:58:51 +0100 (BST)
Received: from honk1.physik.uni-konstanz.de ([IPv6:::ffff:134.34.140.224]:61121
	"EHLO honk1.physik.uni-konstanz.de") by linux-mips.org with ESMTP
	id <S8225196AbTETN6r>; Tue, 20 May 2003 14:58:47 +0100
Received: from localhost (localhost [127.0.0.1])
	by honk1.physik.uni-konstanz.de (Postfix) with ESMTP id 7AD9C2BC3E
	for <linux-mips@linux-mips.org>; Tue, 20 May 2003 15:58:33 +0200 (CEST)
Received: from honk1.physik.uni-konstanz.de ([127.0.0.1])
 by localhost (honk [127.0.0.1:10024]) (amavisd-new) with ESMTP id 00984-08
 for <linux-mips@linux-mips.org>; Tue, 20 May 2003 15:58:32 +0200 (CEST)
Received: from bogon.sigxcpu.org (bogon.physik.uni-konstanz.de [134.34.147.122])
	by honk1.physik.uni-konstanz.de (Postfix) with ESMTP id 515F42BC36
	for <linux-mips@linux-mips.org>; Tue, 20 May 2003 15:58:32 +0200 (CEST)
Received: by bogon.sigxcpu.org (Postfix, from userid 1000)
	id 179C91737F; Tue, 20 May 2003 15:54:42 +0200 (CEST)
Date: Tue, 20 May 2003 15:54:42 +0200
From: Guido Guenther <agx@sigxcpu.org>
To: linux-mips@linux-mips.org
Subject: Re: cvs glibc bug?
Message-ID: <20030520135441.GI11034@bogon.ms20.nix>
Mail-Followup-To: Guido Guenther <agx@sigxcpu.org>,
	linux-mips@linux-mips.org
References: <200305162333.34877.benmen@gmx.de> <20030516215147.GT8833@rembrandt.csv.ica.uni-stuttgart.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030516215147.GT8833@rembrandt.csv.ica.uni-stuttgart.de>
User-Agent: Mutt/1.5.3i
Return-Path: <agx@sigxcpu.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2417
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: agx@sigxcpu.org
Precedence: bulk
X-list: linux-mips

On Fri, May 16, 2003 at 11:51:47PM +0200, Thiemo Seufer wrote:
> SI_TKILL is new in glibc and not yet ported to mips.
Well, the kernel's include/asm-mips/siginfo.h defines SI_KILL as -6
while glibc defines SI_ASYNCNL as -6. Is there a reason for this or is
this just a typo, all other architectures define the later as -60. If
it's a typo i'd like to keep this in sync with other architectures:
 
Index: sysdeps/unix/sysv/linux/mips/bits/siginfo.h
===================================================================
RCS file: /cvs/glibc/libc/sysdeps/unix/sysv/linux/mips/bits/siginfo.h,v
retrieving revision 1.9
diff -u -p -u -r1.9 siginfo.h
--- sysdeps/unix/sysv/linux/mips/bits/siginfo.h	5 Dec 2002 00:23:59 -0000	1.9
+++ sysdeps/unix/sysv/linux/mips/bits/siginfo.h	20 May 2003 12:57:08 -0000
@@ -119,8 +119,10 @@ typedef struct siginfo
    signals.  */
 enum
 {
-  SI_ASYNCNL = -6,		/* Sent by asynch name lookup completion.  */
+  SI_ASYNCNL = -60,		/* Sent by asynch name lookup completion.  */
 # define SI_ASYNCNL	SI_ASYNCNL
+  SI_TKILL = -6,		/* Sent by tkill. */
+# define SI_TKILL	SI_TKILL
   SI_SIGIO,			/* Sent by queued SIGIO. */
 # define SI_SIGIO	SI_SIGIO
   SI_MESGQ,			/* Sent by real time mesq state change.  */

Regards,
 -- Guido
