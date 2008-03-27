Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 28 Mar 2008 00:10:41 +0100 (CET)
Received: from oss.sgi.com ([192.48.170.157]:27332 "EHLO oss.sgi.com")
	by lappi.linux-mips.net with ESMTP id S527422AbYC0XJQ (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 28 Mar 2008 00:09:16 +0100
Received: from dl5rb.ham-radio-op.net (localhost [127.0.0.1])
	by oss.sgi.com (8.12.11.20060308/8.12.11/SuSE Linux 0.7) with ESMTP id m2RN8aGD025582
	for <linux-mips@linux-mips.org>; Thu, 27 Mar 2008 16:08:37 -0700
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id m2RMWlBQ027298;
	Thu, 27 Mar 2008 22:32:47 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id m2RMWlaE027297;
	Thu, 27 Mar 2008 22:32:47 GMT
Date:	Thu, 27 Mar 2008 22:32:47 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc:	Nico Coesel <ncoesel@DEALogic.nl>, linux-mips@linux-mips.org
Subject: Re: FW: Alchemy power managment code.
Message-ID: <20080327223247.GB26997@linux-mips.org>
References: <19CA9E279FDA5246B7D7A1C91A4AF7F40EF804@dealogicserver.DEALogic.nl> <47EA7A7B.8020602@ru.mvista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <47EA7A7B.8020602@ru.mvista.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Virus-Scanned: ClamAV 0.91.2/6021/Wed Feb 27 15:55:48 2008 on oss.sgi.com
X-Virus-Status:	Clean
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18685
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Mar 26, 2008 at 07:31:55PM +0300, Sergei Shtylyov wrote:

>> Funny you ask because I tried this yesterday on a AU1100 system with the
>> 2.6.24 kernel (from kernel.org). I'm afraid I must say the kernel
>> crashes when I enable power management. The reason I want to use power
>> management is because I need to send the CPU to sleep when the system
>> shuts down. I hacked power.c and reset.c a bit so au_sleep() is called
>> when the system is shut down. Perhaps someone can confirm the
>> powermanagement can be made to work with some fixes (it didn't work with
>> 2.6.21-rc4 either).
>
>    BTW, for anybody interested in Alchemy PM code, here's the interesting
> link: [ftp|http]://ftp.enneenne.com/pub/misc/au1100-patches/linux/.
>    It contains  a lot of unmerged PM patches by Rodolfo Giometti (and not
> only that) from around 2.6.17 time.

Anybody interested in reviewing these patches and polishing them to be
applied to a recent kernel?

  Ralf
