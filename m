Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 22 Mar 2003 21:23:22 +0000 (GMT)
Received: from honk1.physik.uni-konstanz.de ([IPv6:::ffff:134.34.140.224]:29421
	"EHLO honk1.physik.uni-konstanz.de") by linux-mips.org with ESMTP
	id <S8225207AbTCVVXV>; Sat, 22 Mar 2003 21:23:21 +0000
Received: from localhost (localhost [127.0.0.1])
	by honk1.physik.uni-konstanz.de (Postfix) with ESMTP
	id E6B212BC31; Sat, 22 Mar 2003 22:23:18 +0100 (CET)
Received: from honk1.physik.uni-konstanz.de ([127.0.0.1])
 by localhost (honk [127.0.0.1:10024]) (amavisd-new) with ESMTP id 15044-06;
 Sat, 22 Mar 2003 22:23:17 +0100 (CET)
Received: from bogon.sigxcpu.org (kons-d9bb5455.pool.mediaWays.net [217.187.84.85])
	by honk1.physik.uni-konstanz.de (Postfix) with ESMTP
	id 9EC772BC2D; Sat, 22 Mar 2003 22:23:16 +0100 (CET)
Received: by bogon.sigxcpu.org (Postfix, from userid 1000)
	id 440031735C; Sat, 22 Mar 2003 22:20:40 +0100 (CET)
Date: Sat, 22 Mar 2003 22:20:39 +0100
From: Guido Guenther <agx@sigxcpu.org>
To: ralf@linux-mips.org
Cc: linux-mips@linux-mips.org
Subject: [PATCH 2.5]: move do_signal32 declaration upwards
Message-ID: <20030322212039.GA19984@bogon.ms20.nix>
Mail-Followup-To: Guido Guenther <agx@sigxcpu.org>,
	ralf@linux-mips.org, linux-mips@linux-mips.org
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="7JfCtLOvnd9MIVvH"
Content-Disposition: inline
User-Agent: Mutt/1.4i
Return-Path: <agx@sigxcpu.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1793
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: agx@sigxcpu.org
Precedence: bulk
X-list: linux-mips


--7JfCtLOvnd9MIVvH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,
do_signal32 is needed in do_signal but declared after that function
which makes this an implicit declaration. Moving the declaration upward
fixes the warning. Patch attached, please apply.
 -- Guido

--7JfCtLOvnd9MIVvH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="do_signal32.diff"

Index: arch/mips64/kernel/signal.c
===================================================================
RCS file: /home/cvs/linux/arch/mips64/kernel/signal.c,v
retrieving revision 1.37
diff -u -p -r1.37 signal.c
--- arch/mips64/kernel/signal.c	6 Mar 2003 21:30:48 -0000	1.37
+++ arch/mips64/kernel/signal.c	22 Mar 2003 21:18:45 -0000
@@ -341,6 +341,10 @@ static inline void handle_signal(unsigne
 	}
 }
 
+
+extern int do_signal32(sigset_t *oldset, struct pt_regs *regs);
+extern int do_irix_signal(sigset_t *oldset, struct pt_regs *regs);
+
 asmlinkage int do_signal(sigset_t *oldset, struct pt_regs *regs)
 {
 	siginfo_t info;
@@ -377,8 +381,6 @@ asmlinkage int do_signal(sigset_t *oldse
 	return 0;
 }
 
-extern int do_irix_signal(sigset_t *oldset, struct pt_regs *regs);
-extern int do_signal32(sigset_t *oldset, struct pt_regs *regs);
 
 /*
  * notification of userspace execution resumption

--7JfCtLOvnd9MIVvH--
