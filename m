Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 30 May 2008 01:23:59 +0100 (BST)
Received: from p549F5155.dip.t-dialin.net ([84.159.81.85]:7119 "EHLO
	p549F5155.dip.t-dialin.net") by ftp.linux-mips.org with ESMTP
	id S20046725AbYE2MQu (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 29 May 2008 13:16:50 +0100
Received: from mx03.syneticon.net ([87.79.32.166]:58888 "EHLO
	mx03.syneticon.net") by lappi.linux-mips.net with ESMTP
	id S1106173AbYE2MQp (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 29 May 2008 14:16:45 +0200
Received: from localhost (filter1.syneticon.net [192.168.113.3])
	by mx03.syneticon.net (Postfix) with ESMTP id 2875D95EF;
	Thu, 29 May 2008 14:16:42 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mx03.syneticon.net
Received: from mx03.syneticon.net ([192.168.113.4])
	by localhost (mx03.syneticon.net [192.168.113.3]) (amavisd-new, port 10025)
	with ESMTP id ECqQPbG3cJsu; Thu, 29 May 2008 14:16:24 +0200 (CEST)
Received: from [192.168.10.145] (koln-4d0b776d.pool.mediaWays.net [77.11.119.109])
	by mx03.syneticon.net (Postfix) with ESMTP;
	Thu, 29 May 2008 14:16:24 +0200 (CEST)
Message-ID: <483E9E97.6050207@wpkg.org>
Date:	Thu, 29 May 2008 14:16:23 +0200
From:	Tomasz Chmielewski <mangoo@wpkg.org>
User-Agent: Thunderbird 2.0.0.12 (X11/20080305)
MIME-Version: 1.0
To:	Nicolas Schichan <nschichan@freebox.fr>
CC:	linux-mips@linux-mips.org,
	Kexec Mailing List <kexec@lists.infradead.org>
Subject: Re: kexec on mips - anyone has it working?
References: <483BCB75.4050901@wpkg.org> <200805271449.45124.nschichan@freebox.fr> <483C4F73.4040909@wpkg.org> <200805291347.05196.nschichan@freebox.fr>
In-Reply-To: <200805291347.05196.nschichan@freebox.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <mangoo@wpkg.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19378
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mangoo@wpkg.org
Precedence: bulk
X-list: linux-mips

Nicolas Schichan schrieb:
> On Tuesday 27 May 2008 20:14:11 you wrote:
>> Aah, I see.
>>
>> Anyway, it doesn't work - with or without this slight change in
>> machine_kexec.c, with kexec compiled from the sources in the link you
>> gave or with kexec-tools-testing-20080324, it just doesn't work on
>> BCM43XX with OpenWRT patches. At least on Asus WL-500gP.
> 
> I'm not familiar with broadcom CPU names, but isn't BCM43XX supposed
> to be a Wifi chipset ? :)

Well, yeah, indeed the device is sold as a wireless router. But it can 
perfectly run Debian, so it should run kexec as well, shouldn't it? ;)


> However,  could   you  kexec   a  kernel  from   a  kernel   that  has
> CONFIG_MIPS_UNCACHED  set (under  "Kernel  hacking", "run  uncached")?
> this will slow down the kernel that does the kexec, but if this works,
> then it is most probably a cache problem.
> 
> Could you also indicate the last lines of kernel messages just before
> the "Bye." ?

I'll try that later today and will post the results.


> Are you trying to kexec a big kernel image ?

Hmm, is it big? It's the same kernel I booted:

# ls -l vmlinux
-rwxr-xr-x 1 root root 3868065 May 26 23:30 vmlinux


> how much RAM do you have
> on the board ?

It has 32 MB RAM; some ~11 MB is used before I load another kernel.


> are there some hardware that could have a hard time to
> be re-probed by the kexeced linux kernel ?

The kexeced kernel is the same one I booted, so no.


-- 
Tomasz Chmielewski
http://wpkg.org
