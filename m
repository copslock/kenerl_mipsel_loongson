Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 16 Jan 2007 20:40:11 +0000 (GMT)
Received: from rgminet01.oracle.com ([148.87.113.118]:14655 "EHLO
	rgminet01.oracle.com") by ftp.linux-mips.org with ESMTP
	id S28581782AbXAPUkF (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 16 Jan 2007 20:40:05 +0000
Received: from rgmsgw02.us.oracle.com (rgmsgw02.us.oracle.com [138.1.186.52])
	by rgminet01.oracle.com (Switch-3.2.4/Switch-3.1.6) with ESMTP id l0GKbEF4026568;
	Tue, 16 Jan 2007 13:37:14 -0700
Received: from ca-server1.us.oracle.com (ca-server1.us.oracle.com [139.185.48.5])
	by rgmsgw02.us.oracle.com (Switch-3.2.4/Switch-3.2.4) with ESMTP id l0GKbB5o020122
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Tue, 16 Jan 2007 13:37:11 -0700
Received: from mfasheh by ca-server1.us.oracle.com with local (Exim 4.63)
	(envelope-from <mark.fasheh@oracle.com>)
	id 1H6v3O-0004Wv-Sh; Tue, 16 Jan 2007 12:37:10 -0800
Date:	Tue, 16 Jan 2007 12:37:10 -0800
From:	Mark Fasheh <mark.fasheh@oracle.com>
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
	lethal@linux-sh.org, linuxsh-shmedia-dev@lists.sourceforge.net,
	ak@suse.de, vojtech@suse.cz, clemens@ladisch.de,
	a.zummo@towertech.it, rtc-linux@googlegroups.com,
	linux-parport@lists.infradead.org, andrea@suse.de,
	tim@cyberelk.net, philb@gnu.org, aharkes@cs.cmu.edu,
	coda@cs.cmu.edu, codalist@TELEMANN.coda.cs.cmu.edu,
	aia21@cantab.net, linux-ntfs-dev@lists.sourceforge.net,
	kurt.hackel@oracle.com
Subject: Re: [PATCH 48/59] sysctl: Register the ocfs2 sysctl numbers
Message-ID: <20070116203710.GB6831@ca-server1.us.oracle.com>
Reply-To: Mark Fasheh <mark.fasheh@oracle.com>
References: <m1ac0jc4no.fsf@ebiederm.dsl.xmission.com> <11689656823041-git-send-email-ebiederm@xmission.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <11689656823041-git-send-email-ebiederm@xmission.com>
Organization: Oracle Corporation
User-Agent: Mutt/1.5.11
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
X-Whitelist: TRUE
Return-Path: <mark.fasheh@oracle.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13678
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mark.fasheh@oracle.com
Precedence: bulk
X-list: linux-mips

On Tue, Jan 16, 2007 at 09:39:53AM -0700, Eric W. Biederman wrote:
> From: Eric W. Biederman <ebiederm@xmission.com> - unquoted
> 
> ocfs2 was did not have the binary number it uses under CTL_FS
> registered in sysctl.h.  Register it to avoid future conflicts,
> and change the name of the definition to be in line with the
> rest of the sysctl numbers.

This looks good - ACK.
	--Mark

--
Mark Fasheh
Senior Software Developer, Oracle
mark.fasheh@oracle.com
