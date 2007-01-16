Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 16 Jan 2007 23:36:28 +0000 (GMT)
Received: from smtprelay01.ispgateway.de ([80.67.18.13]:12424 "EHLO
	smtprelay01.ispgateway.de") by ftp.linux-mips.org with ESMTP
	id S20052741AbXAPXgX (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 16 Jan 2007 23:36:23 +0000
Received: (qmail 24212 invoked from network); 16 Jan 2007 23:36:22 -0000
Received: from unknown (HELO p5483d117.dip.t-dialin.net) (696817@[84.131.209.23])
          (envelope-sender <ioe-lkml@rameria.de>)
          by smtprelay01.ispgateway.de (qmail-ldap-1.03) with AES256-SHA encrypted SMTP
          for <ebiederm@xmission.com>; 16 Jan 2007 23:36:22 -0000
From:	Ingo Oeser <ioe-lkml@rameria.de>
To:	"Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: [PATCH 31/59] sysctl: C99 convert the ctl_tables in arch/mips/au1000/common/power.c
Date:	Tue, 16 Jan 2007 23:20:17 +0100
User-Agent: KMail/1.9.5
Cc:	"<Andrew Morton" <akpm@osdl.org>, linux-kernel@vger.kernel.org,
	containers@lists.osdl.org, netdev@vger.kernel.org,
	xfs-masters@oss.sgi.com, xfs@oss.sgi.com,
	linux-scsi@vger.kernel.org, James.Bottomley@steeleye.com,
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
	coda@cs.cmu.edu, codalist@telemann.coda.cs.cmu.edu,
	aia21@cantab.net, linux-ntfs-dev@lists.sourceforge.net,
	mark.fasheh@oracle.com, kurt.hackel@oracle.com
References: <m1ac0jc4no.fsf@ebiederm.dsl.xmission.com> <11689656551180-git-send-email-ebiederm@xmission.com>
In-Reply-To: <11689656551180-git-send-email-ebiederm@xmission.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200701162320.27961.ioe-lkml@rameria.de>
Return-Path: <ioe-lkml@rameria.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13681
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ioe-lkml@rameria.de
Precedence: bulk
X-list: linux-mips

Hi Eric,

On Tuesday, 16. January 2007 17:39, Eric W. Biederman wrote:
> diff --git a/arch/mips/au1000/common/power.c b/arch/mips/au1000/common/power.c
> index b531ab7..31256b8 100644
> --- a/arch/mips/au1000/common/power.c
> +++ b/arch/mips/au1000/common/power.c
> @@ -419,15 +419,41 @@ static int pm_do_freq(ctl_table * ctl, int write, struct file *file,

> +	{
> +		.ctl_name 	= CTL_UNNUMBERED,
> +		.procname	= "suspend",
> +		.data		= NULL,
> +		.maxlen		= 0,
> +		.mode		= 0600,
> +		.proc_handler	= &pm_do_suspend
> +	},

No need for zero initialization for maxlen.

> +	{
> +		.ctl_name	= CTL_UNNUMBERED,
> +		.procname	= "sleep",
> +		.data		= NULL,
> +		.maxlen		= 0,
> +		.mode		= 0600,
> +		.proc_handler	= &pm_do_sleep
> +	},

dito

> +	{
> +		.ctl_name	= CTL_UNNUMBERED,
> +		.procname	= "freq",
> +		.data		= NULL,
> +		.maxlen		= 0,
> +		.mode		= 0600,
> +		.proc_handler	= &pm_do_freq
> +	},
> +	{}
>  };

dito

Regards

Ingo Oeser
