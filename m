Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 16 Jan 2007 18:20:27 +0000 (GMT)
Received: from hancock.steeleye.com ([71.30.118.248]:15819 "EHLO
	hancock.sc.steeleye.com") by ftp.linux-mips.org with ESMTP
	id S28581140AbXAPSUW (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 16 Jan 2007 18:20:22 +0000
Received: from midgard.sc.steeleye.com (midgard.sc.steeleye.com [172.17.6.40])
	by hancock.sc.steeleye.com (8.11.6/8.11.6) with ESMTP id l0GIJZx27292;
	Tue, 16 Jan 2007 13:19:35 -0500
Subject: Re: [PATCH 20/59] sysctl: cdrom Don't set de->owner
From:	James Bottomley <James.Bottomley@SteelEye.com>
To:	"Eric W. Biederman" <ebiederm@xmission.com>
Cc:	"<Andrew Morton" <akpm@osdl.org>, linux-kernel@vger.kernel.org,
	containers@lists.osdl.org, netdev@vger.kernel.org,
	xfs-masters@oss.sgi.com, xfs@oss.sgi.com,
	linux-scsi@vger.kernel.org, minyard@acm.org,
	openipmi-developer@lists.sourceforge.net, tony.luck@intel.com,
	linux-mips@linux-mips.org, ralf@linux-mips.org,
	schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com,
	linux390@de.ibm.com, linux-390@vm.marist.edu, paulus@samba.org,
	linuxppc-dev@ozlabs.org, lethal@linux-sh.org,
	linuxsh-shmedia-dev@lists.sourceforge.net, ak@suse.de,
	vojtech@suse.cz, clemens@ladisch.de, a.zummo@towertech.it,
	rtc-linux@googlegroups.com, linux-parport@lists.infradead.org,
	andrea@suse.de, tim@cyberelk.net, philb@gnu.org,
	aharkes@cs.cmu.edu, coda@cs.cmu.edu,
	codalist@TELEMANN.coda.cs.cmu.edu, aia21@cantab.net,
	linux-ntfs-dev@lists.sourceforge.net, mark.fasheh@oracle.com,
	kurt.hackel@oracle.com
In-Reply-To: <11689656373737-git-send-email-ebiederm@xmission.com>
References: <m1ac0jc4no.fsf@ebiederm.dsl.xmission.com>
	 <11689656373737-git-send-email-ebiederm@xmission.com>
Content-Type: text/plain
Date:	Tue, 16 Jan 2007 12:19:34 -0600
Message-Id: <1168971574.2789.14.camel@mulgrave.il.steeleye.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 (2.6.3-1.fc5.5) 
Content-Transfer-Encoding: 7bit
Return-Path: <James.Bottomley@SteelEye.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13675
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: James.Bottomley@SteelEye.com
Precedence: bulk
X-list: linux-mips

On Tue, 2007-01-16 at 09:39 -0700, Eric W. Biederman wrote:
> From: Eric W. Biederman <ebiederm@xmission.com> - unquoted

These three look OK:

[PATCH 15/59] sysctl: scsi remove unnecessary insert_at_head flag
[PATCH 19/59] sysctl: cdrom remove unnecessary insert_at_head flag
[PATCH 20/59] sysctl: cdrom Don't set de->owner

So you can add an ACK from me.

It would have been nice not to have 56 other irrelevant patches sprayed
over the list and into my inbox, though ...

James
