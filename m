Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 22 Dec 2005 09:21:20 +0000 (GMT)
Received: from deliver-1.mx.triera.net ([213.161.0.31]:55506 "HELO
	deliver-1.mx.triera.net") by ftp.linux-mips.org with SMTP
	id S8133355AbVLVJVD (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 22 Dec 2005 09:21:03 +0000
Received: from localhost (in-2.mx.triera.net [213.161.0.26])
	by deliver-1.mx.triera.net (Postfix) with ESMTP id B9FA8C06D;
	Thu, 22 Dec 2005 10:22:11 +0100 (CET)
Received: from smtp.triera.net (smtp.triera.net [213.161.0.30])
	by in-2.mx.triera.net (Postfix) with SMTP id C26011BC07B;
	Thu, 22 Dec 2005 10:22:13 +0100 (CET)
Received: from [172.18.1.53] (unknown [213.161.20.162])
	by smtp.triera.net (Postfix) with ESMTP id 080F71A18BA;
	Thu, 22 Dec 2005 10:22:14 +0100 (CET)
Subject: Re: does someone succeed in making the toolchain for 2.6 kernel?
From:	Matej Kupljen <matej.kupljen@ultra.si>
To:	zhuzhenhua <zzh.hust@gmail.com>
Cc:	Jan-Benedict Glaw <jbglaw@lug-owl.de>, linux-mips@linux-mips.org
In-Reply-To: <50c9a2250512211843o469601e4p557f4645dd721949@mail.gmail.com>
References: <50c9a2250512210051q85f813fx27b0533fe66165e2@mail.gmail.com>
	 <20051221085539.GS13985@lug-owl.de>
	 <50c9a2250512210104j4a19e37cu30c795d4acc226d2@mail.gmail.com>
	 <20051221091852.GT13985@lug-owl.de>
	 <1135159354.5211.1.camel@localhost.localdomain>
	 <20051221100619.GW13985@lug-owl.de>
	 <1135161136.5211.8.camel@localhost.localdomain>
	 <50c9a2250512211843o469601e4p557f4645dd721949@mail.gmail.com>
Content-Type: text/plain
Date:	Thu, 22 Dec 2005 10:23:18 +0100
Message-Id: <1135243398.6902.3.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: Triera AV Service
Return-Path: <matej.kupljen@ultra.si>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9726
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: matej.kupljen@ultra.si
Precedence: bulk
X-list: linux-mips

Hi

> i have use the crosstool to try,but i get a
> "#error "glibc cannot be compiled without optimization"
> what CFLAGS and CXXFLAGS should  to set in demo-mipsel.sh

If you mean mipsel.dat then I have this defined:

KERNELCONFIG=`pwd`/mipsel.config
TARGET=mipsel-linux
TARGET_CFLAGS="-O2 -finline-limit=10000"
GCC_EXTRA_CONFIG="--with-float=soft"
GLIBC_EXTRA_CONFIG="--without-fp"
BINUTILS_EXTRA_CONFIG="--enable-shared"

Note, I have additional patches for "real SF".

I have no flags set in demo-mipsel.sh

BR,
Matej
