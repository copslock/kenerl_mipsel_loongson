Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f3NGVXr00633
	for linux-mips-outgoing; Mon, 23 Apr 2001 09:31:33 -0700
Received: from enst.enst.fr (enst.enst.fr [137.194.2.16])
	by oss.sgi.com (8.11.3/8.11.3) with ESMTP id f3NGVWM00630
	for <linux-mips@oss.sgi.com>; Mon, 23 Apr 2001 09:31:33 -0700
Received: from email.enst.fr (muse.enst.fr [137.194.2.33])
	by enst.enst.fr (Postfix) with ESMTP id D61651C919
	for <linux-mips@oss.sgi.com>; Mon, 23 Apr 2001 18:31:27 +0200 (MET DST)
Received: from chimene.enst.fr (chimene.enst.fr [137.194.168.41])
	by email.enst.fr (8.9.3/8.9.3) with ESMTP id SAA27869
	for <linux-mips@oss.sgi.com>; Mon, 23 Apr 2001 18:31:07 +0200 (MET DST)
Received: from localhost (bellard@localhost)
	by chimene.enst.fr (8.9.3+Sun/8.9.3) with SMTP id SAA20655
	for <linux-mips@oss.sgi.com>; Mon, 23 Apr 2001 18:31:21 +0200 (MEST)
Date: Mon, 23 Apr 2001 18:31:20 +0200 (MEST)
From: Fabrice Bellard <bellard@email.enst.fr>
To: linux-mips@oss.sgi.com
Subject: gdb single step ?
In-Reply-To: <3AE44D0A.9080003@jungo.com>
Message-ID: <Pine.GSO.4.02.10104231829020.19846-100000@chimene.enst.fr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Hi!

Did someone make a patch so that gdb can do single step on mips-linux ? If
not, do you prefer a patch to gdb or a patch in the kernel to support the
PTRACE_SINGLESTEP command ?

Fabrice.
