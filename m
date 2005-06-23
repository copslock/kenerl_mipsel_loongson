Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 23 Jun 2005 23:25:21 +0100 (BST)
Received: from wproxy.gmail.com ([IPv6:::ffff:64.233.184.193]:10180 "EHLO
	wproxy.gmail.com") by linux-mips.org with ESMTP id <S8225558AbVFWWZF> convert rfc822-to-8bit;
	Thu, 23 Jun 2005 23:25:05 +0100
Received: by wproxy.gmail.com with SMTP id 57so1087469wri
        for <linux-mips@linux-mips.org>; Thu, 23 Jun 2005 15:24:08 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=lSbK7kRpSm+qLGHuBD97/heRD3kBLXU/ujEg7eOe7MDCgmkypHSERdFs0dvmk3+TlPYItewE4AaNzO6nxTzf8MB6KhDQTtuck6+9zF3p5EUslGIBDUJTtBXIvUOf9arj13U1kDC31I0mfdgdG6lVmWlm66IKwbrHdEZ0z8al5DQ=
Received: by 10.54.67.3 with SMTP id p3mr1455475wra;
        Thu, 23 Jun 2005 15:24:08 -0700 (PDT)
Received: by 10.54.71.11 with HTTP; Thu, 23 Jun 2005 15:24:08 -0700 (PDT)
Message-ID: <2db32b7205062315248d000bb@mail.gmail.com>
Date:	Thu, 23 Jun 2005 15:24:08 -0700
From:	rolf liu <rolfliu@gmail.com>
Reply-To: rolf liu <rolfliu@gmail.com>
To:	Nigel Stephens <nigel@mips.com>
Subject: Re: which 2.6 kernel can be run on db1550?
Cc:	linux-mips@linux-mips.org
In-Reply-To: <42BB33C6.7010707@mips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
References: <2db32b72050623133731f7b098@mail.gmail.com>
	 <ecb4efd1050623144816f7f528@mail.gmail.com>
	 <2db32b72050623150411886bbd@mail.gmail.com>
	 <42BB33C6.7010707@mips.com>
Return-Path: <rolfliu@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8167
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rolfliu@gmail.com
Precedence: bulk
X-list: linux-mips

I used SED to compile 2.4.31. It seems fine. but got no success on 2.6.*



On 6/23/05, Nigel Stephens <nigel@mips.com> wrote:
> 
> 
> rolf liu wrote:
> 
> >Thanks very much for the information.
> >
> >SDE is the toolchain from mips, which is based on gcc 2.96.
> >
> >
> >
> 
> Just a quick warning that you should not be using the "SDE lite" package
> to build a Linux kernel. For that you need the Linux configuration of
> the toolchain, which is described here
> http://www.linux-mips.org/wiki/Toolchains#MIPS_SDE
> 
> 
>
