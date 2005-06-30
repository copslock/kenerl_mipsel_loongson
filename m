Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 30 Jun 2005 23:59:21 +0100 (BST)
Received: from wproxy.gmail.com ([IPv6:::ffff:64.233.184.206]:21401 "EHLO
	wproxy.gmail.com") by linux-mips.org with ESMTP id <S8226113AbVF3W7E> convert rfc822-to-8bit;
	Thu, 30 Jun 2005 23:59:04 +0100
Received: by wproxy.gmail.com with SMTP id 70so227457wra
        for <linux-mips@linux-mips.org>; Thu, 30 Jun 2005 15:58:47 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=n4vr7hD5xXv3+r/DqTqr4bzsoFtgTS5ehGktDs/lXKpbyLWuuRfc+G4AIM9JOLl6VtZqQPpcP84Ly4xDnQ1xRbXrBXeo6c4PriPVjgMyq29ftoYP34L9bTXSSKuHZkGN1HT85tnLjjK7iT6yFbmI3AAZFp6mJxjtiKjKT+bx1Jo=
Received: by 10.54.16.28 with SMTP id 28mr748370wrp;
        Thu, 30 Jun 2005 15:58:46 -0700 (PDT)
Received: by 10.54.71.11 with HTTP; Thu, 30 Jun 2005 15:58:46 -0700 (PDT)
Message-ID: <2db32b72050630155831582cd7@mail.gmail.com>
Date:	Thu, 30 Jun 2005 15:58:46 -0700
From:	rolf liu <rolfliu@gmail.com>
Reply-To: rolf liu <rolfliu@gmail.com>
To:	Wolfgang Denk <wd@denx.de>
Subject: Re: glibc based toolchain for mips
Cc:	Andy Isaacson <adi@hexapodia.org>,
	Prashant Viswanathan <vprashant@echelon.com>,
	linux-mips@linux-mips.org
In-Reply-To: <20050625002329.C0A7FC1510@atlas.denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
References: <2db32b7205062415471d0fe4c0@mail.gmail.com>
	 <20050625002329.C0A7FC1510@atlas.denx.de>
Return-Path: <rolfliu@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8280
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rolfliu@gmail.com
Precedence: bulk
X-list: linux-mips

Hi, Wolfgang,

I download the package. after installation,  the 4KCle is still
linking to the mips-linux-, which is big-endian.
thanks


On 6/24/05, Wolfgang Denk <wd@denx.de> wrote:
> In message <2db32b7205062415471d0fe4c0@mail.gmail.com> you wrote:
> > That one Debian provides is for big endian. Is there one tool chain
> > for mips little endian and also gcc 3.*.* ?
> 
> The mips_4KCle packages in the ELDK are for mips little endian; we
> use 3.3.3; see http://www.denx.de/ELDK.html
> 
> Best regards,
> 
> Wolfgang Denk
> 
> --
> Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
> Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
> Einstein argued that there must be simplified explanations of nature,
> because God is not capricious or arbitrary. No  such  faith  comforts
> the software engineer.                             - Fred Brooks, Jr.
>
