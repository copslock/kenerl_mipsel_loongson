Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 21 Dec 2005 09:05:46 +0000 (GMT)
Received: from wproxy.gmail.com ([64.233.184.192]:18820 "EHLO wproxy.gmail.com")
	by ftp.linux-mips.org with ESMTP id S8133718AbVLUJF3 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 21 Dec 2005 09:05:29 +0000
Received: by wproxy.gmail.com with SMTP id 36so84607wra
        for <linux-mips@linux-mips.org>; Wed, 21 Dec 2005 01:06:37 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=KpLvYIeGRfy3RAzqZpw2ZY5wlM7ERtMQNsyb5DLwRsC7ymHlkbSsptSw9NU+xtvDHP/C2WJR9/OttnlHsn3lsAdZHNcuOGH2fq1b0+V1BMHMu1MbTFnp6KLWuYjDDpIfUBtgQxPexnPWur0l8qBtm/8mnGXdAYuwYizkd9ynqLQ=
Received: by 10.54.105.16 with SMTP id d16mr556214wrc;
        Wed, 21 Dec 2005 01:06:36 -0800 (PST)
Received: by 10.54.156.5 with HTTP; Wed, 21 Dec 2005 01:06:36 -0800 (PST)
Message-ID: <50c9a2250512210106h7bca5c7fu5714ea3aa16cde8a@mail.gmail.com>
Date:	Wed, 21 Dec 2005 17:06:36 +0800
From:	zhuzhenhua <zzh.hust@gmail.com>
To:	ppopov@embeddedalley.com
Subject: Re: does someone succeed in making the toolchain for 2.6 kernel?
Cc:	"linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
In-Reply-To: <1135155432.9009.18.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
References: <50c9a2250512210051q85f813fx27b0533fe66165e2@mail.gmail.com>
	 <1135155432.9009.18.camel@localhost.localdomain>
Return-Path: <zzh.hust@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9704
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: zzh.hust@gmail.com
Precedence: bulk
X-list: linux-mips

i am not sure which toolchain can work for the 2.6 kernel
can you suggest one?
thanks

On 12/21/05, Pete Popov <ppopov@embeddedalley.com> wrote:
> On Wed, 2005-12-21 at 16:51 +0800, zhuzhenhua wrote:
> > i want to compile a 2.6.14 kernel for mips 4kec, does someone compile
> > the 2.6 kernel with self-build toolchain?
>
> Quite a few people have, I'm sure.
>
> > how to select the gcc,
> > gdb,glibc,linux head and binutils version?
> > and where to get the guide doc?
>
> If you have such questions, I would suggest you start by compiling and
> booting your kernel with a toolchain and distribution that already
> works. Build your own toolchain, if you must, later.
>
> Pete
>
>

Best regards
zhuzhenhua
