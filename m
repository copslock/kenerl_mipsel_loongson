Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.5/8.12.5) with ESMTP id g66M3gRw028011
	for <linux-mips-outgoing@oss.sgi.com>; Sat, 6 Jul 2002 15:03:42 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.5/8.12.3/Submit) id g66M3g6F028010
	for linux-mips-outgoing; Sat, 6 Jul 2002 15:03:42 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from nt_server.stellartec.com (mail.stellartec.com [65.107.16.99])
	by oss.sgi.com (8.12.5/8.12.5) with SMTP id g66M3dRw028001
	for <linux-mips@oss.sgi.com>; Sat, 6 Jul 2002 15:03:39 -0700
Received: from wssseeger ([192.168.1.53]) by nt_server.stellartec.com
          (Post.Office MTA v3.1.2 release (PO205-101c)
          ID# 568-43562U100L2S100) with SMTP id AAA573;
          Sat, 6 Jul 2002 15:07:48 -0700
Reply-To: <sseeger@stellartec.com>
From: sseeger@stellartec.com (Steven Seeger)
To: <linux-mips@oss.sgi.com>, <linux-mips-kernel@lists.sourceforge.net>
Subject: more on my slab problem
Date: Sat, 6 Jul 2002 15:10:04 -0700
Message-ID: <020001c22539$e23e4310$3501a8c0@wssseeger>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook CWS, Build 9.0.2416 (9.0.2911.0)
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Importance: Normal
X-Spam-Status: No, hits=0.0 required=5.0 tests= version=2.20
X-Spam-Level: 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

The page fault is happening in __wake_up_common() On the 3rd time through
the list_for_each() block, a wait_queue_t *curr = list_entry(tmp,
wait_queue_t, task_list); line returns a curr of 0xFFFFFFF8 and it page
faults on the p = curr->task line because obviously that's a bad address.
(page faults on 0xFFFFFFFC)

I'm sorry to write to both lists but neither has a lot of activity and I'm
hoping somebody on one of the lists could help.

Steve
