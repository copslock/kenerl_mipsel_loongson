Received:  by oss.sgi.com id <S305156AbQAMSXE>;
	Thu, 13 Jan 2000 10:23:04 -0800
Received: from deliverator.sgi.com ([204.94.214.10]:57176 "EHLO
        deliverator.sgi.com") by oss.sgi.com with ESMTP id <S305154AbQAMSWp>;
	Thu, 13 Jan 2000 10:22:45 -0800
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by deliverator.sgi.com (980309.SGI.8.8.8-aspam-6.2/980310.SGI-aspam) via ESMTP id KAA19033; Thu, 13 Jan 2000 10:19:47 -0800 (PST)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id KAA59353
	for linux-list;
	Thu, 13 Jan 2000 10:10:31 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id KAA39421
	for <linux@cthulhu.engr.sgi.com>;
	Thu, 13 Jan 2000 10:10:29 -0800 (PST)
	mail_from (weave@eng.umd.edu)
Received: from po3.glue.umd.edu (po3.glue.umd.edu [128.8.10.123]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id KAA00745
	for <linux@cthulhu.engr.sgi.com>; Thu, 13 Jan 2000 10:09:49 -0800 (PST)
	mail_from (weave@eng.umd.edu)
Received: from z.glue.umd.edu (root@z.glue.umd.edu [128.8.10.71])
	by po3.glue.umd.edu (8.9.3/8.9.3) with ESMTP id NAA28590
	for <linux@cthulhu.engr.sgi.com>; Thu, 13 Jan 2000 13:09:17 -0500 (EST)
Received: from z.glue.umd.edu (sendmail@localhost [127.0.0.1])
	by z.glue.umd.edu (8.9.3/8.9.3) with SMTP id NAA26316
	for <linux@cthulhu.engr.sgi.com>; Thu, 13 Jan 2000 13:09:16 -0500 (EST)
Received: from localhost (weave@localhost)
	by z.glue.umd.edu (8.9.3/8.9.3) with ESMTP id NAA26312
	for <linux@cthulhu.engr.sgi.com>; Thu, 13 Jan 2000 13:09:16 -0500 (EST)
X-Authentication-Warning: z.glue.umd.edu: weave owned process doing -bs
Date:   Thu, 13 Jan 2000 13:09:16 -0500 (EST)
From:   Vince Weaver <weave@eng.umd.edu>
X-Sender: weave@z.glue.umd.edu
To:     linux@cthulhu.engr.sgi.com
Subject: identifying sgi system type
In-Reply-To: <Pine.GSO.4.21.0001121729110.15153-100000@z.glue.umd.edu>
Message-ID: <Pine.GSO.4.21.0001131258320.25401-100000@z.glue.umd.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing

Hello again

I was trying to see if I could get this Indigo2 to display that it is an
Indigo2 under /proc/cpuinfo [instead of current behavior, which assumes
all SGI's are indy's].

I thought that maybe I could get the PROM to tell me this info, using code
like this

    #include <asm/sgialib.h>

    struct linux_sysid *mree;

    mree=prom_getsysid();
    printk("Vendor: %s     Prod: %s\n",mree->vend,mree->prod);


the vendor is returned as SGI, but the "prod" just returns the serial
number [which seems to be just the last few octets of the MAC address of
the ethernet card].  

Is it possible to figure out what system type it is from this info?  Is
there another way to find out sgi system type?  Or is this just not
possible?

Vince
____________
\  /\  /\  /  Vince Weaver          
 \/__\/__\/   weave@eng.umd.edu     http://www.glue.umd.edu/~weave
