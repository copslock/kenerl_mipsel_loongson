Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fA6Mn6k15935
	for linux-mips-outgoing; Tue, 6 Nov 2001 14:49:06 -0800
Received: from holly.csn.ul.ie (holly.csn.ul.ie [136.201.105.4])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id fA6Mn2015928
	for <linux-mips@oss.sgi.com>; Tue, 6 Nov 2001 14:49:02 -0800
Received: from skynet.csn.ul.ie (skynet [136.201.105.2])
	by holly.csn.ul.ie (Postfix) with ESMTP
	id 51B482B331; Tue,  6 Nov 2001 22:48:55 +0000 (GMT)
Received: by skynet.csn.ul.ie (Postfix, from userid 2139)
	id 695B8C8CA; Tue,  6 Nov 2001 22:48:54 +0000 (GMT)
Received: from localhost (localhost [127.0.0.1])
	by skynet.csn.ul.ie (Postfix) with ESMTP
	id 57150E8C3; Tue,  6 Nov 2001 22:48:54 +0000 (GMT)
Date: Tue, 6 Nov 2001 22:48:54 +0000 (GMT)
From: Dave Airlie <airlied@csn.ul.ie>
X-X-Sender:  <airlied@skynet>
To: <linux-vax@mithra.physics.montana.edu>
Cc: <linux-mips@fnet.fr>, <linux-mips@oss.sgi.com>
Subject: Re: [LV] FYI: Mopd ELF support
In-Reply-To: <Pine.GSO.3.96.1011031131020.10781C-100000@delta.ds2.pg.gda.pl>
Message-ID: <Pine.LNX.4.32.0111062247250.14556-100000@skynet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


>  Since I'll be away till Tuesday, expect an update in the middle of the
> next week.  I'm assuming ELF loading works, right?
>
not sure the VAX is handling this too well..

if I boot the vmlinux ELF file our build system produces it won't boot it
but I think this is due to our vmlinux file being linked for running with
VM switched on, and the mop loads it into memory that doesn't exist..

Dave.

>   Maciej
>
>

-- 
David Airlie, Software Engineer
http://www.skynet.ie/~airlied / airlied@skynet.ie
pam_smb / Linux DecStation / Linux VAX / ILUG person
