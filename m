Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 05 Aug 2014 00:55:18 +0200 (CEST)
Received: from mail-pd0-f181.google.com ([209.85.192.181]:44973 "EHLO
        mail-pd0-f181.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6860188AbaHDWzHAK148 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 5 Aug 2014 00:55:07 +0200
Received: by mail-pd0-f181.google.com with SMTP id g10so135507pdj.26
        for <linux-mips@linux-mips.org>; Mon, 04 Aug 2014 15:55:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:subject:references
         :in-reply-to:content-type:content-transfer-encoding;
        bh=YYEo6h6sZ+SbsOjIgf7k1LSh/ePdTscGe9tf7wd6T/8=;
        b=FyNWaGNsvzNkwSe+KQ29Oww5/ZyH+PLPpCb5H6XkTmhoLJCBsvJnN468E1RT2dyjao
         ETsh117snQu62hg1g9gysL2cMn/7fLEEwDgMFWigpIJ6/fEHkrjCZK+cl2LPOJjBvXYt
         HyYwQ5dh7VWvfdr+1TxEqJ0rbykhY52b2PjoRgSyjIXOR4uYPCWuzq+NZnGqkeEJPVmZ
         wxc2S8KR2OXkpvgcNF6o+eUWv0LqOnhHHL1U8Qe04XHafkTxd0mWeIAG3DeI2rxqzcKN
         M2eV/PwLHj/UU1R6pR9+dNLVXDX+JMR/HqHUZmRb03wzqPJgV9iRdoDVW8Xw4T6CZvyQ
         s8xg==
X-Received: by 10.66.100.200 with SMTP id fa8mr26772025pab.23.1407192900053;
        Mon, 04 Aug 2014 15:55:00 -0700 (PDT)
Received: from [10.12.164.252] (5520-maca-inet1-outside.broadcom.com. [216.31.211.11])
        by mx.google.com with ESMTPSA id da7sm28489264pdb.4.2014.08.04.15.54.59
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 Aug 2014 15:54:59 -0700 (PDT)
Message-ID: <53E00F39.7@gmail.com>
Date:   Mon, 04 Aug 2014 15:54:49 -0700
From:   Florian Fainelli <f.fainelli@gmail.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.0
MIME-Version: 1.0
To:     Markos Chandras <markos.chandras@imgtec.com>,
        linux-mips@linux-mips.org
Subject: Re: [PATCH 3/4] MIPS: cpu-probe: Set the write-combine CCA value
 on per core basis
References: <1405677093-22591-1-git-send-email-markos.chandras@imgtec.com> <1405677093-22591-4-git-send-email-markos.chandras@imgtec.com>
In-Reply-To: <1405677093-22591-4-git-send-email-markos.chandras@imgtec.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 41878
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: f.fainelli@gmail.com
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

Hi Markos,

On 07/18/2014 02:51 AM, Markos Chandras wrote:
> Different cores use different CCA values to achieve write-combine
> memory writes. For cores that do not support write-combine we
> set the default value to CCA:2 (uncached, non-coherent) which is the
> default value as set by the kernel.
> 
> Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
> ---
[snip]
			break;
> @@ -765,67 +767,83 @@ static inline void cpu_probe_legacy(struct cpuinfo_mips *c, unsigned int cpu)
>  
>  static inline void cpu_probe_mips(struct cpuinfo_mips *c, unsigned int cpu)
>  {
> +	c->writecombine = _CACHE_UNCACHED_ACCELERATED;

Why do we set this writecombine setting by default, when later we are
going to override writecombine on a per-cpu basic.

In the end, we have the following:

cpu_probe()
	c->writecombine = _CACHE_UNCACHED;

	cpu_probe_mips()
		c->writecombine = _CACHE_UNCACHED_ACCELERATED:
		... per-cpu case ...
		c->writecombine = _CACHE_UNCACHED;

Can't we just eliminate the various assignments in cpu_probe_mips() and
only override c->writecombine if _CACHE_UNCACHED is not suitable?


>  	switch (c->processor_id & PRID_IMP_MASK) {
>  	case PRID_IMP_4KC:
>  		c->cputype = CPU_4KC;
> +		c->writecombine = _CACHE_UNCACHED;
>  		__cpu_name[cpu] = "MIPS 4Kc";
>  		break;
>  	case PRID_IMP_4KEC:
>  	case PRID_IMP_4KECR2:
>  		c->cputype = CPU_4KEC;
> +		c->writecombine = _CACHE_UNCACHED;
>  		__cpu_name[cpu] = "MIPS 4KEc";
>  		break;
>  	case PRID_IMP_4KSC:
>  	case PRID_IMP_4KSD:
>  		c->cputype = CPU_4KSC;
> +		c->writecombine = _CACHE_UNCACHED;
>  		__cpu_name[cpu] = "MIPS 4KSc";
>  		break;
>  	case PRID_IMP_5KC:
>  		c->cputype = CPU_5KC;
> +		c->writecombine = _CACHE_UNCACHED;
>  		__cpu_name[cpu] = "MIPS 5Kc";
>  		break;
>  	case PRID_IMP_5KE:
>  		c->cputype = CPU_5KE;
> +		c->writecombine = _CACHE_UNCACHED;
>  		__cpu_name[cpu] = "MIPS 5KE";
>  		break;
>  	case PRID_IMP_20KC:
>  		c->cputype = CPU_20KC;
> +		c->writecombine = _CACHE_UNCACHED;
>  		__cpu_name[cpu] = "MIPS 20Kc";
>  		break;
>  	case PRID_IMP_24K:
>  		c->cputype = CPU_24K;
> +		c->writecombine = _CACHE_UNCACHED;
>  		__cpu_name[cpu] = "MIPS 24Kc";
>  		break;
>  	case PRID_IMP_24KE:
>  		c->cputype = CPU_24K;
> +		c->writecombine = _CACHE_UNCACHED;
>  		__cpu_name[cpu] = "MIPS 24KEc";
>  		break;
>  	case PRID_IMP_25KF:
>  		c->cputype = CPU_25KF;
> +		c->writecombine = _CACHE_UNCACHED;
>  		__cpu_name[cpu] = "MIPS 25Kc";
>  		break;
>  	case PRID_IMP_34K:
>  		c->cputype = CPU_34K;
> +		c->writecombine = _CACHE_UNCACHED;
>  		__cpu_name[cpu] = "MIPS 34Kc";
>  		break;
>  	case PRID_IMP_74K:
>  		c->cputype = CPU_74K;
> +		c->writecombine = _CACHE_UNCACHED;
>  		__cpu_name[cpu] = "MIPS 74Kc";
>  		break;
>  	case PRID_IMP_M14KC:
>  		c->cputype = CPU_M14KC;
> +		c->writecombine = _CACHE_UNCACHED;
>  		__cpu_name[cpu] = "MIPS M14Kc";
>  		break;
>  	case PRID_IMP_M14KEC:
>  		c->cputype = CPU_M14KEC;
> +		c->writecombine = _CACHE_UNCACHED;
>  		__cpu_name[cpu] = "MIPS M14KEc";
>  		break;
>  	case PRID_IMP_1004K:
>  		c->cputype = CPU_1004K;
> +		c->writecombine = _CACHE_UNCACHED;
>  		__cpu_name[cpu] = "MIPS 1004Kc";
>  		break;
>  	case PRID_IMP_1074K:
>  		c->cputype = CPU_1074K;
> +		c->writecombine = _CACHE_UNCACHED;
>  		__cpu_name[cpu] = "MIPS 1074Kc";
>  		break;
>  	case PRID_IMP_INTERAPTIV_UP:
> @@ -899,6 +917,7 @@ static inline void cpu_probe_sibyte(struct cpuinfo_mips *c, unsigned int cpu)
>  {
>  	decode_configs(c);
>  
> +	c->writecombine = _CACHE_UNCACHED_ACCELERATED;
>  	switch (c->processor_id & PRID_IMP_MASK) {
>  	case PRID_IMP_SB1:
>  		c->cputype = CPU_SB1;
> @@ -1030,6 +1049,7 @@ static inline void cpu_probe_ingenic(struct cpuinfo_mips *c, unsigned int cpu)
>  	switch (c->processor_id & PRID_IMP_MASK) {
>  	case PRID_IMP_JZRISC:
>  		c->cputype = CPU_JZRISC;
> +		c->writecombine = _CACHE_UNCACHED_ACCELERATED;
>  		__cpu_name[cpu] = "Ingenic JZRISC";
>  		break;
>  	default:
> @@ -1136,6 +1156,7 @@ void cpu_probe(void)
>  	c->processor_id = PRID_IMP_UNKNOWN;
>  	c->fpu_id	= FPIR_IMP_NONE;
>  	c->cputype	= CPU_UNKNOWN;
> +	c->writecombine = _CACHE_UNCACHED;



>  
>  	c->processor_id = read_c0_prid();
>  	switch (c->processor_id & PRID_COMP_MASK) {
> 
