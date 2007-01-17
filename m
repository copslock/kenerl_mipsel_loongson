Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 17 Jan 2007 03:17:12 +0000 (GMT)
Received: from gate.crashing.org ([63.228.1.57]:57050 "EHLO gate.crashing.org")
	by ftp.linux-mips.org with ESMTP id S20047337AbXAQDRH (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 17 Jan 2007 03:17:07 +0000
Received: from [127.0.0.1] (localhost.localdomain [127.0.0.1])
	by gate.crashing.org (8.13.8/8.13.8) with ESMTP id l0H3GTCA006697;
	Tue, 16 Jan 2007 21:16:30 -0600
Subject: Re: [PATCH 35/59] sysctl: C99 convert ctl_tables in
	arch/powerpc/kernel/idle.c
From:	Benjamin Herrenschmidt <benh@kernel.crashing.org>
To:	"Eric W. Biederman" <ebiederm@xmission.com>
Cc:	"<Andrew Morton" <akpm@osdl.org>, linux-mips@linux-mips.org,
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
	lethal@linux-sh.org, containers@lists.osdl.org,
	linux390@de.ibm.com, philb@gnu.org
In-Reply-To: <11689656593247-git-send-email-ebiederm@xmission.com>
References: <m1ac0jc4no.fsf@ebiederm.dsl.xmission.com>
	 <11689656593247-git-send-email-ebiederm@xmission.com>
Content-Type: text/plain
Date:	Wed, 17 Jan 2007 14:16:27 +1100
Message-Id: <1169003787.4778.17.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
Return-Path: <benh@kernel.crashing.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13683
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: benh@kernel.crashing.org
Precedence: bulk
X-list: linux-mips

On Tue, 2007-01-16 at 09:39 -0700, Eric W. Biederman wrote:
> From: Eric W. Biederman <ebiederm@xmission.com> - unquoted
> 
> This was partially done already and there was no ABI breakage what
> a relief.
> 
> Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>

Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

> ---
>  arch/powerpc/kernel/idle.c |   11 ++++++++---
>  1 files changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/powerpc/kernel/idle.c b/arch/powerpc/kernel/idle.c
> index 8994af3..8b27bb1 100644
> --- a/arch/powerpc/kernel/idle.c
> +++ b/arch/powerpc/kernel/idle.c
> @@ -110,11 +110,16 @@ static ctl_table powersave_nap_ctl_table[]={
>  		.mode		= 0644,
>  		.proc_handler	= &proc_dointvec,
>  	},
> -	{ 0, },
> +	{}
>  };
>  static ctl_table powersave_nap_sysctl_root[] = {
> -	{ 1, "kernel", NULL, 0, 0755, powersave_nap_ctl_table, },
> - 	{ 0,},
> +	{
> +		.ctl_name	= CTL_KERN,
> +		.procname	= "kernel",
> +		.mode		= 0755,
> +		.child		= powersave_nap_ctl_table,
> +	},
> +	{}
>  };
>  
>  static int __init
