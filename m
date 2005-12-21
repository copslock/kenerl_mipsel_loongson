Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 21 Dec 2005 10:26:28 +0000 (GMT)
Received: from [62.38.104.168] ([62.38.104.168]:22959 "EHLO pfn3.pefnos")
	by ftp.linux-mips.org with ESMTP id S3458540AbVLUK0K (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 21 Dec 2005 10:26:10 +0000
Received: from xorhgos2.pefnos (xorhgos2.pefnos [192.168.0.3])
	by pfn3.pefnos (Postfix) with ESMTP id 00FCC1F101;
	Wed, 21 Dec 2005 12:27:11 +0200 (EET)
From:	"P. Christeas" <p_christ@hol.gr>
To:	linux-mips@linux-mips.org
Subject: Re: does someone succeed in making the toolchain for 2.6 kernel?
Date:	Wed, 21 Dec 2005 12:27:07 +0200
User-Agent: KMail/1.9
Cc:	Jan-Benedict Glaw <jbglaw@lug-owl.de>
References: <50c9a2250512210051q85f813fx27b0533fe66165e2@mail.gmail.com> <50c9a2250512210104j4a19e37cu30c795d4acc226d2@mail.gmail.com> <20051221091852.GT13985@lug-owl.de>
In-Reply-To: <20051221091852.GT13985@lug-owl.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200512211227.08501.p_christ@hol.gr>
Return-Path: <p_christ@hol.gr>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9710
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: p_christ@hol.gr
Precedence: bulk
X-list: linux-mips

> On Wed, 2005-12-21 17:04:25 +0800, zhuzhenhua <zzh.hust@gmail.com> wrote:
> > sorry to not describle clearly
> > i want to know how to build the cross-compile toolchain
>
> Building a working toolchain for kernel-only work isn't _that_ hard
> (though, if you've never done that, you may find yourself asking
> Google for a month or two...)
>
> As a good starting point, go to http://www.kegel.com/crosstool/ .
>

I have been using the toolchain of OpenWRT. (it builds uClibs rather than 
glibc)

However, I am noting some instability of the system and that *could* be 
because of gcc. I am reading that you also have some trouble with the 
instructions it generates.
