Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 16 Jan 2007 20:03:26 +0000 (GMT)
Received: from mx1.redhat.com ([66.187.233.31]:11471 "EHLO mx1.redhat.com")
	by ftp.linux-mips.org with ESMTP id S28771850AbXAPUDV (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 16 Jan 2007 20:03:21 +0000
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.12.11.20060308/8.12.11) with ESMTP id l0GK2epX009674;
	Tue, 16 Jan 2007 15:02:40 -0500
Received: from warthog.cambridge.redhat.com (warthog.cambridge.redhat.com [172.16.18.73])
	by int-mx1.corp.redhat.com (8.13.1/8.13.1) with ESMTP id l0GK2cwE008887;
	Tue, 16 Jan 2007 15:02:39 -0500
Received: from redhat.com (localhost.localdomain [127.0.0.1])
	by warthog.cambridge.redhat.com (8.13.8/8.13.8) with ESMTP id l0GK2LXQ032226;
	Tue, 16 Jan 2007 20:02:22 GMT
From:	David Howells <dhowells@redhat.com>
In-Reply-To: <m1ac0jc4no.fsf@ebiederm.dsl.xmission.com> 
References: <m1ac0jc4no.fsf@ebiederm.dsl.xmission.com> 
To:	ebiederm@xmission.com (Eric W. Biederman)
Cc:	Andrew Morton <akpm@osdl.org>, linux-mips@linux-mips.org,
	linux-parport@lists.infradead.org, heiko.carstens@de.ibm.com,
	ak@suse.de, linuxppc-dev@ozlabs.org, paulus@samba.org,
	aharkes@cs.cmu.edu, schwidefsky@de.ibm.com, tim@cyberelk.net,
	rtc-linux@googlegroups.com, linux-scsi@vger.kernel.org,
	kurt.hackel@oracle.com, coda@cs.cmu.edu, vojtech@suse.cz,
	linuxsh-shmedia-dev@lists.sourceforge.net,
	James.Bottomley@SteelEye.com, clemens@ladisch.de, xfs@oss.sgi.com,
	xfs-masters@oss.sgi.com, andrea@suse.de,
	openipmi-developer@lists.sourceforge.net, linux-390@vm.marist.edu,
	codalist@TELEMANN.coda.cs.cmu.edu, a.zummo@towertech.it,
	tony.luck@intel.com, linux-ntfs-dev@lists.sourceforge.net,
	netdev@vger.kernel.org, aia21@cantab.net,
	linux-kernel@vger.kernel.org, ralf@linux-mips.org,
	lethal@linux-sh.org, Linux Containers <containers@lists.osdl.org>,
	linux390@de.ibm.com, philb@gnu.org
Subject: Re: [PATCH 0/59] Cleanup sysctl 
X-Mailer: MH-E 8.0; nmh 1.1; GNU Emacs 22.0.50
Date:	Tue, 16 Jan 2007 20:02:21 +0000
Message-ID: <32225.1168977741@redhat.com>
Return-Path: <dhowells@redhat.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13677
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dhowells@redhat.com
Precedence: bulk
X-list: linux-mips


The FRV bits look okay.  I can't test them until I get back from Australia in
Feb.

David
