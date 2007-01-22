Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 22 Jan 2007 22:21:26 +0000 (GMT)
Received: from MAIL.13thfloor.at ([213.145.232.33]:25785 "EHLO
	MAIL.13thfloor.at") by ftp.linux-mips.org with ESMTP
	id S28582424AbXAVWVT (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 22 Jan 2007 22:21:19 +0000
Received: by mail.13thfloor.at (Postfix, from userid 1001)
	id B2FB5707B2; Mon, 22 Jan 2007 23:21:15 +0100 (CET)
Date:	Mon, 22 Jan 2007 23:21:15 +0100
From:	Herbert Poetzl <herbert@13thfloor.at>
To:	Kirill Korotaev <dev@sw.ru>
Cc:	"Eric W. Biederman" <ebiederm@xmission.com>,
	James.Bottomley@SteelEye.com, linux-parport@lists.infradead.org,
	rtc-linux@googlegroups.com, linux-mips@linux-mips.org,
	heiko.carstens@de.ibm.com, containers@lists.osdl.org,
	lethal@linux-sh.org, clemens@ladisch.de, xfs@oss.sgi.com,
	xfs-masters@oss.sgi.com, paulus@samba.org, linux390@de.ibm.com,
	openipmi-developer@lists.sourceforge.net, linux-390@vm.marist.edu,
	aharkes@cs.cmu.edu, tim@cyberelk.net,
	codalist@TELEMANN.coda.cs.cmu.edu, a.zummo@towertech.it,
	tony.luck@intel.com, minyard@acm.org, linux-scsi@vger.kernel.org,
	linuxppc-dev@ozlabs.org, linux-ntfs-dev@lists.sourceforge.net,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	ralf@linux-mips.org, mark.fasheh@oracle.com, coda@cs.cmu.edu,
	vojtech@suse.cz, kurt.hackel@oracle.com, schwidefsky@de.ibm.com,
	aia21@cantab.net, philb@gnu.org, andrea@suse.de,
	linuxsh-shmedia-dev@lists.sourceforge.net, ak@suse.de
Subject: Re: [PATCH 25/59] sysctl: C99 convert arch/frv/kernel/pm.c
Message-ID: <20070122222115.GC11128@MAIL.13thfloor.at>
Mail-Followup-To: Kirill Korotaev <dev@sw.ru>,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	James.Bottomley@SteelEye.com, linux-parport@lists.infradead.org,
	rtc-linux@googlegroups.com, linux-mips@linux-mips.org,
	heiko.carstens@de.ibm.com, containers@lists.osdl.org,
	lethal@linux-sh.org, clemens@ladisch.de, xfs@oss.sgi.com,
	xfs-masters@oss.sgi.com, paulus@samba.org, linux390@de.ibm.com,
	openipmi-developer@lists.sourceforge.net, linux-390@vm.marist.edu,
	aharkes@cs.cmu.edu, tim@cyberelk.net,
	codalist@TELEMANN.coda.cs.cmu.edu, a.zummo@towertech.it,
	tony.luck@intel.com, minyard@acm.org, linux-scsi@vger.kernel.org,
	linuxppc-dev@ozlabs.org, linux-ntfs-dev@lists.sourceforge.net,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	ralf@linux-mips.org, mark.fasheh@oracle.com, coda@cs.cmu.edu,
	vojtech@suse.cz, kurt.hackel@oracle.com, schwidefsky@de.ibm.com,
	aia21@cantab.net, philb@gnu.org, andrea@suse.de,
	linuxsh-shmedia-dev@lists.sourceforge.net, ak@suse.de
References: <m1ac0jc4no.fsf@ebiederm.dsl.xmission.com> <11689656443582-git-send-email-ebiederm@xmission.com> <45AE5969.8030603@sw.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <45AE5969.8030603@sw.ru>
User-Agent: Mutt/1.5.11
Return-Path: <herbert@13thfloor.at>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13740
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: herbert@13thfloor.at
Precedence: bulk
X-list: linux-mips

On Wed, Jan 17, 2007 at 08:14:17PM +0300, Kirill Korotaev wrote:
> another small minor note.
> 
> > From: Eric W. Biederman <ebiederm@xmission.com> - unquoted
> > 
> > Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
> > ---
> >  arch/frv/kernel/pm.c |   50 +++++++++++++++++++++++++++++++++++++++++++-------
> >  1 files changed, 43 insertions(+), 7 deletions(-)
> > 
> > diff --git a/arch/frv/kernel/pm.c b/arch/frv/kernel/pm.c
> > index c1840d6..aa50333 100644
> > --- a/arch/frv/kernel/pm.c
> > +++ b/arch/frv/kernel/pm.c
> > @@ -401,17 +401,53 @@ static int cm_sysctl(ctl_table *table, int __user *name, int nlen,
> >  
> >  static struct ctl_table pm_table[] =
> >  {
> > -	{CTL_PM_SUSPEND, "suspend", NULL, 0, 0200, NULL, &sysctl_pm_do_suspend},
> > -	{CTL_PM_CMODE, "cmode", &clock_cmode_current, sizeof(int), 0644, NULL, &cmode_procctl, &cmode_sysctl, NULL},
> > -	{CTL_PM_P0, "p0", &clock_p0_current, sizeof(int), 0644, NULL, &p0_procctl, &p0_sysctl, NULL},
> > -	{CTL_PM_CM, "cm", &clock_cm_current, sizeof(int), 0644, NULL, &cm_procctl, &cm_sysctl, NULL},
> > -	{0}
> > +	{
> > +		.ctl_name	= CTL_PM_SUSPEND,
> > +		.procname	= "suspend",
> > +		.data		= NULL,
> > +		.maxlen		= 0,
> > +		.mode		= 0200,
> > +		.proc_handler	= &sysctl_pm_do_suspend,
> > +	},
> > +	{
> > +		.ctl_name	= CTL_PM_CMODE,
> > +		.procname	= "cmode",
> > +		.data		= &clock_cmode_current,
> > +		.maxlen		= sizeof(int),
> > +		.mode		= 0644,
> > +		.proc_handler	= &cmode_procctl,
> > +		.strategy	= &cmode_sysctl,
> > +	},
> > +	{
> > +		.ctl_name	= CTL_PM_P0,
> > +		.procname	= "p0",
> > +		.data		= &clock_p0_current,
> > +		.maxlen		= sizeof(int),
> > +		.mode		= 0644,
> > +		.proc_handler	= &p0_procctl,
> > +		.strategy	= &p0_sysctl,
> > +	},
> > +	{
> > +		.ctl_name	= CTL_PM_CM,
> > +		.procname	= "cm",
> > +		.data		= &clock_cm_current,
> > +		.maxlen		= sizeof(int),
> > +		.mode		= 0644,
> > +		.proc_handler	= &cm_procctl,
> > +		.strategy	= &cm_sysctl,
> > +	},
> > +	{ .ctl_name = 0}
> in next patch (26/59) you write just "{ }". .ctl_name = 0 not required here.

I'd prefer '{ 0 }' here, but I'm fine with the '{ .ctl_name = 0 }'
too, just '{ }' seems confusing, and it actually might get
misinterpreted too ..

best,
Herbert

> >  };
> >  
> >  static struct ctl_table pm_dir_table[] =
> >  {
> > -	{CTL_PM, "pm", NULL, 0, 0555, pm_table},
> > -	{0}
> > +	{
> > +		.ctl_name	= CTL_PM,
> > +		.procname	= "pm",
> > +		.mode		= 0555,
> > +		.child		= pm_table,
> > +	},
> > +	{ .ctl_name = 0}
> >  };
> >  
> >  /*
> 
> _______________________________________________
> Containers mailing list
> Containers@lists.osdl.org
> https://lists.osdl.org/mailman/listinfo/containers
