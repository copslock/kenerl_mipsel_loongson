Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 27 Jan 2007 10:55:44 +0000 (GMT)
Received: from smtp.osdl.org ([65.172.181.24]:48829 "EHLO smtp.osdl.org")
	by ftp.linux-mips.org with ESMTP id S20037494AbXA0Kzj (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sat, 27 Jan 2007 10:55:39 +0000
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l0RApf1m005037
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sat, 27 Jan 2007 02:51:42 -0800
Received: from box (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with SMTP id l0RApb27007533;
	Sat, 27 Jan 2007 02:51:37 -0800
Date:	Sat, 27 Jan 2007 02:51:37 -0800
From:	Andrew Morton <akpm@osdl.org>
To:	"Eric W. Biederman" <ebiederm@xmission.com>
Cc:	<linux-kernel@vger.kernel.org>, <containers@lists.osdl.org>,
	<netdev@vger.kernel.org>, xfs-masters@oss.sgi.com, xfs@oss.sgi.com,
	linux-scsi@vger.kernel.org, James.Bottomley@SteelEye.com,
	minyard@acm.org, openipmi-developer@lists.sourceforge.net,
	<tony.luck@intel.com>, linux-mips@linux-mips.org,
	ralf@linux-mips.org, schwidefsky@de.ibm.com,
	heiko.carstens@de.ibm.com, linux390@de.ibm.com,
	linux-390@vm.marist.edu, paulus@samba.org, linuxppc-dev@ozlabs.org,
	lethal@linux-sh.org, linuxsh-shmedia-dev@lists.sourceforge.net,
	<ak@suse.de>, vojtech@suse.cz, clemens@ladisch.de,
	a.zummo@towertech.it, rtc-linux@googlegroups.com,
	linux-parport@lists.infradead.org, andrea@suse.de,
	tim@cyberelk.net, philb@gnu.org, aharkes@cs.cmu.edu,
	coda@cs.cmu.edu, codalist@TELEMANN.coda.cs.cmu.edu,
	aia21@cantab.net, linux-ntfs-dev@lists.sourceforge.net,
	mark.fasheh@oracle.com, kurt.hackel@oracle.com
Subject: Re: [PATCH 49/59] sysctl: Move init_irq_proc into init/main where
 it belongs
Message-Id: <20070127025137.9a2c65bb.akpm@osdl.org>
In-Reply-To: <1168965684147-git-send-email-ebiederm@xmission.com>
References: <m1ac0jc4no.fsf@ebiederm.dsl.xmission.com>
	<1168965684147-git-send-email-ebiederm@xmission.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-MIMEDefang-Filter: osdl$Revision: 1.172 $
X-Scanned-By: MIMEDefang 2.36
Return-Path: <akpm@osdl.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13828
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: akpm@osdl.org
Precedence: bulk
X-list: linux-mips

On Tue, 16 Jan 2007 09:39:54 -0700
"Eric W. Biederman" <ebiederm@xmission.com> wrote:

> From: Eric W. Biederman <ebiederm@xmission.com> - unquoted
> 
> Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
> ---
>  init/main.c     |    3 +++
>  kernel/sysctl.c |    3 ---
>  2 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/init/main.c b/init/main.c
> index 8b4a7d7..8af5c6e 100644
> --- a/init/main.c
> +++ b/init/main.c
> @@ -691,6 +691,9 @@ static void __init do_basic_setup(void)
>  #ifdef CONFIG_SYSCTL
>  	sysctl_init();
>  #endif
> +#ifdef CONFIG_PROC_FS
> +	init_irq_proc();
> +#endif
>  
>  	do_initcalls();
>  }
> diff --git a/kernel/sysctl.c b/kernel/sysctl.c
> index 600b333..7420761 100644
> --- a/kernel/sysctl.c
> +++ b/kernel/sysctl.c
> @@ -1172,8 +1172,6 @@ static ctl_table dev_table[] = {
>  	{ .ctl_name = 0 }
>  };
>  
> -extern void init_irq_proc (void);
> -
>  static DEFINE_SPINLOCK(sysctl_lock);
>  
>  /* called under sysctl_lock */
> @@ -1219,7 +1217,6 @@ void __init sysctl_init(void)
>  {
>  #ifdef CONFIG_PROC_SYSCTL
>  	register_proc_table(root_table, proc_sys_root, &root_table_header);
> -	init_irq_proc();
>  #endif
>  }

sparc64:

init/main.c: In function `do_basic_setup':
init/main.c:707: warning: implicit declaration of function `init_irq_proc'

I couldn't be bothered working out how init/main.c is supposed to get at
its declaration of init_irq_proc().  It's not allowed to include
linux/irq.h.
