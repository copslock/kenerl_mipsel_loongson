Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 03 Nov 2005 01:02:43 +0000 (GMT)
Received: from grayson.netsweng.com ([207.235.77.11]:29850 "EHLO
	grayson.netsweng.com") by ftp.linux-mips.org with ESMTP
	id S8133833AbVKCBCX (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 3 Nov 2005 01:02:23 +0000
Received: from amavis by grayson.netsweng.com with scanned-ok (Exim 3.36 #1 (Debian))
	id 1EXTVR-0003ze-00; Wed, 02 Nov 2005 20:03:05 -0500
Received: from grayson.netsweng.com ([127.0.0.1])
	by localhost (grayson [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 14753-05; Wed, 2 Nov 2005 20:02:58 -0500 (EST)
Received: from h168.98.28.71.ip.alltel.net ([71.28.98.168] helo=trantor.stuart.netsweng.com)
	by grayson.netsweng.com with esmtp (Exim 3.36 #1 (Debian))
	id 1EXTVJ-0003zV-00; Wed, 02 Nov 2005 20:02:58 -0500
Date:	Wed, 2 Nov 2005 20:02:56 -0500 (EST)
From:	Stuart Anderson <anderson@netsweng.com>
X-X-Sender: anderson@trantor.stuart.netsweng.com
To:	crossgcc@sources.redhat.com
cc:	MIPS Linux List <linux-mips@linux-mips.org>
Subject: Re: linux kernel building for mips malta target board
In-Reply-To: <43695DB4.7060708@avtrex.com>
Message-ID: <Pine.LNX.4.61.0511022000410.3511@trantor.stuart.netsweng.com>
References: <E1EXLJV-0005R4-K3@real.realitydiluted.com> <43695DB4.7060708@avtrex.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
X-Virus-Scanned: by amavisd-new-20030616-p10 (Debian) at netsweng.com
Return-Path: <anderson@netsweng.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9409
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anderson@netsweng.com
Precedence: bulk
X-list: linux-mips

On Wed, 2 Nov 2005, David Daney wrote:

> Is this the problem you are seeing?:
> In file included from include/linux/nfs_fs.h:15,
>                 from init/do_mounts.c:12:
> include/linux/pagemap.h: In function fault_in_pages_readable:
> include/linux/pagemap.h:236: error: read-only variable __gu_val used as 
> asm output
> include/linux/pagemap.h:236: error: read-only variable __gu_val used as 
> asm output
> include/linux/pagemap.h:236: error: read-only variable __gu_val used as 
> asm output
> include/linux/pagemap.h:236: error: read-only variable __gu_val used as 
> asm output
>
> The compiler behavior has changed since 4.0.1, but I think the new behavior 
> is correct.  I am blaming the __get_user macro in include/asm-mips/uaccess.h. 
> It should be possible to fix it there.  The alternative is to hack up 
> include/linux/pagemap.h.

__get_user() is unhappy, with tpyes that are "const". It uses __typeof()
to create a local variable that it wants to write to. I've intended to
have offer up a patch by now, but, too manyunexpected thing have happened 
in the firs thalf of this week.



                                  Stuart

Stuart R. Anderson                               anderson@netsweng.com
Network & Software Engineering                   http://www.netsweng.com/
1024D/37A79149:                                  0791 D3B8 9A4C 2CDC A31F
                                                   BD03 0A62 E534 37A7 9149
