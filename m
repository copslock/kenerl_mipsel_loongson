Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 11 May 2003 10:31:53 +0100 (BST)
Received: from honk1.physik.uni-konstanz.de ([IPv6:::ffff:134.34.140.224]:64206
	"EHLO honk1.physik.uni-konstanz.de") by linux-mips.org with ESMTP
	id <S8225193AbTEKJbv>; Sun, 11 May 2003 10:31:51 +0100
Received: from localhost (localhost [127.0.0.1])
	by honk1.physik.uni-konstanz.de (Postfix) with ESMTP id C68992BC36
	for <linux-mips@linux-mips.org>; Sun, 11 May 2003 11:31:48 +0200 (CEST)
Received: from honk1.physik.uni-konstanz.de ([127.0.0.1])
 by localhost (honk [127.0.0.1:10024]) (amavisd-new) with ESMTP id 31083-02
 for <linux-mips@linux-mips.org>; Sun, 11 May 2003 11:31:47 +0200 (CEST)
Received: from bogon.sigxcpu.org (kons-d9bb55c8.pool.mediaWays.net [217.187.85.200])
	by honk1.physik.uni-konstanz.de (Postfix) with ESMTP id 56ACD2BC35
	for <linux-mips@linux-mips.org>; Sun, 11 May 2003 11:31:47 +0200 (CEST)
Received: by bogon.sigxcpu.org (Postfix, from userid 1000)
	id 197171737F; Sun, 11 May 2003 11:28:29 +0200 (CEST)
Date: Sun, 11 May 2003 11:28:29 +0200
From: Guido Guenther <agx@sigxcpu.org>
To: linux-mips@linux-mips.org
Subject: Re: compiling glibc
Message-ID: <20030511092828.GA3889@bogon.ms20.nix>
Mail-Followup-To: Guido Guenther <agx@sigxcpu.org>,
	linux-mips@linux-mips.org
References: <200305092145.43690.benmen@gmx.de> <200305101321.21232.benmen@gmx.de> <20030510194351.GA15891@nevyn.them.org> <200305110235.14606.benmen@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <200305110235.14606.benmen@gmx.de>
User-Agent: Mutt/1.5.3i
Return-Path: <agx@sigxcpu.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2348
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: agx@sigxcpu.org
Precedence: bulk
X-list: linux-mips

On Sun, May 11, 2003 at 02:35:14AM +0200, Benjamin Menküc wrote:
[..snip..] 
> /bin/sh: line 1: /home/benmen/mips/mipsel-glibc/misc/syscall-list.h.new: Datei 
> oder Verzeichnis nicht gefunden
> mv -f /home/benmen/mips/mipsel-glibc/misc/syscall-list.h.new 
> /home/benmen/mips/mipsel-glibc/misc/syscall-list.h
> mv: Aufruf von stat für 
[..snip..] 

Index: sysdeps/unix/sysv/linux/mips/Makefile
===================================================================
RCS file: /cvs/glibc/libc/sysdeps/unix/sysv/linux/mips/Makefile,v
retrieving revision 1.8
diff -u -p -u -r1.8 Makefile
--- sysdeps/unix/sysv/linux/mips/Makefile	17 Mar 2003 15:50:05 -0000	1.8
+++ sysdeps/unix/sysv/linux/mips/Makefile	5 May 2003 08:53:35 -0000
@@ -15,6 +15,7 @@ no_syscall_list_h = 1
 # We generate not only SYS_<syscall>, pointing at SYS_<abi>_<syscall> if
 # it exists, but also define SYS_<abi>_<syscall> for all ABIs.
 $(objpfx)syscall-%.h $(objpfx)syscall-%.d: ../sysdeps/unix/sysv/linux/mips/sys/syscall.h
+	mkdir -p $(objpfx)
 	rm -f $(@:.h=.d)-t
 	{ \
 	 echo '/* Generated at libc build time from kernel syscall list.  */';\

Hope that helps,
 -- Guido
