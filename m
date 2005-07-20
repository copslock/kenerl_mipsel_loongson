Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 20 Jul 2005 05:23:55 +0100 (BST)
Received: from zproxy.gmail.com ([IPv6:::ffff:64.233.162.205]:43890 "EHLO
	zproxy.gmail.com") by linux-mips.org with ESMTP id <S8224774AbVGTEXg> convert rfc822-to-8bit;
	Wed, 20 Jul 2005 05:23:36 +0100
Received: by zproxy.gmail.com with SMTP id r28so1329355nza
        for <linux-mips@linux-mips.org>; Tue, 19 Jul 2005 21:25:18 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=E4NMp+dIZnedw0pU3XNEr2nMiwet2QEQ2m0p0bXxPxi3uZsn1irc1vkxnrGi8EK3wZr1pqM0sWsRchWsCYZTsO66+Ppaq6pbd9VRgrZ6vpEJUpaCwVNF6fMlQ74YaWojWacX85OKtXzRfjrmsKyDzVeoTWh/Q2/0Z3DPUy8xtE4=
Received: by 10.36.105.13 with SMTP id d13mr1487256nzc;
        Tue, 19 Jul 2005 21:24:52 -0700 (PDT)
Received: by 10.36.160.10 with HTTP; Tue, 19 Jul 2005 21:24:51 -0700 (PDT)
Message-ID: <6097c490507192124647cd9b3@mail.gmail.com>
Date:	Wed, 20 Jul 2005 04:24:51 +0000
From:	Maxim Osipov <maxim.osipov@gmail.com>
Reply-To: maxim@mox.ru
To:	Daniel Jacobowitz <dan@debian.org>
Subject: Re: remote debugging: "Reply contains invalid hex digit 59"
Cc:	Bryan Althouse <bryan.althouse@3phoenix.com>,
	Linux/MIPS Development <linux-mips@linux-mips.org>
In-Reply-To: <20050719143911.GA3684@nevyn.them.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
References: <20050719135122Z8226926-3678+3493@linux-mips.org>
	 <20050719143911.GA3684@nevyn.them.org>
Return-Path: <maxim.osipov@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8570
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: maxim.osipov@gmail.com
Precedence: bulk
X-list: linux-mips

Daniel,

At the time when I was looking into this problem, I was unable to find
any patches. Could you please point me to one?

BR,
Maxim

On 7/19/05, Daniel Jacobowitz <dan@debian.org> wrote:
> On Tue, Jul 19, 2005 at 09:52:57AM -0400, Bryan Althouse wrote:
> >
> > Is anyone doing remote debugging for mips?
> >
> > I start the gdbserver on mips with:
> >     gdbserver 192.168.2.39:2222 ./hello_loop
> > This produces:
> >     Process ./hello_loop created; pid = 158
> >
> > On my PC, I type:
> >     ddd --debugger mips64-linux-gnu-gdb hello_loop
> >     (at gdb prompt) target remote 192.168.2.55:2222
> 
> Gdbserver doesn't have MIPS64 support merged.  Assuming you're using
> MIPS64, as suggested by the above, then it won't work.
> 
> There are patches floating around, but I haven't had time...
> 
> --
> Daniel Jacobowitz
> CodeSourcery, LLC
> 
>
