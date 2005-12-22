Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 22 Dec 2005 09:29:45 +0000 (GMT)
Received: from wproxy.gmail.com ([64.233.184.205]:24291 "EHLO wproxy.gmail.com")
	by ftp.linux-mips.org with ESMTP id S8133355AbVLVJ32 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 22 Dec 2005 09:29:28 +0000
Received: by wproxy.gmail.com with SMTP id 36so316900wra
        for <linux-mips@linux-mips.org>; Thu, 22 Dec 2005 01:30:42 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=KfNpF71xEFPCNLOUR0da0xGeVJGeLplYU00sJupyepChtp+OH5PIEIpPnOoTltab/YFLhZEhjx4VaBR+tSB2S02rjQ2OKdkh9UPu3m+1hVfyAZckxDdoIgf62rrbeb5/u81h7KSoHnhAsplhqLkiR+yz5q+2OSOXdL3cypL6dn8=
Received: by 10.54.156.18 with SMTP id d18mr1904021wre;
        Thu, 22 Dec 2005 01:30:42 -0800 (PST)
Received: by 10.54.156.5 with HTTP; Thu, 22 Dec 2005 01:30:42 -0800 (PST)
Message-ID: <50c9a2250512220130k6d4330acsc8cf4325771ba73c@mail.gmail.com>
Date:	Thu, 22 Dec 2005 17:30:42 +0800
From:	zhuzhenhua <zzh.hust@gmail.com>
To:	Matej Kupljen <matej.kupljen@ultra.si>
Subject: Re: does someone succeed in making the toolchain for 2.6 kernel?
Cc:	Jan-Benedict Glaw <jbglaw@lug-owl.de>, linux-mips@linux-mips.org
In-Reply-To: <1135243398.6902.3.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
References: <50c9a2250512210051q85f813fx27b0533fe66165e2@mail.gmail.com>
	 <20051221085539.GS13985@lug-owl.de>
	 <50c9a2250512210104j4a19e37cu30c795d4acc226d2@mail.gmail.com>
	 <20051221091852.GT13985@lug-owl.de>
	 <1135159354.5211.1.camel@localhost.localdomain>
	 <20051221100619.GW13985@lug-owl.de>
	 <1135161136.5211.8.camel@localhost.localdomain>
	 <50c9a2250512211843o469601e4p557f4645dd721949@mail.gmail.com>
	 <1135243398.6902.3.camel@localhost.localdomain>
Return-Path: <zzh.hust@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9727
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: zzh.hust@gmail.com
Precedence: bulk
X-list: linux-mips

On 12/22/05, Matej Kupljen <matej.kupljen@ultra.si> wrote:
> Hi
>
> > i have use the crosstool to try,but i get a
> > "#error "glibc cannot be compiled without optimization"
> > what CFLAGS and CXXFLAGS should  to set in demo-mipsel.sh
>
> If you mean mipsel.dat then I have this defined:
>
> KERNELCONFIG=`pwd`/mipsel.config
> TARGET=mipsel-linux
> TARGET_CFLAGS="-O2 -finline-limit=10000"
> GCC_EXTRA_CONFIG="--with-float=soft"
> GLIBC_EXTRA_CONFIG="--without-fp"
> BINUTILS_EXTRA_CONFIG="--enable-shared"
>
> Note, I have additional patches for "real SF".
>
> I have no flags set in demo-mipsel.sh
>
> BR,
> Matej
>
>

thanks,
another question: do you change the demo-mipsel.sh to eval another sh or just
keep the
 eval `cat mipsel.dat gcc-3.4.2-glibc-2.2.5.dat`        sh all.sh --notest

Best Regards

zhuzhenhua
