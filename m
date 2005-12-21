Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 21 Dec 2005 10:31:12 +0000 (GMT)
Received: from deliver-1.mx.triera.net ([213.161.0.31]:6579 "HELO
	deliver-1.mx.triera.net") by ftp.linux-mips.org with SMTP
	id S3458540AbVLUKaz (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 21 Dec 2005 10:30:55 +0000
Received: from localhost (in-3.mx.triera.net [213.161.0.27])
	by deliver-1.mx.triera.net (Postfix) with ESMTP id 24B48C009;
	Wed, 21 Dec 2005 11:31:59 +0100 (CET)
Received: from smtp.triera.net (smtp.triera.net [213.161.0.30])
	by in-3.mx.triera.net (Postfix) with SMTP id 9AC3C1BC079;
	Wed, 21 Dec 2005 11:32:01 +0100 (CET)
Received: from [172.18.1.53] (unknown [213.161.20.162])
	by smtp.triera.net (Postfix) with ESMTP id 8CC661A18B9;
	Wed, 21 Dec 2005 11:32:01 +0100 (CET)
Subject: Re: does someone succeed in making the toolchain for 2.6 kernel?
From:	Matej Kupljen <matej.kupljen@ultra.si>
To:	Jan-Benedict Glaw <jbglaw@lug-owl.de>
Cc:	linux-mips@linux-mips.org
In-Reply-To: <20051221100619.GW13985@lug-owl.de>
References: <50c9a2250512210051q85f813fx27b0533fe66165e2@mail.gmail.com>
	 <20051221085539.GS13985@lug-owl.de>
	 <50c9a2250512210104j4a19e37cu30c795d4acc226d2@mail.gmail.com>
	 <20051221091852.GT13985@lug-owl.de>
	 <1135159354.5211.1.camel@localhost.localdomain>
	 <20051221100619.GW13985@lug-owl.de>
Content-Type: text/plain
Date:	Wed, 21 Dec 2005 11:32:16 +0100
Message-Id: <1135161136.5211.8.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: Triera AV Service
Return-Path: <matej.kupljen@ultra.si>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9711
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: matej.kupljen@ultra.si
Precedence: bulk
X-list: linux-mips

Hi

> > Yes, we use crosstool, but the results matrix isn't rely
> > encouraging:
> > http://www.kegel.com/crosstool/crosstool-0.38/buildlogs/
> 
> Well, try do do it any better *yourself*. Compiling a complete
> toolchain (incl. userland support) really isn't easy...

You probably misunderstood me :(

I was trying to say, that we use crosstool *successfully* to build
kernel 2.6.15-rc5 (and a bunch of user land binaries) and that
this matrix should be updated.

If someone looks at this matrix, he thinks that for mips(el) crosstool
does not work.

BR,
Matej
