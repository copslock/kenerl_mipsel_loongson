Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 16 Oct 2006 09:03:18 +0100 (BST)
Received: from nf-out-0910.google.com ([64.233.182.185]:51614 "EHLO
	nf-out-0910.google.com") by ftp.linux-mips.org with ESMTP
	id S20039084AbWJPIDQ (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 16 Oct 2006 09:03:16 +0100
Received: by nf-out-0910.google.com with SMTP id l23so2398371nfc
        for <linux-mips@linux-mips.org>; Mon, 16 Oct 2006 01:03:15 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:reply-to:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding:from;
        b=jhis+ppxKr8u3aYx7UuLMUEINiT9FQKh1g0EhVWWrgv1rHT7e1fOPatzZ/zCa0BC+lvEeHkFuBA4WPk0kCQJ9o6A4Yt/fVkS735swsHX5rAk/fF3wKT6FzT2NTKLeK1cyYZMhgHFXH9cFqO52FR4/x9FL2e37yf1b74oW0eWtoc=
Received: by 10.48.210.20 with SMTP id i20mr11659367nfg;
        Mon, 16 Oct 2006 01:03:15 -0700 (PDT)
Received: from ?192.168.0.24? ( [81.252.61.1])
        by mx.google.com with ESMTP id v20sm100551nfc.2006.10.16.01.03.15;
        Mon, 16 Oct 2006 01:03:15 -0700 (PDT)
Message-ID: <45333CC1.3090704@innova-card.com>
Date:	Mon, 16 Oct 2006 10:03:13 +0200
Reply-To: Franck <vagabon.xyz@gmail.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
CC:	ralf@linux-mips.org, linux-mips@linux-mips.org
Subject: Re: [PATCH 6/7] setup.c: clean up initrd related code
References: <11607431461469-git-send-email-fbuihuu@gmail.com> <1160743146503-git-send-email-fbuihuu@gmail.com>
In-Reply-To: <1160743146503-git-send-email-fbuihuu@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
From:	Franck Bui-Huu <vagabon.xyz@gmail.com>
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12957
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vagabon.xyz@gmail.com
Precedence: bulk
X-list: linux-mips

Atsushi,

Franck Bui-Huu wrote:
> Signed-off-by: Franck Bui-Huu <fbuihuu@gmail.com>
> ---
[snip]
> @@ -176,24 +174,34 @@ static unsigned long __init init_initrd(
[snip]
>  	end = (unsigned long)&_end;
>  	tmp = PAGE_ALIGN(end) - sizeof(u32) * 2;
>  	if (tmp < end)
>  		tmp += PAGE_SIZE;
>  

Any idea on what is this code for ?
It seems that a minimum gap is needed betweend the end of kernel
code and initrd but I don't see why...

Thanks
		Franck
