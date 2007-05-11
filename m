Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 11 May 2007 13:27:33 +0100 (BST)
Received: from py-out-1112.google.com ([64.233.166.183]:32842 "EHLO
	py-out-1112.google.com") by ftp.linux-mips.org with ESMTP
	id S20022611AbXEKM1c (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 11 May 2007 13:27:32 +0100
Received: by py-out-1112.google.com with SMTP id u52so768435pyb
        for <linux-mips@linux-mips.org>; Fri, 11 May 2007 05:26:30 -0700 (PDT)
DKIM-Signature:	a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=tOLfcHRi38+wOICMN0aReWKT7Z5o6Eqei67hf8tUyn/WkX11SIMr5AIrkMsG99Vn12nwfPl6PaUHX8SjKeIgh6MerIQgLseYzEuVVbiDYlHFOG1T5ESsAnbImTvdW2fb4OKnBbRNxqsIzEAeu7QUtIYPstf8zKQkym+m1WLINd8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=aH0AtztGMkd2foF8pqXW5pmJsq4PXj57az4+oF2JZqRCBJTFIuwjOPkgpK5WmExLLJXsbV+u0dNwqYagqz/AGUnO4thLxoQ2hVkEfIaDCo7Cb8GLTwLwwqzajxDr8GPcc8HVkgItMm5op/X2WFVmoUBLE1vwxTrfPXKYbj2zmks=
Received: by 10.65.251.17 with SMTP id d17mr2490332qbs.1178886390414;
        Fri, 11 May 2007 05:26:30 -0700 (PDT)
Received: by 10.65.241.19 with HTTP; Fri, 11 May 2007 05:26:30 -0700 (PDT)
Message-ID: <cda58cb80705110526m776deb7pe43be2e57ce90fbb@mail.gmail.com>
Date:	Fri, 11 May 2007 14:26:30 +0200
From:	"Franck Bui-Huu" <vagabon.xyz@gmail.com>
To:	"Ralf Baechle" <ralf@linux-mips.org>
Subject: Re: [PATCH 2/3] time: replace board_time_init() by plat_clk_setup()
Cc:	"Atsushi Nemoto" <anemo@mba.ocn.ne.jp>, linux-mips@linux-mips.org
In-Reply-To: <20070511114138.GH2732@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <1178293006633-git-send-email-fbuihuu@gmail.com>
	 <11782930063123-git-send-email-fbuihuu@gmail.com>
	 <20070506.010313.41199101.anemo@mba.ocn.ne.jp>
	 <20070511114138.GH2732@linux-mips.org>
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15037
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vagabon.xyz@gmail.com
Precedence: bulk
X-list: linux-mips

Hi Ralf !

On 5/11/07, Ralf Baechle <ralf@linux-mips.org> wrote:
> On Sun, May 06, 2007 at 01:03:13AM +0900, Atsushi Nemoto wrote:
>
> > How about keeping board_time_init pointer as is and adding
> > plat_clk_setup only for simple platforms?
>
> The idea of having such function pointer is quite nice.  In theory.  In

what about using function with weak attribute instead ? There's no
more need for a function pointer and no needs to initialise it too...

> practice it seems alot of people who are bringing up Linux on a new
> platform miss those hooks.  A new mandatory platform hook that if missing
> is resulting in a linker error is preferable, I think.
>

Ok, but do you agree that we now need to call this hook earlier during
the boot process ?

Thanks
-- 
               Franck
