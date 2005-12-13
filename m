Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 13 Dec 2005 09:40:02 +0000 (GMT)
Received: from zproxy.gmail.com ([64.233.162.199]:65428 "EHLO zproxy.gmail.com")
	by ftp.linux-mips.org with ESMTP id S8133521AbVLMJjm convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 13 Dec 2005 09:39:42 +0000
Received: by zproxy.gmail.com with SMTP id z3so1615152nzf
        for <linux-mips@linux-mips.org>; Tue, 13 Dec 2005 01:40:03 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=L7UpsrffeOmK/U+lw6M440iWnWxmTpxuYXKaFgaK8HPkfBiEnD/iRMk6/q4c/yHcIMlcv0q5f0ooDrTQYO1SHpZufR/fzoOeQksFB7igSF98+YPJlOIk1T2nevbiYBdkJSestGoq+p1j28PSx+J5rqoxjQTgU3ytCWpoGFwR2yI=
Received: by 10.36.222.58 with SMTP id u58mr7078585nzg;
        Tue, 13 Dec 2005 01:40:02 -0800 (PST)
Received: by 10.36.57.4 with HTTP; Tue, 13 Dec 2005 01:40:02 -0800 (PST)
Message-ID: <4955666b0512130140i4829be04s@mail.gmail.com>
Date:	Tue, 13 Dec 2005 18:40:02 +0900
From:	Yoichi Yuasa <yyuasa@gmail.com>
To:	colin <colin@realtek.com.tw>
Subject: Re: To put Linux kernel as closer as possible to 0x80000000
Cc:	linux-mips@linux-mips.org
In-Reply-To: <017301c5ffc7$80383830$106215ac@realtek.com.tw>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
References: <017301c5ffc7$80383830$106215ac@realtek.com.tw>
Return-Path: <yyuasa@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9663
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yyuasa@gmail.com
Precedence: bulk
X-list: linux-mips

Hi

It has no problem.
Kernel has reserved space for exception handlers.

Yoichi

2005/12/13, colin <colin@realtek.com.tw>:
>
> Hi all,
> We want to put Linux kernel as closer as possible to the bottom of memory.
> I know that there is some stuff put in the beginning of memory, like
> Exception table.
> So, what's the closest address to 0x80000000 that is allowable to store
> kernel?
>
> Regards,
> Colin
>
>
>
>
>
>
