Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 08 Nov 2004 22:01:07 +0000 (GMT)
Received: from holly.csn.ul.ie ([IPv6:::ffff:136.201.105.4]:44977 "EHLO
	holly.csn.ul.ie") by linux-mips.org with ESMTP id <S8225463AbUKHWBC>;
	Mon, 8 Nov 2004 22:01:02 +0000
Received: from skynet.csn.ul.ie (skynet [136.201.105.2])
	by holly.csn.ul.ie (Postfix) with ESMTP id 4F9ACB615;
	Mon,  8 Nov 2004 22:00:35 +0000 (GMT)
Received: by skynet.csn.ul.ie (Postfix, from userid 2139)
	id 307C1E598; Mon,  8 Nov 2004 22:00:35 +0000 (GMT)
Received: from localhost (localhost [127.0.0.1])
	by skynet.csn.ul.ie (Postfix) with ESMTP id 2215D7288;
	Mon,  8 Nov 2004 22:00:35 +0000 (GMT)
Date: Mon, 8 Nov 2004 22:00:35 +0000 (GMT)
From: Dave Airlie <airlied@csn.ul.ie>
X-X-Sender: airlied@skynet
To: likhit <likhit@cg-coreel.com>
Cc: linux-mips@linux-mips.org
Subject: Re: ATI Radeon 9000 on MIPS platform
In-Reply-To: <156401c4c58a$f2ba7080$9b00a2c0@core>
Message-ID: <Pine.LNX.4.58.0411082158490.28102@skynet>
References: <156401c4c58a$f2ba7080$9b00a2c0@core>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <airlied@csn.ul.ie>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6278
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: airlied@csn.ul.ie
Precedence: bulk
X-list: linux-mips


> Has anybody used ATI Radeon-9000 on MIPS platform?
>
> I m looking for Radeon-9000 device drivers for Linux, any idea of
> availability of open source linux drivers for the same?
>

do you want 3D or just 2D? 2D should work with Xorg or framebuffer stuff,
but 3D mgiht need a bit of work, there are the DRI drivers and they should
work but I've never heard of anyone testing them on mips....

Dave.

-- 
David Airlie, Software Engineer
http://www.skynet.ie/~airlied / airlied at skynet.ie
pam_smb / Linux DECstation / Linux VAX / ILUG person
