Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 25 Jun 2005 00:37:25 +0100 (BST)
Received: from wproxy.gmail.com ([IPv6:::ffff:64.233.184.200]:10527 "EHLO
	wproxy.gmail.com") by linux-mips.org with ESMTP id <S8225609AbVFXXhA> convert rfc822-to-8bit;
	Sat, 25 Jun 2005 00:37:00 +0100
Received: by wproxy.gmail.com with SMTP id 57so1663004wri
        for <linux-mips@linux-mips.org>; Fri, 24 Jun 2005 16:35:25 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=oHEnOdkIBmdfjs4J/1o3xGpa6+AsiFK70u9FmuGkVI9XejpwgpH2DUu7bF1DpUp459FiM6BKhiQAjJSfLl6W7BvMxfTGlRikoTuYz7FuBgfSkab+90xBWZTSF7FYZbB6+oNE7brQQS3MB/EIWCfBfsMeNUIpLR0dVtxt1x84oaI=
Received: by 10.54.40.58 with SMTP id n58mr2126668wrn;
        Fri, 24 Jun 2005 16:35:25 -0700 (PDT)
Received: by 10.54.71.11 with HTTP; Fri, 24 Jun 2005 16:35:25 -0700 (PDT)
Message-ID: <2db32b7205062416352a9c5a7@mail.gmail.com>
Date:	Fri, 24 Jun 2005 16:35:25 -0700
From:	rolf liu <rolfliu@gmail.com>
Reply-To: rolf liu <rolfliu@gmail.com>
To:	Andy Isaacson <adi@hexapodia.org>
Subject: Re: glibc based toolchain for mips
Cc:	Prashant Viswanathan <vprashant@echelon.com>,
	linux-mips@linux-mips.org
In-Reply-To: <20050624231023.GA5428@hexapodia.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
References: <5375D9FB1CC3994D9DCBC47C344EEB5905FA4350@miles.echelon.echcorp.com>
	 <20050624223915.GB4295@hexapodia.org>
	 <2db32b7205062415471d0fe4c0@mail.gmail.com>
	 <20050624231023.GA5428@hexapodia.org>
Return-Path: <rolfliu@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8186
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rolfliu@gmail.com
Precedence: bulk
X-list: linux-mips

Could you give me a link to the mipsle cross tool chain? I can only
find the BE cross tool chain.


On 6/24/05, Andy Isaacson <adi@hexapodia.org> wrote:
> On Fri, Jun 24, 2005 at 03:47:30PM -0700, rolf liu wrote:
> > That one Debian provides is for big endian. Is there one tool chain
> > for mips little endian and also gcc 3.*.* ?
> 
> Debian has a BE "mips" port and a LE "mipsel" port.  They should both
> work (though I've only used the BE version myself) and are routinely
> tested...  in fact AFAIK the package build machines are self-hosting.
> 
> -andy
>
