Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.5/8.12.5) with ESMTP id g6PC2IRw001785
	for <linux-mips-outgoing@oss.sgi.com>; Thu, 25 Jul 2002 05:02:18 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.5/8.12.3/Submit) id g6PC2IIh001784
	for linux-mips-outgoing; Thu, 25 Jul 2002 05:02:18 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from nt_server.stellartec.com (mail.stellartec.com [65.107.16.99])
	by oss.sgi.com (8.12.5/8.12.5) with SMTP id g6PC2GRw001758
	for <linux-mips@oss.sgi.com>; Thu, 25 Jul 2002 05:02:16 -0700
Received: from wssseeger ([192.168.1.53]) by nt_server.stellartec.com
          (Post.Office MTA v3.1.2 release (PO205-101c)
          ID# 568-43562U100L2S100) with SMTP id AAA557
          for <linux-mips@oss.sgi.com>; Thu, 25 Jul 2002 05:03:19 -0700
Reply-To: <sseeger@stellartec.com>
From: sseeger@stellartec.com (Steven Seeger)
To: <linux-mips@oss.sgi.com>
Subject: RE: kernel BUG at slab.c:1073!
Date: Thu, 25 Jul 2002 05:06:37 -0700
Message-ID: <011101c233d3$bab16860$3501a8c0@wssseeger>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook CWS, Build 9.0.2416 (9.0.2911.0)
In-Reply-To: <3D3EFCDE.5050503@mvista.com>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Importance: Normal
X-Spam-Status: No, hits=-3.9 required=5.0 tests=IN_REP_TO,PLING version=2.20
X-Spam-Level: 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

I had this problem when trying to run a module compiled for kernel version
2.4.18 on the old 2.4.0-test9 VR kernel. Something to do with different flag
values I think. A recompile with links to the proper kernel sources solved
the problem. Kmalloc was causing the issue. The flag value of GFP_KERNEL was
different or something.

Steve
