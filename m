Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 17 Jan 2007 17:04:49 +0000 (GMT)
Received: from mailhub.sw.ru ([195.214.233.200]:22571 "EHLO relay.sw.ru")
	by ftp.linux-mips.org with ESMTP id S20042496AbXAQREp (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 17 Jan 2007 17:04:45 +0000
Received: from [192.168.1.129] ([192.168.1.129])
	by relay.sw.ru (8.13.4/8.13.4) with ESMTP id l0HH4nf2002966;
	Wed, 17 Jan 2007 20:04:50 +0300 (MSK)
Message-ID: <45AE5969.8030603@sw.ru>
Date:	Wed, 17 Jan 2007 20:14:17 +0300
From:	Kirill Korotaev <dev@sw.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.13) Gecko/20060417
X-Accept-Language: en-us, en, ru
MIME-Version: 1.0
To:	"Eric W. Biederman" <ebiederm@xmission.com>
CC:	"<Andrew Morton" <akpm@osdl.org>, James.Bottomley@SteelEye.com,
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
	kurt.hackel@oracle.com, containers@lists.osdl.org,
	linux390@de.ibm.com, philb@gnu.org, andrea@suse.de,
	linuxsh-shmedia-dev@lists.sourceforge.net, ak@suse.de
Subject: Re: [PATCH 25/59] sysctl: C99 convert arch/frv/kernel/pm.c
References: <m1ac0jc4no.fsf@ebiederm.dsl.xmission.com> <11689656443582-git-send-email-ebiederm@xmission.com>
In-Reply-To: <11689656443582-git-send-email-ebiederm@xmission.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <dev@sw.ru>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13690
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dev@sw.ru
Precedence: bulk
X-list: linux-mips

another small minor note.

> From: Eric W. Biederman <ebiederm@xmission.com> - unquoted
> 
> Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
> ---
>  arch/frv/kernel/pm.c |   50 +++++++++++++++++++++++++++++++++++++++++++-------
>  1 files changed, 43 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/frv/kernel/pm.c b/arch/frv/kernel/pm.c
> index c1840d6..aa50333 100644
> --- a/arch/frv/kernel/pm.c
> +++ b/arch/frv/kernel/pm.c
> @@ -401,17 +401,53 @@ static int cm_sysctl(ctl_table *table, int __user *name, int nlen,
>  
>  static struct ctl_table pm_table[] =
>  {
> -	{CTL_PM_SUSPEND, "suspend", NULL, 0, 0200, NULL, &sysctl_pm_do_suspend},
> -	{CTL_PM_CMODE, "cmode", &clock_cmode_current, sizeof(int), 0644, NULL, &cmode_procctl, &cmode_sysctl, NULL},
> -	{CTL_PM_P0, "p0", &clock_p0_current, sizeof(int), 0644, NULL, &p0_procctl, &p0_sysctl, NULL},
> -	{CTL_PM_CM, "cm", &clock_cm_current, sizeof(int), 0644, NULL, &cm_procctl, &cm_sysctl, NULL},
> -	{0}
> +	{
> +		.ctl_name	= CTL_PM_SUSPEND,
> +		.procname	= "suspend",
> +		.data		= NULL,
> +		.maxlen		= 0,
> +		.mode		= 0200,
> +		.proc_handler	= &sysctl_pm_do_suspend,
> +	},
> +	{
> +		.ctl_name	= CTL_PM_CMODE,
> +		.procname	= "cmode",
> +		.data		= &clock_cmode_current,
> +		.maxlen		= sizeof(int),
> +		.mode		= 0644,
> +		.proc_handler	= &cmode_procctl,
> +		.strategy	= &cmode_sysctl,
> +	},
> +	{
> +		.ctl_name	= CTL_PM_P0,
> +		.procname	= "p0",
> +		.data		= &clock_p0_current,
> +		.maxlen		= sizeof(int),
> +		.mode		= 0644,
> +		.proc_handler	= &p0_procctl,
> +		.strategy	= &p0_sysctl,
> +	},
> +	{
> +		.ctl_name	= CTL_PM_CM,
> +		.procname	= "cm",
> +		.data		= &clock_cm_current,
> +		.maxlen		= sizeof(int),
> +		.mode		= 0644,
> +		.proc_handler	= &cm_procctl,
> +		.strategy	= &cm_sysctl,
> +	},
> +	{ .ctl_name = 0}
in next patch (26/59) you write just "{ }". .ctl_name = 0 not required here.


>  };
>  
>  static struct ctl_table pm_dir_table[] =
>  {
> -	{CTL_PM, "pm", NULL, 0, 0555, pm_table},
> -	{0}
> +	{
> +		.ctl_name	= CTL_PM,
> +		.procname	= "pm",
> +		.mode		= 0555,
> +		.child		= pm_table,
> +	},
> +	{ .ctl_name = 0}
>  };
>  
>  /*
