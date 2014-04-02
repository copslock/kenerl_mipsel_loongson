Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 02 Apr 2014 18:53:09 +0200 (CEST)
Received: from aserp1040.oracle.com ([141.146.126.69]:18682 "EHLO
        aserp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6822276AbaDBQxFZtKWs (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 2 Apr 2014 18:53:05 +0200
Received: from acsinet22.oracle.com (acsinet22.oracle.com [141.146.126.238])
        by aserp1040.oracle.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with ESMTP id s32Gqwip010947
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
        Wed, 2 Apr 2014 16:52:58 GMT
Received: from userz7022.oracle.com (userz7022.oracle.com [156.151.31.86])
        by acsinet22.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id s32GquN7001026
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Wed, 2 Apr 2014 16:52:57 GMT
Received: from abhmp0002.oracle.com (abhmp0002.oracle.com [141.146.116.8])
        by userz7022.oracle.com (8.14.5+Sun/8.14.4) with ESMTP id s32GqueN026876;
        Wed, 2 Apr 2014 16:52:56 GMT
Received: from mwanda (/197.157.0.6)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 02 Apr 2014 09:52:55 -0700
Date:   Wed, 2 Apr 2014 19:52:49 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, kernel-janitors@vger.kernel.org
Subject: Re: [patch] [MIPS] Lasat: a couple off by one bugs in picvue_proc.c
Message-ID: <20140402165249.GL18506@mwanda>
References: <20131108094431.GC27977@elgon.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20131108094431.GC27977@elgon.mountain>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Source-IP: acsinet22.oracle.com [141.146.126.238]
Return-Path: <dan.carpenter@oracle.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39614
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dan.carpenter@oracle.com
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

These off by one bugs are still there in linux-next.

regards,
dan carpenter

On Fri, Nov 08, 2013 at 12:44:31PM +0300, Dan Carpenter wrote:
> These should be ">=" instead of ">" or we go past the end of the
> pvc_lines[] array.
> 
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> 
> diff --git a/arch/mips/lasat/picvue_proc.c b/arch/mips/lasat/picvue_proc.c
> index 638c5db..8c55de4 100644
> --- a/arch/mips/lasat/picvue_proc.c
> +++ b/arch/mips/lasat/picvue_proc.c
> @@ -44,7 +44,7 @@ static int pvc_line_proc_show(struct seq_file *m, void *v)
>  {
>  	int lineno = *(int *)m->private;
>  
> -	if (lineno < 0 || lineno > PVC_NLINES) {
> +	if (lineno < 0 || lineno >= PVC_NLINES) {
>  		printk(KERN_WARNING "proc_read_line: invalid lineno %d\n", lineno);
>  		return 0;
>  	}
> @@ -68,7 +68,7 @@ static ssize_t pvc_line_proc_write(struct file *file, const char __user *buf,
>  	char kbuf[PVC_LINELEN];
>  	size_t len;
>  
> -	BUG_ON(lineno < 0 || lineno > PVC_NLINES);
> +	BUG_ON(lineno < 0 || lineno >= PVC_NLINES);
>  
>  	len = min(count, sizeof(kbuf) - 1);
>  	if (copy_from_user(kbuf, buf, len))
