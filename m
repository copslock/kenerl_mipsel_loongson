Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.5/8.12.5) with ESMTP id g679YqRw032148
	for <linux-mips-outgoing@oss.sgi.com>; Sun, 7 Jul 2002 02:34:52 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.5/8.12.3/Submit) id g679YpuH032147
	for linux-mips-outgoing; Sun, 7 Jul 2002 02:34:51 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from laposte.enst-bretagne.fr (laposte.enst-bretagne.fr [192.108.115.3])
	by oss.sgi.com (8.12.5/8.12.5) with SMTP id g679YiRw032138
	for <linux-mips@oss.sgi.com>; Sun, 7 Jul 2002 02:34:45 -0700
Received: from resel.enst-bretagne.fr (UNKNOWN@maisel-gw.enst-bretagne.fr [192.44.76.8])
	by laposte.enst-bretagne.fr (8.11.6/8.11.6) with ESMTP id g679cmC16116;
	Sun, 7 Jul 2002 11:38:53 +0200
Received: from melkor (mail@melkor.maisel.enst-bretagne.fr [172.16.20.65])
	by resel.enst-bretagne.fr (8.12.3/8.12.3/Debian -4) with ESMTP id g679ciTF019002;
	Sun, 7 Jul 2002 11:38:44 +0200
Received: from glaurung (helo=localhost)
	by melkor with local-esmtp (Exim 3.35 #1 (Debian))
	id 17R8V9-0000Bk-00; Sun, 07 Jul 2002 11:38:43 +0200
Date: Sun, 7 Jul 2002 11:38:43 +0200 (CEST)
From: Vivien Chappelier <vivien.chappelier@enst-bretagne.fr>
X-Sender: glaurung@melkor
To: Steven Seeger <sseeger@stellartec.com>
cc: linux-mips@oss.sgi.com
Subject: Re: more on my slab problem
In-Reply-To: <020001c22539$e23e4310$3501a8c0@wssseeger>
Message-ID: <Pine.LNX.4.21.0207071125420.645-100000@melkor>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: by amavisd-milter (http://amavis.org/) at enst-bretagne.fr
X-Spam-Status: No, hits=-4.4 required=5.0 tests=IN_REP_TO version=2.20
X-Spam-Level: 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Sat, 6 Jul 2002, Steven Seeger wrote:

> The page fault is happening in __wake_up_common() On the 3rd time through
> the list_for_each() block, a wait_queue_t *curr = list_entry(tmp,
> wait_queue_t, task_list); line returns a curr of 0xFFFFFFF8 and it page
> faults on the p = curr->task line because obviously that's a bad address.
> (page faults on 0xFFFFFFFC)
> 
> I'm sorry to write to both lists but neither has a lot of activity and I'm
> hoping somebody on one of the lists could help.

Hi,

	I've already encountered a similar problem before, binutils was
producing bad data for the initialization of the waitq. This was with
binutils 2.11.92.0.10.
	I worked around the problem by simply moving 
DECLARE_WAIT_QUEUE_HEAD(kswapd_wait);
	to the beginning of the mm/vmscan.c file, however, you should
consider upgrading your toolchain if you're using the same version of
binutils I used.

references:
http://www.spinics.net/lists/mips/msg09771.html
http://www.spinics.net/lists/mips/msg09210.html

regards,
Vivien Chappelier.
