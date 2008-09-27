Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 27 Sep 2008 18:29:21 +0100 (BST)
Received: from fk-out-0910.google.com ([209.85.128.188]:17483 "EHLO
	fk-out-0910.google.com") by ftp.linux-mips.org with ESMTP
	id S20128125AbYI0R2x (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sat, 27 Sep 2008 18:28:53 +0100
Received: by fk-out-0910.google.com with SMTP id b27so2090489fka.0
        for <linux-mips@linux-mips.org>; Sat, 27 Sep 2008 10:28:50 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version
         :content-disposition:message-id:content-type
         :content-transfer-encoding;
        bh=prIJFq9Etlsu9ckcvUY6pde5xrdiWD4xSojP0vqfcec=;
        b=c/zNpYt4+iF/GP6iuTXufAW2HBQXb2Xrkyyg3/gFn9lVJ3tYK3R4y1Ufj+Lh1inhoU
         hYOrmFGjy90uTQd+8Nw3Qtvy57zqzEXwgmQALlWErGGMHqE05ODB/Rj78+DKcjUGWS/V
         oO0M2uNPaVHnMHbtcc+HoHsNacJWgQrPVE09o=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-disposition:message-id:content-type
         :content-transfer-encoding;
        b=seUbj4rFcyiL3HFV5J1W5U+LSczdKs0Cjbvx2Vo4VCzxXKk3OTSF8Jo0Lio7xjBJ9K
         5LqxrvAj9iGbHz5A2j8PMrCj9nS2IZrrkF9QDOI+OfEutjoPot7jtXVMuWuK9R3ZA06i
         YgKCt09FH63KoA+bpKuvFon5mGI576FaqA/7o=
Received: by 10.103.17.10 with SMTP id u10mr2047705mui.97.1222536530569;
        Sat, 27 Sep 2008 10:28:50 -0700 (PDT)
Received: from ?192.168.123.7? (chello089077041080.chello.pl [89.77.41.80])
        by mx.google.com with ESMTPS id y37sm561478mug.13.2008.09.27.10.28.48
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 27 Sep 2008 10:28:48 -0700 (PDT)
From:	Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Subject: Re: [PATCH 1/2] ide: Add tx4939ide driver
Date:	Sat, 27 Sep 2008 18:19:19 +0200
User-Agent: KMail/1.9.10
Cc:	sshtylyov@ru.mvista.com, linux-mips@linux-mips.org,
	linux-ide@vger.kernel.org, ralf@linux-mips.org,
	Tejun Heo <htejun@gmail.com>
References: <48C851ED.4090607@ru.mvista.com> <48CA8BEE.1090305@ru.mvista.com> <20080913.005904.07457691.anemo@mba.ocn.ne.jp>
In-Reply-To: <20080913.005904.07457691.anemo@mba.ocn.ne.jp>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200809271819.19510.bzolnier@gmail.com>
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-Path: <bzolnier@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20648
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: bzolnier@gmail.com
Precedence: bulk
X-list: linux-mips

On Friday 12 September 2008, Atsushi Nemoto wrote:
> On Fri, 12 Sep 2008 19:34:06 +0400, Sergei Shtylyov <sshtylyov@ru.mvista.com> wrote:

[...]

> > >>>+	__ide_flush_dcache_range((unsigned long)addr, size);
> > 
> > >>   Why is this needed BTW?
> > 
> > > Do you mean __ide_flush_dcache_range?  This is needed to avoid cache
> > > inconsistency on PIO drive.  PIO transfer only writes to cache but
> > > upper layers expects the data is in main memory.
> > 
> >     Hum, then I wonder why it's MIPS specific...
> 
> SPARC also have it.  And there were some discussions for ARM IIRC.

I was under the impression that it has been addressed by Tejun at
the higher-layer level (for both ide/libata) long time ago and that
MIPS/SPARC code are just a left-overs which could be removed now?

Thanks,
Bart
