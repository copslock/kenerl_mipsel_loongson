Received: (from mail@localhost)
	by linux-xfs.sgi.com (8.12.0.Beta5/8.12.0.Beta5) id f591pBlS009346
	for linux-mips-outgoing; Fri, 8 Jun 2001 18:51:11 -0700
X-Authentication-Warning: linux-xfs.sgi.com: mail set sender to owner-linux-mips@oss.sgi.com using -f
Received: from mx.mips.com (mx.mips.com [206.31.31.226])
	by linux-xfs.sgi.com (8.12.0.Beta5/8.12.0.Beta5) with SMTP id f591pA3D009336
	for <linux-mips@oss.sgi.com>; Fri, 8 Jun 2001 18:51:10 -0700
Received: from newman.mips.com (ns-dmz [206.31.31.225])
	by mx.mips.com (8.9.3/8.9.0) with ESMTP id SAA23742
	for <linux-mips@oss.sgi.com>; Fri, 8 Jun 2001 18:51:03 -0700 (PDT)
Received: from hubble.mips.com (hubble [192.168.10.76])
	by newman.mips.com (8.9.3/8.9.0) with ESMTP id SAA28534
	for <linux-mips@oss.sgi.com>; Fri, 8 Jun 2001 18:51:01 -0700 (PDT)
Received: from hubble (hubble [192.168.10.76])
	by hubble.mips.com (8.9.3/8.9.0) with SMTP id SAA11162
	for <linux-mips@oss.sgi.com>; Fri, 8 Jun 2001 18:51:01 -0700 (PDT)
Message-Id: <200106090151.SAA11162@hubble.mips.com>
Date: Fri, 8 Jun 2001 18:51:01 -0700 (PDT)
From: Carsten Langgaard <carstenl@mips.com>
Reply-To: Carsten Langgaard <carstenl@mips.com>
Subject: emulate_load_store_insn
To: linux-mips@oss.sgi.com
MIME-Version: 1.0
Content-Type: TEXT/plain; charset=us-ascii
Content-MD5: b1eslZYE+V5oLyBKYLmx3g==
X-Mailer: dtmail 1.2.1 CDE Version 1.2.1 SunOS 5.6 sun4u sparc 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Can anyone please explain the whole deal with the emulate_load_store_insn 
function in arch/mips/kernel/unaligned.c.
Isn't there a potential hole there, where a user application makes an illegal 
memory access to an unaligned address and then the kernel tries to emulate that 
and crashes.
It also look like the MF_FIXADE flag is set by default, why is that ? Shouldn't 
one suppose to make a syscall setting this MF_FIXADE flag ?

/Carsten
