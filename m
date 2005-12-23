Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 23 Dec 2005 04:45:10 +0000 (GMT)
Received: from wproxy.gmail.com ([64.233.184.192]:1590 "EHLO wproxy.gmail.com")
	by ftp.linux-mips.org with ESMTP id S8133364AbVLWEow (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 23 Dec 2005 04:44:52 +0000
Received: by wproxy.gmail.com with SMTP id 36so512537wra
        for <linux-mips@linux-mips.org>; Thu, 22 Dec 2005 20:46:10 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=MmtrseeskV1y1rjQ8du9qf7+993dbTFNPA4Et4ywho7W1nUuk4lTMCJ3VKS+KMx1PFoDz4CXkPedveBUItko32L8mz/mxkgjOQccC6HHY8q8LkvDvgg1j76gUGqffbYa58MNJ+ZVGXk62INaDjGMRxziSHRjfkY1YKGnCFVViT8=
Received: by 10.54.133.9 with SMTP id g9mr2958455wrd;
        Thu, 22 Dec 2005 20:46:10 -0800 (PST)
Received: by 10.54.156.5 with HTTP; Thu, 22 Dec 2005 20:46:10 -0800 (PST)
Message-ID: <50c9a2250512222046i4bdc0bc1y2d5f04e4852f6624@mail.gmail.com>
Date:	Fri, 23 Dec 2005 12:46:10 +0800
From:	zhuzhenhua <zzh.hust@gmail.com>
To:	"Stephen P. Becker" <geoman@gentoo.org>
Subject: Re: does someone succeed in making the toolchain for 2.6 kernel?
Cc:	linux-mips@linux-mips.org
In-Reply-To: <43AAAA3F.1090302@gentoo.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <50c9a2250512210051q85f813fx27b0533fe66165e2@mail.gmail.com>
	 <20051221085539.GS13985@lug-owl.de>
	 <50c9a2250512210104j4a19e37cu30c795d4acc226d2@mail.gmail.com>
	 <20051221091852.GT13985@lug-owl.de>
	 <1135159354.5211.1.camel@localhost.localdomain>
	 <20051221100619.GW13985@lug-owl.de>
	 <1135161136.5211.8.camel@localhost.localdomain>
	 <50c9a2250512211843o469601e4p557f4645dd721949@mail.gmail.com>
	 <43AAAA3F.1090302@gentoo.org>
Return-Path: <zzh.hust@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9734
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: zzh.hust@gmail.com
Precedence: bulk
X-list: linux-mips

On 12/22/05, Stephen P. Becker <geoman@gentoo.org> wrote:
> > i have use the crosstool to try,but i get a
> > "#error "glibc cannot be compiled without optimization"
> > what CFLAGS and CXXFLAGS should  to set in demo-mipsel.sh
> >
> > BR,
> > zhuzhenhua
>
>
> Do you only want to build kernels, or do you want to build userland
> stuff also?  You have indicated the former, but not the latter, in which
> case you really only need binutils and gcc (a static, C-only bootstrap
> gcc works fine for compiling a kernel).
>
> -Steve
>
sorry to not discribe clearly, i want to build the toolchain both for
kernel nand userland stuff.

and i succeed now  using the crosstool with Matej Kupljen's advices.
thanks all！

best regards

zhuzhenhua
