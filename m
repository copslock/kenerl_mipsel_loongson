Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 24 Feb 2006 19:55:56 +0000 (GMT)
Received: from grayson.netsweng.com ([207.235.77.11]:23496 "EHLO
	grayson.netsweng.com") by ftp.linux-mips.org with ESMTP
	id S8133753AbWBXTzp (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 24 Feb 2006 19:55:45 +0000
Received: from amavis by grayson.netsweng.com with scanned-ok (Exim 3.36 #1 (Debian))
	id 1FCj9e-0000H4-00; Fri, 24 Feb 2006 15:03:06 -0500
Received: from grayson.netsweng.com ([127.0.0.1])
	by localhost (grayson [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 00599-17; Fri, 24 Feb 2006 15:02:57 -0500 (EST)
Received: from dhcp25.palmetohosting.com ([207.235.77.25])
	by grayson.netsweng.com with esmtp (Exim 3.36 #1 (Debian))
	id 1FCj9V-0000Gw-00; Fri, 24 Feb 2006 15:02:57 -0500
Date:	Fri, 24 Feb 2006 15:02:50 -0500 (EST)
From:	Stuart Anderson <anderson@netsweng.com>
X-X-Sender: anderson@localhost
To:	Mark E Mason <mark.e.mason@broadcom.com>
cc:	linux-mips@linux-mips.org
Subject: RE: [RFC] SMP initialization order fixes.
In-Reply-To: <7E000E7F06B05C49BDBB769ADAF44D077D618E@NT-SJCA-0750.brcm.ad.broadcom.com>
Message-ID: <Pine.LNX.4.62.0602241452540.7427@localhost>
References: <7E000E7F06B05C49BDBB769ADAF44D077D618E@NT-SJCA-0750.brcm.ad.broadcom.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
X-Virus-Scanned: by amavisd-new-20030616-p10 (Debian) at netsweng.com
Return-Path: <anderson@netsweng.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10642
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anderson@netsweng.com
Precedence: bulk
X-list: linux-mips

On Fri, 24 Feb 2006, Mark E Mason wrote:

> Hello Stuart,
>
> Um - define "hung"...

Networking stops happening. At this point, processes are still active.
Because I am using NFS root, any process that touches the filesystem
will then hang. It doesn't take too long for enough processes to touch
the FS for the system to be useless. As a test, I put a tmpfs on /tmp,
and ran sash from there. That shell would remain responsive after the
rest of the system was hung waiting on NFS.

                                  Stuart

Stuart R. Anderson                               anderson@netsweng.com
Network & Software Engineering                   http://www.netsweng.com/
1024D/37A79149:                                  0791 D3B8 9A4C 2CDC A31F
                                                   BD03 0A62 E534 37A7 9149
