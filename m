Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 29 Oct 2008 19:29:04 +0000 (GMT)
Received: from gv-out-0910.google.com ([216.239.58.191]:14073 "EHLO
	gv-out-0910.google.com") by ftp.linux-mips.org with ESMTP
	id S22676116AbYJ2T2w (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 29 Oct 2008 19:28:52 +0000
Received: by gv-out-0910.google.com with SMTP id e6so106290gvc.2
        for <linux-mips@linux-mips.org>; Wed, 29 Oct 2008 12:28:49 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=vpLr9Xve0Fc6K+HiOQ7odtm2v9h8lfpXavFwqPBTWXY=;
        b=fwQD/c5jrvR7NktipmnvXSbUWd5yIXhnWYeDjXlKKictxl0doQtWIqstlkMX4GiAp8
         KbIL8NvE5N4Gw8rmb9NC+ZocZ50FEPAP4NmpXdCm12zi/8g0Io9nGxrz76RUAmdVRFgr
         94AW4Ousr4xVN1kDTpsMXXLK1Kj6zABNtdug4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=QquMAmvxpiKabR/mQfW+L13KpfYclQt+wMOPsjj1DWRrC9wI2d5RuS6AQXSObsQqCF
         YIWAEmqsRnO2B9SPaxTKeyhu8uPpprvCmAp4N8itbBQjvzcG8hya7ah5EseUuvi68SAI
         HYEPExD+NprAUiAaacHYCKZNO/gdRmp/KVpG4=
Received: by 10.103.40.5 with SMTP id s5mr4384964muj.133.1225308529058;
        Wed, 29 Oct 2008 12:28:49 -0700 (PDT)
Received: from ?192.168.123.7? (chello089077041080.chello.pl [89.77.41.80])
        by mx.google.com with ESMTPS id j10sm599903mue.17.2008.10.29.12.28.46
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 29 Oct 2008 12:28:47 -0700 (PDT)
From:	Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 1/2] tx4938ide: Check minimum cycle time and SHWT range
Date:	Wed, 29 Oct 2008 20:12:19 +0100
User-Agent: KMail/1.9.10
Cc:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>, linux-mips@linux-mips.org,
	linux-ide@vger.kernel.org, ralf@linux-mips.org
References: <20081027.223913.128619425.anemo@mba.ocn.ne.jp> <20081027.235224.82088530.anemo@mba.ocn.ne.jp> <49064ACA.20200@ru.mvista.com>
In-Reply-To: <49064ACA.20200@ru.mvista.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200810292012.19750.bzolnier@gmail.com>
Return-Path: <bzolnier@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21088
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: bzolnier@gmail.com
Precedence: bulk
X-list: linux-mips

On Tuesday 28 October 2008, Sergei Shtylyov wrote:
> Hello.
> 
> Atsushi Nemoto wrote:
> 
> > From: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
> > Subject: [PATCH] tx4938ide: Check minimum cycle time and SHWT range (v2)
> >
> > SHWT value is used as address valid to -CSx assertion and -CSx to -DIOx
> > assertion setup time, and contrarywise, -DIOx to -CSx release and -CSx
> > release to address invalid hold time, so it actualy applies 4 times and
> > so constitutes -DIOx recovery time.  Check requirement of the recovery
> > time and cycle time.  Also check SHWT maximum value.
> >
> > Suggested-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>
> > Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
> >   
> 
> Acked-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

applied
