Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 18 Jul 2003 18:11:11 +0100 (BST)
Received: from real.realitydiluted.com ([IPv6:::ffff:208.242.241.164]:42149
	"EHLO real.realitydiluted.com") by linux-mips.org with ESMTP
	id <S8225201AbTGRRLJ>; Fri, 18 Jul 2003 18:11:09 +0100
Received: from localhost ([127.0.0.1] helo=realitydiluted.com)
	by real.realitydiluted.com with esmtp (Exim 3.36 #1 (Debian))
	id 19dYl8-0002Yg-00; Fri, 18 Jul 2003 12:11:06 -0500
Message-ID: <3F1829AB.9090303@realitydiluted.com>
Date: Fri, 18 Jul 2003 13:08:59 -0400
From: "Steven J. Hill" <sjhill@realitydiluted.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030714 Debian/1.4-2
X-Accept-Language: en
MIME-Version: 1.0
To: Jack Miller <jack.miller@pioneer-pdt.com>
CC: Linux-Mips <linux-mips@linux-mips.org>
Subject: Re: kernel BUG at sched.c:784!
References: <JCELLCFDJLFKPOBFKGFNGEKJCFAA.jack.miller@pioneer-pdt.com>
In-Reply-To: <JCELLCFDJLFKPOBFKGFNGEKJCFAA.jack.miller@pioneer-pdt.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sjhill@realitydiluted.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2820
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sjhill@realitydiluted.com
Precedence: bulk
X-list: linux-mips

Jack Miller wrote:
>   We are developing a system based around a NEC VR5432 CPU and Broadcom
> BCM703X System Controller. When the system is running with the intended
> application and drivers we intermittently experience a kernel OOPS in the
> scheduler.  Would someone please provide some insight to the following OOPS
> ?  It appears (with my limited understanding of the scheduler) that the
> scheduler is trying to schedule the 'idle' task.  What condition prevails to
> cause this to happen ?
>
Are you using their reference platform 93725 or 93730 or what?

> Linux version 2.4.17 (jack@saturn) (gcc version 3.2.2 20030322 (Pioneer
 >
Before I left Broadcom, I had that kernel at 2.4.18 I believe and the
703x drivers were working fine. Is there some reason you are not using
the Broadcom kernel? I did notice one of the lines had the smartcard
interrupt firing. Those drivers were not exactly supported well. Can
you provide more information on the hardware platform and version of
the drivers? Thanks.

-Steve, ex. Broadcom settop kernel developer
