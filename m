Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 22 Dec 2005 02:42:37 +0000 (GMT)
Received: from wproxy.gmail.com ([64.233.184.196]:5067 "EHLO wproxy.gmail.com")
	by ftp.linux-mips.org with ESMTP id S3466994AbVLVCmT convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 22 Dec 2005 02:42:19 +0000
Received: by wproxy.gmail.com with SMTP id 36so272101wra
        for <linux-mips@linux-mips.org>; Wed, 21 Dec 2005 18:43:31 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=opr6diJZblOxITZTQH6rcqXUZSC+3/7Txv3SXi89mNtvRP1QFP7TrOmLCyW473l0JhoYDSvK/DvF64c8K+LMuTARw9aoXVY56eh8p0ktejB0lBoVtIODn9tuT4jix/UoF3jtcKPjvV0CiKlgZQgxM9jVlueEWGjp26uH7HBXy7s=
Received: by 10.54.105.16 with SMTP id d16mr1514877wrc;
        Wed, 21 Dec 2005 18:43:31 -0800 (PST)
Received: by 10.54.156.5 with HTTP; Wed, 21 Dec 2005 18:43:31 -0800 (PST)
Message-ID: <50c9a2250512211843o469601e4p557f4645dd721949@mail.gmail.com>
Date:	Thu, 22 Dec 2005 10:43:31 +0800
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
X-archive-position: 9721
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
> BR,
> Matej
>
>
>

i have use the crosstool to try,but i get a
"#error "glibc cannot be compiled without optimization"
what CFLAGS and CXXFLAGS should  to set in demo-mipsel.sh

BR,
zhuzhenhua
