Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 16 Jan 2007 22:08:43 +0000 (GMT)
Received: from smtp.ocgnet.org ([64.20.243.3]:28642 "EHLO smtp.ocgnet.org")
	by ftp.linux-mips.org with ESMTP id S28581964AbXAPWIi (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 16 Jan 2007 22:08:38 +0000
Received: from smtp.ocgnet.org (localhost [127.0.0.1])
	by smtp.ocgnet.org (Postfix) with ESMTP id 2B6075203FE;
	Tue, 16 Jan 2007 16:08:35 -0600 (CST)
Received: from master.linux-sh.org (124x34x33x190.ap124.ftth.ucom.ne.jp [124.34.33.190])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.ocgnet.org (Postfix) with ESMTP id 09CBC5203E0;
	Tue, 16 Jan 2007 16:08:34 -0600 (CST)
Received: from localhost (unknown [127.0.0.1])
	by master.linux-sh.org (Postfix) with ESMTP id E0A9164C7A;
	Tue, 16 Jan 2007 22:07:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at linux-sh.org
Received: from master.linux-sh.org ([127.0.0.1])
	by localhost (master.linux-sh.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id XJlX94V1oSl6; Wed, 17 Jan 2007 07:07:09 +0900 (JST)
Received: by master.linux-sh.org (Postfix, from userid 500)
	id 075F764C7C; Wed, 17 Jan 2007 07:07:09 +0900 (JST)
Date:	Wed, 17 Jan 2007 07:07:08 +0900
From:	Paul Mundt <lethal@linux-sh.org>
To:	"Eric W. Biederman" <ebiederm@xmission.com>
Cc:	"<Andrew Morton" <akpm@osdl.org>, linux-kernel@vger.kernel.org,
	containers@lists.osdl.org, netdev@vger.kernel.org,
	xfs-masters@oss.sgi.com, xfs@oss.sgi.com,
	linux-scsi@vger.kernel.org, James.Bottomley@SteelEye.com,
	minyard@acm.org, openipmi-developer@lists.sourceforge.net,
	tony.luck@intel.com, linux-mips@linux-mips.org,
	ralf@linux-mips.org, schwidefsky@de.ibm.com,
	heiko.carstens@de.ibm.com, linux390@de.ibm.com,
	linux-390@vm.marist.edu, paulus@samba.org, linuxppc-dev@ozlabs.org,
	linuxsh-shmedia-dev@lists.sourceforge.net, ak@suse.de,
	vojtech@suse.cz, clemens@ladisch.de, a.zummo@towertech.it,
	rtc-linux@googlegroups.com, linux-parport@lists.infradead.org,
	andrea@suse.de, tim@cyberelk.net, philb@gnu.org,
	aharkes@cs.cmu.edu, coda@cs.cmu.edu,
	codalist@TELEMANN.coda.cs.cmu.edu, aia21@cantab.net,
	linux-ntfs-dev@lists.sourceforge.net, mark.fasheh@oracle.com,
	kurt.hackel@oracle.com
Subject: Re: [PATCH 37/59] sysctl: C99 convert arch/sh64/kernel/traps.c and remove ABI breakage.
Message-ID: <20070116220708.GA10821@linux-sh.org>
Mail-Followup-To: Paul Mundt <lethal@linux-sh.org>,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	"<Andrew Morton" <akpm@osdl.org>, linux-kernel@vger.kernel.org,
	containers@lists.osdl.org, netdev@vger.kernel.org,
	xfs-masters@oss.sgi.com, xfs@oss.sgi.com,
	linux-scsi@vger.kernel.org, James.Bottomley@SteelEye.com,
	minyard@acm.org, openipmi-developer@lists.sourceforge.net,
	tony.luck@intel.com, linux-mips@linux-mips.org, ralf@linux-mips.org,
	schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com,
	linux390@de.ibm.com, linux-390@vm.marist.edu, paulus@samba.org,
	linuxppc-dev@ozlabs.org, linuxsh-shmedia-dev@lists.sourceforge.net,
	ak@suse.de, vojtech@suse.cz, clemens@ladisch.de,
	a.zummo@towertech.it, rtc-linux@googlegroups.com,
	linux-parport@lists.infradead.org, andrea@suse.de, tim@cyberelk.net,
	philb@gnu.org, aharkes@cs.cmu.edu, coda@cs.cmu.edu,
	codalist@TELEMANN.coda.cs.cmu.edu, aia21@cantab.net,
	linux-ntfs-dev@lists.sourceforge.net, mark.fasheh@oracle.com,
	kurt.hackel@oracle.com
References: <m1ac0jc4no.fsf@ebiederm.dsl.xmission.com> <11689656622749-git-send-email-ebiederm@xmission.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <11689656622749-git-send-email-ebiederm@xmission.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-Virus-Scanned: ClamAV using ClamSMTP
Return-Path: <lethal@linux-sh.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13679
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: lethal@linux-sh.org
Precedence: bulk
X-list: linux-mips

On Tue, Jan 16, 2007 at 09:39:42AM -0700, Eric W. Biederman wrote:
> From: Eric W. Biederman <ebiederm@xmission.com> - unquoted
> 
> While doing the C99 conversion I notices that the top level sh64
> directory was using the binary number for CTL_KERN.  That is a
> no-no so I removed the support for the sysctl binary interface
> only leaving sysctl /proc support.
> 
> At least the sysctl tables were placed at the end of
> the list so user space did not see this mistake.
> 
> Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>

Looks good, thanks Eric.

Acked-by: Paul Mundt <lethal@linux-sh.org>
