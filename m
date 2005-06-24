Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 24 Jun 2005 23:48:48 +0100 (BST)
Received: from wproxy.gmail.com ([IPv6:::ffff:64.233.184.205]:18194 "EHLO
	wproxy.gmail.com") by linux-mips.org with ESMTP id <S8225526AbVFXWsV> convert rfc822-to-8bit;
	Fri, 24 Jun 2005 23:48:21 +0100
Received: by wproxy.gmail.com with SMTP id 57so1646444wri
        for <linux-mips@linux-mips.org>; Fri, 24 Jun 2005 15:47:30 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=nR+RT3VwOgzvXlAj+V1q0uJyYkVTUFTxzYWIZBLiAmn8n9jEm7pgHzAy1XTBa3LFOEEQP1LfwIkGJQ1tMFqzP5G77bhWYwOWAfBjWyvoojqU+YKiHTEyIOtxsx+WnYEbIFuvcv98+2CNNbuX1PYIkNb6CiF09Km8+7KvSju1uMw=
Received: by 10.54.24.34 with SMTP id 34mr1921463wrx;
        Fri, 24 Jun 2005 15:47:30 -0700 (PDT)
Received: by 10.54.71.11 with HTTP; Fri, 24 Jun 2005 15:47:30 -0700 (PDT)
Message-ID: <2db32b7205062415471d0fe4c0@mail.gmail.com>
Date:	Fri, 24 Jun 2005 15:47:30 -0700
From:	rolf liu <rolfliu@gmail.com>
Reply-To: rolf liu <rolfliu@gmail.com>
To:	Andy Isaacson <adi@hexapodia.org>
Subject: Re: glibc based toolchain for mips
Cc:	Prashant Viswanathan <vprashant@echelon.com>,
	linux-mips@linux-mips.org
In-Reply-To: <20050624223915.GB4295@hexapodia.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
References: <5375D9FB1CC3994D9DCBC47C344EEB5905FA4350@miles.echelon.echcorp.com>
	 <20050624223915.GB4295@hexapodia.org>
Return-Path: <rolfliu@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8182
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rolfliu@gmail.com
Precedence: bulk
X-list: linux-mips

That one Debian provides is for big endian. Is there one tool chain
for mips little endian and also gcc 3.*.* ?


On 6/24/05, Andy Isaacson <adi@hexapodia.org> wrote:
> On Fri, Jun 24, 2005 at 03:14:49PM -0700, Prashant Viswanathan wrote:
> > Is it possible to get a free/open glibc based toolchain for MIPS? Buildroot
> > and ucLibc based toolchain seems to work well, but I really need a glibc
> > based toolchain. Though I can use the SDE from MIPS technologies to build
> > the kernel, I can't seem to use it as a toolchain to compile my own
> > applications.
> 
> Debian provides a complete native toolchain with glibc, which I've used
> with great success.  (You will need to do a nfsroot or nbd-root if you
> don't have local storage.)
> 
> -andy
> 
>
