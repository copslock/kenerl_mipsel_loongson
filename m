Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 01 Oct 2002 10:50:20 +0200 (CEST)
Received: from h24-83-212-10.vc.shawcable.net ([24.83.212.10]:12795 "EHLO
	bard.illuminatus.org") by linux-mips.org with ESMTP
	id <S1122978AbSJAIuU>; Tue, 1 Oct 2002 10:50:20 +0200
Received: from templar ([10.0.0.2])
	by bard.illuminatus.org with esmtp (Exim 3.35 #1 (Debian))
	id 17wHww-0003ik-00
	for <linux-mips@linux-mips.org>; Tue, 01 Oct 2002 01:00:10 -0700
Subject: scatterlist.h
From: Mike Nugent <mips@illuminatus.org>
To: linux-mips@linux-mips.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 01 Oct 2002 01:48:38 -0700
Message-Id: <1033462118.13267.97.camel@templar>
Mime-Version: 1.0
Return-Path: <mips@illuminatus.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 318
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mips@illuminatus.org
Precedence: bulk
X-list: linux-mips


Next problem  ( I know you all love my by now :)

in drivers/scsi/scsi_merge.c

scsi_merge.c:939: structure has no member named `page'

line 939: sgpnt[count - 1].page = NULL;

(struct scatterlist *sgpnt;  included from scsi.h, which includes
asm/scatterlist.h)


struct scatterlist {
    char *  address;    /* Location data is to be transferred to */
    unsigned int length;

    __u32 dvma_address;
};

Yes!  It's right!  No member page!

From 2.4.16:

struct scatterlist {
	char * address;		/* Location data is to be transferred to */
	struct page * page;	/* Location for highmem page, if any */
	unsigned int length;
	__u32 dvma_address;
};

I suggest we put that variable back into the structure.

There's more to come, but it's almost 2 am and it's bedtime.  I'll send
the next one out tomorrow if no one writes me back to tell me I'm
nuts/not using the right code/can't reproduce the error/etc.


-- 
Mike Nugent
Programmer/Author
mike@illuminatus.org
"I believe the use of noise to make music will increase until we reach a
music produced through the aid of electrical instruments which will make
available for musical purposes any and all sounds that can be heard."
 -- composer John Cage, 1937
