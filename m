Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 28 May 2009 18:11:41 +0100 (BST)
Received: from [222.92.8.141] ([222.92.8.141]:37456 "EHLO lemote.com"
	rhost-flags-FAIL-FAIL-OK-OK) by ftp.linux-mips.org with ESMTP
	id S20024544AbZE1RLe (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 28 May 2009 18:11:34 +0100
Received: from localhost (localhost [127.0.0.1])
	by lemote.com (Postfix) with ESMTP id 4297E34201;
	Fri, 29 May 2009 01:06:17 +0800 (CST)
X-Virus-Scanned: Debian amavisd-new at lemote.com
Received: from lemote.com ([127.0.0.1])
	by localhost (www.lemote.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id dDHPoDCGxsk7; Fri, 29 May 2009 01:06:01 +0800 (CST)
Received: from [192.168.1.100] (unknown [219.246.59.144])
	by lemote.com (Postfix) with ESMTP id 07869340E0;
	Fri, 29 May 2009 01:05:59 +0800 (CST)
Subject: Re: [loongson-PATCH-v2 23/23] Hibernation Support in mips system
From:	Wu Zhangjin <wuzj@lemote.com>
Reply-To: wuzj@lemote.com
To:	linux-mips@linux-mips.org
Cc:	Ralf Baechle <ralf@linux-mips.org>, Yan Hua <yanh@lemote.com>,
	Philippe Vachon <philippe@cowpig.ca>,
	Zhang Le <r0bertz@gentoo.org>,
	Zhang Fuxin <zhangfx@lemote.com>,
	loongson-dev <loongson-dev@googlegroups.com>,
	Nicholas Mc Guire <der.herr@hofr.at>,
	Liu Junliang <liujl@lemote.com>,
	Erwan Lerale <erwan@thiscow.com>
In-Reply-To: <1483a7cb0f587bd329ea3ca8d3af2881afadaf5e.1243362545.git.wuzj@lemote.com>
References: <cover.1243362545.git.wuzj@lemote.com>
	 <1483a7cb0f587bd329ea3ca8d3af2881afadaf5e.1243362545.git.wuzj@lemote.com>
Content-Type: text/plain
Organization: www.lemote.com, Changshu City, JiangSu Province, China
Date:	Fri, 29 May 2009 01:10:58 +0800
Message-Id: <1243530658.19464.5.camel@falcon>
Mime-Version: 1.0
X-Mailer: Evolution 2.26.1 
Content-Transfer-Encoding: 7bit
Return-Path: <wuzj@lemote.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23035
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzj@lemote.com
Precedence: bulk
X-list: linux-mips

Hi,

> +.text
> +LEAF(swsusp_arch_suspend)
[...]
> +	PTR_S a0, PT_R4(t0)
> +	PTR_S a1, PT_R5(t0)
> +	PTR_S a2, PT_R6(t0)

ooh, seems miss:

	PTR_S a3, PT_R7(t0)

and is there a need to save/restore a4,a5,a6,a7 in 64bit kernel? 

> +	PTR_S v1, PT_R3(t0)
> +	j swsusp_save
> +END(swsusp_arch_suspend)
> +
> +LEAF(swsusp_arch_resume)
[...]
> +	PTR_L a0, PT_R4(t0)
> +	PTR_L a1, PT_R5(t0)
> +	PTR_L a2, PT_R6(t0)
> +	PTR_L a3, PT_R7(t0)
> +	PTR_LI v0, 0x0
> +	PTR_L v1, PT_R3(t0)
> +	jr ra
> +END(swsusp_arch_resume)
