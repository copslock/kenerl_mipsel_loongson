Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 14 Sep 2007 09:44:09 +0100 (BST)
Received: from p549F7FC7.dip.t-dialin.net ([84.159.127.199]:48262 "EHLO
	p549F7FC7.dip.t-dialin.net") by ftp.linux-mips.org with ESMTP
	id S20021682AbXINInz (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 14 Sep 2007 09:43:55 +0100
Received: from ug-out-1314.google.com ([66.249.92.168]:11068 "EHLO
	ug-out-1314.google.com") by lappi.linux-mips.net with ESMTP
	id S1097024AbXINIeV (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 14 Sep 2007 10:34:21 +0200
Received: by ug-out-1314.google.com with SMTP id u2so566781uge
        for <linux-mips@linux-mips.org>; Fri, 14 Sep 2007 01:33:47 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        bh=hEelf7CRmQdvOLOpK3HIEKQ0iHvYfSy1nhtKMr/P/Rg=;
        b=PSvJCcT4+lCU/CWKotgOIA1GLN6LxqzUdqgMslrPhxXfCHQxQ4RVBUgQDQHG+fyWakAStGDhOXN2S6UjUYcmvhGOFNBLRZTJibPyortuCom5a7GnABYwnqFkMIXO4glL40L/cXTsPgzCmmrwncio7+oWRrXZer77SKu5UtG1XmM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=gt0ajb3ZgbJZfnVKzEMZz8CnYt4Fy8xNT4IPn+yAdzJCcMV1/vCcywURlCG60lndXgIw52n+GGW1mrGd7jOVAZYyefeoGKXGgeKocXkSVJ0yA+dyaTcXtav1oSVFU5161ui5SzU1LeNB5FitAdUwABbxEfL4Ex4LGf75hXwIzQI=
Received: by 10.67.20.11 with SMTP id x11mr3269712ugi.1189758826617;
        Fri, 14 Sep 2007 01:33:46 -0700 (PDT)
Received: from ?192.168.0.1? ( [82.235.205.153])
        by mx.google.com with ESMTPS id 31sm1355183fkt.2007.09.14.01.33.45
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 14 Sep 2007 01:33:45 -0700 (PDT)
Message-ID: <46EA4730.2070806@gmail.com>
Date:	Fri, 14 Sep 2007 10:32:48 +0200
From:	Franck Bui-Huu <vagabon.xyz@gmail.com>
User-Agent: Thunderbird 2.0.0.5 (X11/20070719)
MIME-Version: 1.0
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
CC:	linux-mips@linux-mips.org
Subject: Re: flush_kernel_dcache_page() not needed ?
References: <46DC29F0.3060200@gmail.com>	<20070904.005400.52128244.anemo@mba.ocn.ne.jp>	<46DD53BE.2070004@gmail.com> <20070906.003320.25909195.anemo@mba.ocn.ne.jp>
In-Reply-To: <20070906.003320.25909195.anemo@mba.ocn.ne.jp>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16522
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vagabon.xyz@gmail.com
Precedence: bulk
X-list: linux-mips

Atsushi Nemoto wrote:
> Yes, there is an yet another path to "flush all dcache".
> 
> do_execve()
>   copy_strings()
>     flush_kernel_dcache_page()
>   search_binary_handler()
>     load_elf_binary()
>       flush_old_exec()
>         exec_mmap()
>           mmput()
>             exit_mmap()
>               flush_cache_mm()
>                 r4k_blast_dcache()
> 

BTW, flush_cache_mm() flushes (write back + invalidate ) the whole
data cache unconditionnaly, but I'm wondering if it's really necessary
for cpus which don't have any cache aliasing issues. After all they're
equivalent to physical caches, aren't they ?

thanks,
		Franck
