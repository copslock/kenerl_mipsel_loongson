Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 16 Jan 2007 17:08:55 +0000 (GMT)
Received: from terminus.zytor.com ([192.83.249.54]:49115 "EHLO
	terminus.zytor.com") by ftp.linux-mips.org with ESMTP
	id S20046822AbXAPQ7q (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 16 Jan 2007 16:59:46 +0000
Received: from [172.27.0.16] (c-67-180-238-27.hsd1.ca.comcast.net [67.180.238.27])
	(authenticated bits=0)
	by terminus.zytor.com (8.13.8/8.13.7) with ESMTP id l0GGrJBu000984
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 16 Jan 2007 08:53:20 -0800
Message-ID: <45AD02FF.605@zytor.com>
Date:	Tue, 16 Jan 2007 08:53:19 -0800
From:	"H. Peter Anvin" <hpa@zytor.com>
User-Agent: Thunderbird 1.5.0.9 (X11/20061219)
MIME-Version: 1.0
To:	"Eric W. Biederman" <ebiederm@xmission.com>
CC:	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
	Linux Containers <containers@lists.osdl.org>,
	netdev@vger.kernel.org, xfs-masters@oss.sgi.com, xfs@oss.sgi.com,
	linux-scsi@vger.kernel.org, James.Bottomley@SteelEye.com,
	minyard@acm.org, openipmi-developer@lists.sourceforge.net,
	tony.luck@intel.com, linux-mips@linux-mips.org,
	ralf@linux-mips.org, schwidefsky@de.ibm.com,
	heiko.carstens@de.ibm.com, linux390@de.ibm.com,
	linux-390@vm.marist.edu, paulus@samba.org, linuxppc-dev@ozlabs.org,
	lethal@linux-sh.org, linuxsh-shmedia-dev@lists.sourceforge.net,
	ak@suse.de, vojtech@suse.cz, clemens@ladisch.de,
	a.zummo@towertech.it, rtc-linux@googlegroups.com,
	linux-parport@lists.infradead.org, andrea@suse.de,
	tim@cyberelk.net, philb@gnu.org, aharkes@cs.cmu.edu,
	coda@cs.cmu.edu, codalist@TELEMANN.coda.cs.cmu.edu,
	aia21@cantab.net, linux-ntfs-dev@lists.sourceforge.net,
	mark.fasheh@oracle.com, kurt.hackel@oracle.com
Subject: Re: [PATCH 0/59] Cleanup sysctl
References: <m1ac0jc4no.fsf@ebiederm.dsl.xmission.com>
In-Reply-To: <m1ac0jc4no.fsf@ebiederm.dsl.xmission.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: ClamAV 0.88.7/2457/Tue Jan 16 03:53:04 2007 on terminus.zytor.com
X-Virus-Status:	Clean
Return-Path: <hpa@zytor.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13673
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hpa@zytor.com
Precedence: bulk
X-list: linux-mips

Eric W. Biederman wrote:
> 
> - Removal of sys_sysctl support where people had used conflicting sysctl
>   numbers. Trying to break glibc or other applications by changing the
>   ABI is not cool.  9 instances of this in the kernel seems a little
>   extreme.
> 

It would be highly advantageous if we could have a file that acts as a 
central registry of architectural sysctl numbers *and have the numbers 
in the kernel derived from there*.  As I've said before, I don't really 
think sys_sysctl is any worse than ad hoc system calls (sys_mips and the 
like), but the real problem is that there are architectural and 
non-archtectural numbers, and they're mixed in all over the place.

I think it would be fair to say that if they're not in <linux/sysctl.h> 
they're not architectural, but that doesn't resolve the counterpositive 
(are there sysctls in <linux/sysctl.h> which aren't architectural?  From 
the looks of it, I would say yes.)  Non-architectural sysctl numbers 
should not be exported to userspace, and should eventually be rejected 
by sys_sysctl.

	-hpa
