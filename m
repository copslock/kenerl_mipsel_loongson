Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 11 Mar 2005 18:26:33 +0000 (GMT)
Received: from wproxy.gmail.com ([IPv6:::ffff:64.233.184.199]:56410 "EHLO
	wproxy.gmail.com") by linux-mips.org with ESMTP id <S8225359AbVCKS0R>;
	Fri, 11 Mar 2005 18:26:17 +0000
Received: by wproxy.gmail.com with SMTP id 37so765328wra
        for <linux-mips@linux-mips.org>; Fri, 11 Mar 2005 10:26:11 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=ZFNftM3Tyk10cH01geGk/FYd+mL79AoYhkhMN1dlacCwt8zIFNL67EBzDIp03kueW6qYwj+3cNlDOWOPu1MS7CXlag1xIdJpMF4t4Xu3WurYOZHSOJECLJxdCbkgrFzFDVhi1hLGJvtS9utchxpKdsOaYHm8/+KOrEHD7wYLpL4=
Received: by 10.54.49.36 with SMTP id w36mr1279795wrw;
        Fri, 11 Mar 2005 10:26:11 -0800 (PST)
Received: by 10.54.56.8 with HTTP; Fri, 11 Mar 2005 10:26:11 -0800 (PST)
Message-ID: <77fd3fe005031110261fd30c29@mail.gmail.com>
Date:	Fri, 11 Mar 2005 10:26:11 -0800
From:	Linux Mailinglist <mailinglist.linux@gmail.com>
Reply-To: Linux Mailinglist <mailinglist.linux@gmail.com>
To:	Ralf Baechle <ralf@linux-mips.org>
Subject: Re: Linux 2.6 support for Brecis MSP2100 processor !
Cc:	Manish Lachwani <mlachwani@mvista.com>, ppopov@embeddedalley.com,
	linux-mips@linux-mips.org
In-Reply-To: <20050311143502.GB5958@linux-mips.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <77fd3fe0050308202654a4432a@mail.gmail.com>
	 <20050309173044.GA18688@linux-mips.org>
	 <77fd3fe00503101746fed176b@mail.gmail.com>
	 <4230FAC9.6040304@embeddedalley.com> <4230FEED.9090402@mvista.com>
	 <20050311143502.GB5958@linux-mips.org>
Return-Path: <mailinglist.linux@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7425
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mailinglist.linux@gmail.com
Precedence: bulk
X-list: linux-mips

Thanks everiybody. I think I should go ahead and start doing it myself. 

Srinivasan


On Fri, 11 Mar 2005 14:35:02 +0000, Ralf Baechle <ralf@linux-mips.org> wrote:
> On Thu, Mar 10, 2005 at 06:14:05PM -0800, Manish Lachwani wrote:
> 
> > 4Km is a 4Kc without TLB. I think this is supported.
> 
> Maybe at uclinux.org but certainly not on linux-mips.org.  There have never
> been many requests for Linux on TLB-less processors and in recent years
> the interest that low interest seems to have fallen even further.
> 
> That said, if anybody wants to working on supporting MIPS with
> CONFIG_MMU=n by all means, go ahead.
> 
>  Ralf
>
