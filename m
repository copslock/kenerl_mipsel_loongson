Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 21 Dec 2005 10:37:08 +0000 (GMT)
Received: from wproxy.gmail.com ([64.233.184.195]:12449 "EHLO wproxy.gmail.com")
	by ftp.linux-mips.org with ESMTP id S3458540AbVLUKgv convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 21 Dec 2005 10:36:51 +0000
Received: by wproxy.gmail.com with SMTP id 36so97266wra
        for <linux-mips@linux-mips.org>; Wed, 21 Dec 2005 02:37:59 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=QkiPyIeDIuiG0fnMBvrBeekpsBy6Dw67p3wGOGtmBL8yXNJpUIDMKk/xTKpxj2zIKxySEqGcW4//gVeWIEuGDYbZnaFPyDa6+on7XvAoDRmtEl5BpRZITy3A9t8SiOlyD8nT0gkXoxZ2HO7d3TxX3ojXDcfQJtPM5u8WWIuYgKM=
Received: by 10.54.133.9 with SMTP id g9mr672604wrd;
        Wed, 21 Dec 2005 02:37:58 -0800 (PST)
Received: by 10.54.156.5 with HTTP; Wed, 21 Dec 2005 02:37:58 -0800 (PST)
Message-ID: <50c9a2250512210237l19443e53v66a9276e193f80e8@mail.gmail.com>
Date:	Wed, 21 Dec 2005 18:37:58 +0800
From:	zhuzhenhua <zzh.hust@gmail.com>
To:	Matej Kupljen <matej.kupljen@ultra.si>
Subject: Re: does someone succeed in making the toolchain for 2.6 kernel?
Cc:	Jan-Benedict Glaw <jbglaw@lug-owl.de>, linux-mips@linux-mips.org
In-Reply-To: <1135161136.5211.8.camel@localhost.localdomain>
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
Return-Path: <zzh.hust@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9712
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: zzh.hust@gmail.com
Precedence: bulk
X-list: linux-mips

On 12/21/05, Matej Kupljen <matej.kupljen@ultra.si> wrote:
> Hi
>
> > > Yes, we use crosstool, but the results matrix isn't rely
> > > encouraging:
> > > http://www.kegel.com/crosstool/crosstool-0.38/buildlogs/
> >
> > Well, try do do it any better *yourself*. Compiling a complete
> > toolchain (incl. userland support) really isn't easy...
>
> You probably misunderstood me :(
>
> I was trying to say, that we use crosstool *successfully* to build
> kernel 2.6.15-rc5 (and a bunch of user land binaries) and that
> this matrix should be updated.
>
> If someone looks at this matrix, he thinks that for mips(el) crosstool
> does not work.
>
  you are right, as i see the matrix, i just think it can't work for mips
with your reply, i want to try this
thanks!
> BR,
> Matej
>
>
>

Best regards!
zhuzhenhua
