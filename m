Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 01 Sep 2005 04:25:55 +0100 (BST)
Received: from zproxy.gmail.com ([IPv6:::ffff:64.233.162.194]:47371 "EHLO
	zproxy.gmail.com") by linux-mips.org with ESMTP id <S8224859AbVIADZg> convert rfc822-to-8bit;
	Thu, 1 Sep 2005 04:25:36 +0100
Received: by zproxy.gmail.com with SMTP id 13so190823nzn
        for <linux-mips@linux-mips.org>; Wed, 31 Aug 2005 20:31:46 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=cPf7z3qpLhbw7v+LvUUcuJ3hH6EB0kNezpWQP3WRxL5+AjV0MCttDYAkX2lleQ3abgg5SJtbzurU/HY5BlxwwivMQuA3tt5hFMVTUzczMi1+jJx76ZvT+k3os6AVfM2RM0U9qDT97vHQuMyn+/bHJ4v90xARIxKvG4MoRA275NY=
Received: by 10.36.80.12 with SMTP id d12mr1266653nzb;
        Wed, 31 Aug 2005 20:31:46 -0700 (PDT)
Received: by 10.36.59.12 with HTTP; Wed, 31 Aug 2005 20:31:46 -0700 (PDT)
Message-ID: <4955666b050831203143785a7f@mail.gmail.com>
Date:	Thu, 1 Sep 2005 12:31:46 +0900
From:	Yoichi Yuasa <yyuasa@gmail.com>
To:	Zhuang Yuyao <ihollo@tom.com>
Subject: Re: [ADMtek 5120] 64M sdram on board but only 16M is deteted and usable
Cc:	linux-mips@linux-mips.org
In-Reply-To: <431671CF.8070906@tom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
References: <431671CF.8070906@tom.com>
Return-Path: <yyuasa@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8850
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yyuasa@gmail.com
Precedence: bulk
X-list: linux-mips

Hi,

2005/9/1, Zhuang Yuyao <ihollo@tom.com>:
> Hi,
> 
> I've just upgraded the SDRAM on my adm5120 board from 16M to 64M, but
> while the board is booting, it still reports that only 16M sdram is
> availible.
> Since I do not have the source code of the bootloader, is there any way
> to let the board to boot with 64M sdram, or should I change to another
> bootloader?

If you are using add_memory_region() with fixed memory size,
you should change the value of it.

Yoichi
