Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 22 Dec 2005 13:28:47 +0000 (GMT)
Received: from lennier.cc.vt.edu ([198.82.162.213]:20932 "EHLO
	lennier.cc.vt.edu") by ftp.linux-mips.org with ESMTP
	id S8133736AbVLVN23 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 22 Dec 2005 13:28:29 +0000
Received: from zidane.cc.vt.edu (IDENT:mirapoint@evil-zidane.cc.vt.edu [10.1.1.13])
	by lennier.cc.vt.edu (8.12.11/8.12.11) with ESMTP id jBMDTcc3017239;
	Thu, 22 Dec 2005 08:29:38 -0500
Received: from [192.168.1.2] (blacksburg-bsr1-69-170-32-128.chvlva.adelphia.net [69.170.32.128])
	by zidane.cc.vt.edu (MOS 3.6.4-CR)
	with ESMTP id ETL32796 (AUTH spbecker);
	Thu, 22 Dec 2005 08:29:36 -0500 (EST)
Message-ID: <43AAAA3F.1090302@gentoo.org>
Date:	Thu, 22 Dec 2005 08:29:35 -0500
From:	"Stephen P. Becker" <geoman@gentoo.org>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051204)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To:	zhuzhenhua <zzh.hust@gmail.com>
CC:	linux-mips@linux-mips.org
Subject: Re: does someone succeed in making the toolchain for 2.6 kernel?
References: <50c9a2250512210051q85f813fx27b0533fe66165e2@mail.gmail.com>	 <20051221085539.GS13985@lug-owl.de>	 <50c9a2250512210104j4a19e37cu30c795d4acc226d2@mail.gmail.com>	 <20051221091852.GT13985@lug-owl.de>	 <1135159354.5211.1.camel@localhost.localdomain>	 <20051221100619.GW13985@lug-owl.de>	 <1135161136.5211.8.camel@localhost.localdomain> <50c9a2250512211843o469601e4p557f4645dd721949@mail.gmail.com>
In-Reply-To: <50c9a2250512211843o469601e4p557f4645dd721949@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <geoman@gentoo.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9733
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: geoman@gentoo.org
Precedence: bulk
X-list: linux-mips

> i have use the crosstool to try,but i get a
> "#error "glibc cannot be compiled without optimization"
> what CFLAGS and CXXFLAGS should  to set in demo-mipsel.sh
> 
> BR,
> zhuzhenhua


Do you only want to build kernels, or do you want to build userland 
stuff also?  You have indicated the former, but not the latter, in which 
case you really only need binutils and gcc (a static, C-only bootstrap 
gcc works fine for compiling a kernel).

-Steve
