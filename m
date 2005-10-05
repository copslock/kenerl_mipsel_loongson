Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 05 Oct 2005 19:05:20 +0100 (BST)
Received: from zproxy.gmail.com ([64.233.162.198]:46020 "EHLO zproxy.gmail.com")
	by ftp.linux-mips.org with ESMTP id S3465679AbVJESFE convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 5 Oct 2005 19:05:04 +0100
Received: by zproxy.gmail.com with SMTP id q3so155346nzb
        for <linux-mips@linux-mips.org>; Wed, 05 Oct 2005 11:04:56 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=sHCtSOUbx2HgjLHJZ1SZ3ghj4c6kJfw3UUE2zeCV52xHdWUVAmbUy5ZYoTVEsvca7AOFUm70XXxgVBV/j8sLdN0UrKTus/OFzRyluKFWB+s9zZDDCsKX1ho0KALeXHExEiyE7FSST1RYgn0ki70PkRVZITsLZic8CKQZ5kJQbDE=
Received: by 10.36.49.12 with SMTP id w12mr851105nzw;
        Wed, 05 Oct 2005 11:04:56 -0700 (PDT)
Received: by 10.36.49.3 with HTTP; Wed, 5 Oct 2005 11:04:56 -0700 (PDT)
Message-ID: <cda58cb80510051104p6c40b140w@mail.gmail.com>
Date:	Wed, 5 Oct 2005 20:04:56 +0200
From:	Franck <vagabon.xyz@gmail.com>
Reply-To: Franck <vagabon.xyz@gmail.com>
To:	"Maciej W. Rozycki" <macro@linux-mips.org>
Subject: Re: [PATCH] Add support for 4KS cpu.
Cc:	"Kevin D. Kissell" <kevink@mips.com>,
	Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
In-Reply-To: <Pine.LNX.4.61L.0510051112390.13762@blysk.ds.pg.gda.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
References: <cda58cb80510040149p690397afo@mail.gmail.com>
	 <Pine.LNX.4.61L.0510041219500.10696@blysk.ds.pg.gda.pl>
	 <434277D5.1090603@mips.com>
	 <Pine.LNX.4.61L.0510041358300.10696@blysk.ds.pg.gda.pl>
	 <434289A7.50007@mips.com>
	 <cda58cb80510040818v6d93fe53w@mail.gmail.com>
	 <Pine.LNX.4.61L.0510041651150.10696@blysk.ds.pg.gda.pl>
	 <cda58cb80510041033h2a67f072s@mail.gmail.com>
	 <cda58cb80510042355r66d6b4b7k@mail.gmail.com>
	 <Pine.LNX.4.61L.0510051112390.13762@blysk.ds.pg.gda.pl>
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9155
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vagabon.xyz@gmail.com
Precedence: bulk
X-list: linux-mips

2005/10/5, Maciej W. Rozycki <macro@linux-mips.org>:
> On Wed, 5 Oct 2005, Franck wrote:
>
> > Actually it would be better to let smartmips options in case we use
> > fallback options:
>
>  In which case the toolchain is not going to support the "-msmartmips"
> option anyway...

toolchain could support smartmips extension without supporting 4ksd
specific instructions...

Thanks
--
               Franck
