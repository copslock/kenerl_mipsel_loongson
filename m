Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id MAA56161 for <linux-archive@neteng.engr.sgi.com>; Wed, 3 Mar 1999 12:41:39 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id MAA13652
	for linux-list;
	Wed, 3 Mar 1999 12:40:28 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from oz.engr.sgi.com (oz.engr.sgi.com [150.166.42.13])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id MAA24918
	for <linux@engr.sgi.com>;
	Wed, 3 Mar 1999 12:40:26 -0800 (PST)
	mail_from (ariel@oz.engr.sgi.com)
Received: (from ariel@localhost) by oz.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) id MAA09311 for linux@engr.sgi.com; Wed, 3 Mar 1999 12:40:27 -0800 (PST)
From: ariel@oz.engr.sgi.com (Ariel Faigon)
Message-Id: <199903032040.MAA09311@oz.engr.sgi.com>
Subject: Some New? Indy problems (fwd)
To: linux@cthulhu.engr.sgi.com (SGI/Linux mailing list)
Date: Wed, 3 Mar 1999 12:40:26 -0800 (PST)
Reply-To: ariel@cthulhu.engr.sgi.com (Ariel Faigon)
Organization: Silicon Graphics Inc.
X-Mailer: ELM [version 2.4 PL25]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

[Forwarding a bounce,
 apparently not sent from the subscription address. -- Ariel]

Forwarded message:
:Date: Wed, 3 Mar 1999 10:58:30 -0800
:Message-Id: <199903031858.KAA13965@lil.brown-dog.org>
:X-Authentication-Warning: lil.brown-dog.org: jcoffin set sender to jcoffin@lil.brown-dog.org using -f
:To: linux@cthulhu.engr.sgi.com
:Subject: Some New? Indy problems
:
:Hi all, 
:
:I've been periodically trying to get Linux up on an Indy r5000 with
:varying degrees of success.  I machine has a dead video card,
:confirmed by the PROM's hardware verification routines, but I've been
:working via a serial connection which is OK for now.  In the latest
:round of tinkering, I used Thomas Bogendoerfer's binary kernel (Linux
:version 2.1.131 (tsbogend@james.franken.de) (gcc version 2.7.2.3) #262
:Fr9) and got the following.  I hope this helps you all in you quest.
:
:
:--jeff
:
:...
:VFS: Mounted root (nfs filesystem).
:Freeing prom memory: 2608k freed                                         
:Freeing unused kernel memory: 48k freed        
:Got dbe at 0fb7041c.
:$0 : 00000000 0fb83b50 2aaab01c 0000000a
:$4 : 2aaab000 00000000 00000154 00000000
:$8 : 2aaab000 00000010 00000000 00000010
:$12: 7ffffdb0 7ffffdb0 0fb653bc 00000003
:$16: 2aaab000 0fb62b30 0fb62b30 00000000
:$20: 00000000 00000000 00000006 0fb65bb8
:$24: 00000000 0fb703c0
:$28: 0fb8b6d0 7ffffc10 7ffffc40 0fb69e2c
:epc   : 0fb7041c
:Status: 0000fc13
:Cause : 0000401c
:
:and HINV:
:
:>> hinv 
:                   System: IP22
:                Processor: 180 Mhz R5000, with FPU
:     Primary I-cache size: 32 Kbytes
:     Primary D-cache size: 32 Kbytes
:     Secondary cache size: 512 Kbytes
:              Memory size: 64 Mbytes
:                 Graphics: GR3-XZ
:                SCSI Disk: scsi(0)disk(2)
:                SCSI Disk: scsi(0)disk(3)
:                    Audio: Iris Audio Processor: version A2 revision 4.1.0
:>> 
:


-- 
Peace, Ariel
