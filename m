Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 13 Oct 2006 09:23:27 +0100 (BST)
Received: from nf-out-0910.google.com ([64.233.182.187]:15666 "EHLO
	nf-out-0910.google.com") by ftp.linux-mips.org with ESMTP
	id S20038685AbWJMIXZ (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 13 Oct 2006 09:23:25 +0100
Received: by nf-out-0910.google.com with SMTP id a25so795611nfc
        for <linux-mips@linux-mips.org>; Fri, 13 Oct 2006 01:23:25 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:reply-to:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding:from;
        b=nJbfjHvzsNnu2GHfYQmLVPw8V0sLN+VGW4xTPkT9S8k3TzM1a416q12Rmhaf1i0YfZD8ol5kbsl1L/Ew4dveaNfjJW8YoJz/9/rmUjejqrBW6Ue9O3T9yiFjxOpCZxOJ14Tsb94na3MOQa2efnK8av8bjyKokpAEO+pOrtvNhFU=
Received: by 10.49.80.12 with SMTP id h12mr6575513nfl;
        Fri, 13 Oct 2006 01:23:24 -0700 (PDT)
Received: from ?192.168.0.24? ( [81.252.61.1])
        by mx.google.com with ESMTP id m16sm367791nfc.2006.10.13.01.23.23;
        Fri, 13 Oct 2006 01:23:24 -0700 (PDT)
Message-ID: <452F4CF8.6070809@innova-card.com>
Date:	Fri, 13 Oct 2006 10:23:20 +0200
Reply-To: Franck <vagabon.xyz@gmail.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To:	Franck Bui-Huu <vagabon.xyz@gmail.com>
CC:	ralf@linux-mips.org, anemo@mba.ocn.ne.jp, ths@networkno.de,
	linux-mips@linux-mips.org, Franck Bui-Huu <fbuihuu@gmail.com>
Subject: Re: [PATCH 3/5] setup.c: clean up initrd related code
References: <1160568525897-git-send-email-fbuihuu@gmail.com> <11605685251791-git-send-email-fbuihuu@gmail.com>
In-Reply-To: <11605685251791-git-send-email-fbuihuu@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
From:	Franck Bui-Huu <vagabon.xyz@gmail.com>
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12925
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vagabon.xyz@gmail.com
Precedence: bulk
X-list: linux-mips

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

BTW, can anybody tell me what that bit of code is for ?
It seems that a minumum gap is needed betweend the end of kernel
code and initrd but I don't see why ?

Thanks
		Franck
