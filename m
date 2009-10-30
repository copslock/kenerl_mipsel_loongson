Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 30 Oct 2009 02:18:04 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:36896 "EHLO
	localhost.localdomain" rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org
	with ESMTP id S1492935AbZJ3BSB (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 30 Oct 2009 02:18:01 +0100
Date:	Fri, 30 Oct 2009 01:18:01 +0000 (GMT)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	Wu Zhangjin <wuzhangjin@gmail.com>
cc:	Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
	David Daney <ddaney@caviumnetworks.com>
Subject: Re: [PATCH v2] MIPS: fixes and cleanups for the compressed kernel
 support
In-Reply-To: <1256865222-19817-1-git-send-email-wuzhangjin@gmail.com>
Message-ID: <alpine.LFD.2.00.0910300116210.4905@eddie.linux-mips.org>
References: <1256865222-19817-1-git-send-email-wuzhangjin@gmail.com>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24583
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, 30 Oct 2009, Wu Zhangjin wrote:

> @@ -46,9 +46,10 @@ start:
>  	move	a3, s3
>  	PTR_LI	k0, KERNEL_ENTRY
>  	jr	k0
> -	nop
> +	 nop
>  3:
>  	b 3b
	^^^^
 Please reformat for consistency and readability:

	b	3b

  Maciej
