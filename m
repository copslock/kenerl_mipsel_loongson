Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.5/8.12.5) with ESMTP id g687EURw008064
	for <linux-mips-outgoing@oss.sgi.com>; Mon, 8 Jul 2002 00:14:30 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.5/8.12.3/Submit) id g687ETnP008063
	for linux-mips-outgoing; Mon, 8 Jul 2002 00:14:29 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from pimout4-int.prodigy.net (pimout4-ext.prodigy.net [207.115.63.103])
	by oss.sgi.com (8.12.5/8.12.5) with SMTP id g687EMRw008049
	for <linux-mips@oss.sgi.com>; Mon, 8 Jul 2002 00:14:22 -0700
Received: from Muruga.localdomain (adsl-63-201-59-18.dsl.snfc21.pacbell.net [63.201.59.18])
	by pimout4-int.prodigy.net (8.11.0/8.11.0) with ESMTP id g687IfO31896
	for <linux-mips@oss.sgi.com>; Mon, 8 Jul 2002 03:18:41 -0400
Received: from localhost (muthu@localhost)
	by Muruga.localdomain (8.11.2/8.11.2) with ESMTP id g687CSU29969
	for <linux-mips@oss.sgi.com>; Mon, 8 Jul 2002 00:12:29 -0700
X-Authentication-Warning: Muruga.localdomain: muthu owned process doing -bs
Date: Mon, 8 Jul 2002 00:12:28 -0700 (PDT)
From: Muthukumar Ratty <muthu5@sbcglobal.net>
X-X-Sender: <muthu@Muruga.localdomain>
To: <linux-mips@oss.sgi.com>
Subject: Problem with sizeof?
Message-ID: <Pine.LNX.4.33.0207072331170.29856-100000@Muruga.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Status: No, hits=-0.1 required=5.0 tests=SUBJ_ENDS_IN_Q_MARK version=2.20
X-Spam-Level: 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk



Hi,
In my MIPS system sizeof(struct tc_stats) returns 40 but it returns 36 in
i386 PC.

tc_stats is defined in include/linux/pkt_sched.c as
struct tc_stats
{
        __u64   bytes;                  /* NUmber of enqueues bytes */
        __u32   packets;                /* Number of enqueued packets   */
        __u32   drops;                  /* Packets dropped because of lack
of resources */
        __u32   overlimits;             /* Number of throttle events when
this
					 * flow goes out of allocated
bandwidth*/
        __u32   bps;                    /* Current flow byte rate */
        __u32   pps;                    /* Current flow packet rate */
        __u32   qlen;
        __u32   backlog;
#ifdef __KERNEL__
        spinlock_t *lock;
#endif
};
I printed the offsets of individual fields and they are same in i386 and
MIPS. If the "spinlock_t" is defined then this may be the case but I
am compiling an application, so it shouldnt be there? Right now I
think the problem could be with the "sizeof" operator.
Could someone please let me know if this is the case or I am doing
something wrong. Also any solution.

The versions are
kernel : 2.4.3
gcc    : gcc version 3.1
binutils : 2.11.93
glibc : 2.2.5

Thanks,
Muthu.
