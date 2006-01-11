Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 11 Jan 2006 02:02:03 +0000 (GMT)
Received: from wproxy.gmail.com ([64.233.184.198]:54930 "EHLO wproxy.gmail.com")
	by ftp.linux-mips.org with ESMTP id S8133476AbWAKCBn convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 11 Jan 2006 02:01:43 +0000
Received: by wproxy.gmail.com with SMTP id 36so38470wra
        for <linux-mips@linux-mips.org>; Tue, 10 Jan 2006 18:04:51 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=UPo/ePkmPiK6vePRpeI3OY9vRzEbiX9ZK5ZlUJ69X0mQsH4Dor5jLjCJ4HQ1c8vRygAv+CXmtFy8/wLeZo2Rb9iFsgRwWevpsTouFqxnL8vMlqLD5R7DE7Z4fdnvcmOMSU4qjWoJe0vyS/z1pYK460mqL4FjLzfZ4lgry+Odwe8=
Received: by 10.54.151.9 with SMTP id y9mr1514792wrd;
        Tue, 10 Jan 2006 18:04:50 -0800 (PST)
Received: by 10.54.156.1 with HTTP; Tue, 10 Jan 2006 18:04:50 -0800 (PST)
Message-ID: <50c9a2250601101804h73aa933dyf3434635aa7bde55@mail.gmail.com>
Date:	Wed, 11 Jan 2006 10:04:50 +0800
From:	zhuzhenhua <zzh.hust@gmail.com>
To:	Ralf Baechle <ralf@linux-mips.org>
Subject: Re: why the early_initcall(au1x00_setup) do not work?
Cc:	"P. Christeas" <p_christ@hol.gr>, linux-mips@linux-mips.org
In-Reply-To: <20060110141924.GA13779@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
References: <50c9a2250601082159p238cacd6r930709da9305479e@mail.gmail.com>
	 <20060109145610.GB4286@linux-mips.org>
	 <200601091720.03822.p_christ@hol.gr>
	 <20060109152429.GE4286@linux-mips.org>
	 <50c9a2250601091702g7e48c75br178868a3c91d48f4@mail.gmail.com>
	 <20060110141924.GA13779@linux-mips.org>
Return-Path: <zzh.hust@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9851
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: zzh.hust@gmail.com
Precedence: bulk
X-list: linux-mips

On 1/10/06, Ralf Baechle <ralf@linux-mips.org> wrote:
> On Tue, Jan 10, 2006 at 09:02:43AM +0800, zhuzhenhua wrote:
>
> > > In 2.6.15 things were alomst fully merged but several megabytes of
> > > patches are between the linux-mips.org and kernel.org versions of 2.6.14.
> > >
> > >   Ralf
> > >
> >
> > in linux-mips, where to download the patches for standard kernel?
>
> I don't publish such patches - but they're eassy to generate.
i find on http://www.linux-mips.org/pub/linux/mips/kernel/v2.6/ can
download the kernel tarball, i compire the 2.6.14 with the stand
kernel, and found they are not same.

is the tarball in
http://www.linux-mips.org/pub/linux/mips/kernel/v2.6/ is tared with
the cvs tree code in linux-mips?



>
>   Ralf
>

Best regards

zhuzhenhua
