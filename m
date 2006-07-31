Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 31 Jul 2006 16:52:37 +0100 (BST)
Received: from wx-out-0102.google.com ([66.249.82.194]:31939 "EHLO
	wx-out-0102.google.com") by ftp.linux-mips.org with ESMTP
	id S8126937AbWGaPwX (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 31 Jul 2006 16:52:23 +0100
Received: by wx-out-0102.google.com with SMTP id h29so91434wxd
        for <linux-mips@linux-mips.org>; Mon, 31 Jul 2006 08:52:19 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:reply-to:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding:from;
        b=DiCc0JkvJ5vXrD7Fc7Xz/WUzhz9kYtIM6wKtd/X6jy4kYHhc5BE2J8WVKIKHQ8gT7Hc/KMYsU1T8qjBibYuxU9krDT8blBEoTGXl7j+4cQ6ppc9hw6d6KXBzI17+hzyPV02mN+a3eSTij9PJOPn3b1NfgD4mYHcwZ9D6Jt0388I=
Received: by 10.70.32.18 with SMTP id f18mr2832055wxf;
        Mon, 31 Jul 2006 08:52:19 -0700 (PDT)
Received: from ?192.168.0.24? ( [194.3.162.233])
        by mx.gmail.com with ESMTP id h7sm5045880wxd.2006.07.31.08.52.17;
        Mon, 31 Jul 2006 08:52:19 -0700 (PDT)
Message-ID: <44CE26FA.8070909@innova-card.com>
Date:	Mon, 31 Jul 2006 17:51:22 +0200
Reply-To: Franck <vagabon.xyz@gmail.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
CC:	vagabon.xyz@gmail.com, linux-mips@linux-mips.org,
	ralf@linux-mips.org
Subject: Re: [PATCH] dump_stack() based on prologue code analysis
References: <44CDCA46.3030707@innova-card.com>	<20060731.223923.115609520.anemo@mba.ocn.ne.jp>	<44CE1494.4080801@innova-card.com> <20060801.003311.75758612.anemo@mba.ocn.ne.jp>
In-Reply-To: <20060801.003311.75758612.anemo@mba.ocn.ne.jp>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From:	Franck Bui-Huu <vagabon.xyz@gmail.com>
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12135
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vagabon.xyz@gmail.com
Precedence: bulk
X-list: linux-mips

Atsushi Nemoto wrote:
> 
> Subject: [PATCH] make get_frame_info() more readable.
> 
> Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
> 
> diff --git a/arch/mips/kernel/process.c b/arch/mips/kernel/process.c
> index 8709a46..949efaf 100644
> --- a/arch/mips/kernel/process.c
> +++ b/arch/mips/kernel/process.c
> @@ -286,18 +286,17 @@ static int get_frame_info(struct mips_fr
>  	int i;
>  	void *func = info->func;
>  	union mips_instruction *ip = (union mips_instruction *)func;

while you're at it, (union mips_instruction *) cast is useless and "func"
local too. Just write 

	union mips_instruction *ip = info->func;

is more readable, IMHO.

		Franck
