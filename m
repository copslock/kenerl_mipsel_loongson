Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 18 Oct 2006 17:00:28 +0100 (BST)
Received: from nf-out-0910.google.com ([64.233.182.184]:24004 "EHLO
	nf-out-0910.google.com") by ftp.linux-mips.org with ESMTP
	id S20038548AbWJRQAT (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 18 Oct 2006 17:00:19 +0100
Received: by nf-out-0910.google.com with SMTP id l23so716900nfc
        for <linux-mips@linux-mips.org>; Wed, 18 Oct 2006 09:00:19 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:reply-to:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding:from;
        b=rtJfwt7HCku2UqZAl5eR02xD6efTWTU5n6YhW2/Z7zmb56YPE0VC6HeH6hQZ+TYTAN8d13aoazdvIFcytne7eFSGfNZGmVzz2zfuwbraYukGFREdritS/NlINR3E22u/llhEyYOQ7oayYPfR20AkRUImnt8Ul/p8sk7UVMLqRK0=
Received: by 10.48.163.19 with SMTP id l19mr3861417nfe;
        Wed, 18 Oct 2006 08:59:56 -0700 (PDT)
Received: from ?192.168.0.24? ( [81.252.61.1])
        by mx.google.com with ESMTP id a24sm1685957nfc.2006.10.18.08.59.55;
        Wed, 18 Oct 2006 08:59:55 -0700 (PDT)
Message-ID: <45364F82.8030308@innova-card.com>
Date:	Wed, 18 Oct 2006 18:00:02 +0200
Reply-To: Franck <vagabon.xyz@gmail.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
CC:	Ralf Baechle <ralf@linux-mips.org>,
	linux-mips <linux-mips@linux-mips.org>
Subject: Re: [PATCH][MIPS] merge a few printk in check_wait()
References: <20061019002718.1ca0ec56.yoichi_yuasa@tripeaks.co.jp>
In-Reply-To: <20061019002718.1ca0ec56.yoichi_yuasa@tripeaks.co.jp>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
From:	Franck Bui-Huu <vagabon.xyz@gmail.com>
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12992
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vagabon.xyz@gmail.com
Precedence: bulk
X-list: linux-mips

Hi,

Yoichi Yuasa wrote:
> Hi Ralf,
> 
> This patch has merged a few printk in check_wait().
> 
> Yoichi
> 
> Signed-off-by: Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
> 
> diff -pruN -X mips/Documentation/dontdiff mips-orig/arch/mips/kernel/cpu-probe.c mips/arch/mips/kernel/cpu-probe.c
> --- mips-orig/arch/mips/kernel/cpu-probe.c	2006-10-18 10:20:24.397574000 +0900
> +++ mips/arch/mips/kernel/cpu-probe.c	2006-10-18 10:28:53.113366750 +0900
> @@ -120,11 +120,9 @@ static inline void check_wait(void)

does it really need to be inlined ?

>  	case CPU_R3081:
[snip]
> +
> +	if (cpu_wait)
> +		printk(" available.\n");
> +	else
> +		printk(" unavailable.\n");

what about:

	printk(" %savailable.\n", cpu_wait ? "" : "un");


		Franck
