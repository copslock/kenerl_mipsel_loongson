Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 17 Jan 2007 18:00:57 +0000 (GMT)
Received: from mailhub.sw.ru ([195.214.233.200]:24730 "EHLO relay.sw.ru")
	by ftp.linux-mips.org with ESMTP id S20042566AbXAQSAx (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 17 Jan 2007 18:00:53 +0000
Received: from [192.168.1.129] ([192.168.1.129])
	by relay.sw.ru (8.13.4/8.13.4) with ESMTP id l0HI1K8t026726;
	Wed, 17 Jan 2007 21:01:21 +0300 (MSK)
Message-ID: <45AE66AA.1050508@sw.ru>
Date:	Wed, 17 Jan 2007 21:10:50 +0300
From:	Kirill Korotaev <dev@sw.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.13) Gecko/20060417
X-Accept-Language: en-us, en, ru
MIME-Version: 1.0
To:	"Eric W. Biederman" <ebiederm@xmission.com>
CC:	Andrew Morton <akpm@osdl.org>, James.Bottomley@SteelEye.com,
	linux-mips@linux-mips.org, linux-parport@lists.infradead.org,
	minyard@acm.org, rtc-linux@googlegroups.com, clemens@ladisch.de,
	heiko.carstens@de.ibm.com, xfs@oss.sgi.com,
	linuxppc-dev@ozlabs.org, paulus@samba.org,
	openipmi-developer@lists.sourceforge.net, linux-390@vm.marist.edu,
	schwidefsky@de.ibm.com, tim@cyberelk.net,
	codalist@TELEMANN.coda.cs.cmu.edu, a.zummo@towertech.it,
	tony.luck@intel.com, vojtech@suse.cz, linux-scsi@vger.kernel.org,
	xfs-masters@oss.sgi.com, linux-ntfs-dev@lists.sourceforge.net,
	netdev@vger.kernel.org, aia21@cantab.net, aharkes@cs.cmu.edu,
	linux-kernel@vger.kernel.org, ralf@linux-mips.org,
	mark.fasheh@oracle.com, coda@cs.cmu.edu, lethal@linux-sh.org,
	kurt.hackel@oracle.com,
	Linux Containers <containers@lists.osdl.org>,
	linux390@de.ibm.com, philb@gnu.org, andrea@suse.de,
	linuxsh-shmedia-dev@lists.sourceforge.net, ak@suse.de
Subject: Re: [PATCH 0/59] Cleanup sysctl
References: <m1ac0jc4no.fsf@ebiederm.dsl.xmission.com>
In-Reply-To: <m1ac0jc4no.fsf@ebiederm.dsl.xmission.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <dev@sw.ru>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13694
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dev@sw.ru
Precedence: bulk
X-list: linux-mips

Eric, really good job!

Patches: 1-13, 15-24, 26-32, 34-44, 46-49, 52-55, 57 (all except below)
Acked-By: Kirill Korotaev <dev@openvz.org>

14/59 - minor (extra space)
25/59 - minor note	
33/59 - not sorted sysctl IDs
45/59 - typo
50/59 - copyright/file note
51/59 - copyright/file name/kconfig option notes

56,58,59/59 - will review tomorrow

another issue I have to think over is removal of de->owner.
Alexey Dobriyan has sent recently patching fixing /proc <-> modules refcounting.
I guess w/o these patches your changes are not safe if proc_handler or strategy
are functions from the module.

Thanks,
Kirill

> There has not been much maintenance on sysctl in years, and as a result is
> there is a lot to do to allow future interesting work to happen, and being
> ambitious I'm trying to do it all at once :)
> 
> The patches in this series fall into several general categories.
> 
> - Removal of useless attempts to override the standard sysctls
> 
> - Registers of sysctl numbers in sysctl.h so someone else does not use
>   the magic number and conflict.
> 
> - C99 conversions so it becomes possible to change the layout of 
>   struct ctl_table without breaking everything.
> 
> - Removal of useless claims of module ownership, in the proc dir entries
> 
> - Removal of sys_sysctl support where people had used conflicting sysctl
>   numbers. Trying to break glibc or other applications by changing the
>   ABI is not cool.  9 instances of this in the kernel seems a little
>   extreme.
> 
> - General enhancements when I got the junk I could see out.
> 
> Odds are I missed something, most of the cleanups are simply a result of
> me working on the sysctl core and glancing at the users and going: What?
> 
> Eric
> _______________________________________________
> Containers mailing list
> Containers@lists.osdl.org
> https://lists.osdl.org/mailman/listinfo/containers
> 
> 
