Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f6KMFBo00666
	for linux-mips-outgoing; Fri, 20 Jul 2001 15:15:11 -0700
Received: from earth.ayrnetworks.com ([64.166.72.139])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f6KMFBV00663
	for <linux-mips@oss.sgi.com>; Fri, 20 Jul 2001 15:15:11 -0700
Received: from [10.21.56.226] (earth.ayrnetworks.com [10.1.1.24])
	by earth.ayrnetworks.com (8.11.0/8.8.7) with ESMTP id f6KMDZr02116
	for <linux-mips@oss.sgi.com>; Fri, 20 Jul 2001 15:13:35 -0700
User-Agent: Microsoft-Entourage/9.0.2509
Date: Fri, 20 Jul 2001 16:15:28 -0600
Subject: SHN_MIPS_SCOMMON
From: Greg Satz <satz@ayrnetworks.com>
To: <linux-mips@oss.sgi.com>
Message-ID: <B77E099F.87B7%satz@ayrnetworks.com>
Mime-version: 1.0
Content-type: text/plain; charset="US-ASCII"
Content-transfer-encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

When making modules for the 2.4.2 kernel, gcc and friends will generate
SHN_MIPS_SCOMMON ELF segments (0xff03). Unfortunately insmod (obj_reloc.c)
doesn't know how to relocate these symbols and the module page faults at
location 4 upon initialization.

Is this a bug in obj_reloc.c not handling SHN_MIPS_SCOMMON like SHN_COMMON
or should everyone who makes mips kernel modules be using the -fno-common
gcc flag?

Thanks,
Greg
