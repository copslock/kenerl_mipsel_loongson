Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 23 Oct 2008 22:50:10 +0100 (BST)
Received: from ey-out-1920.google.com ([74.125.78.148]:9258 "EHLO
	ey-out-1920.google.com") by ftp.linux-mips.org with ESMTP
	id S22248762AbYJWVuB (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 23 Oct 2008 22:50:01 +0100
Received: by ey-out-1920.google.com with SMTP id 4so241147eyg.54
        for <linux-mips@linux-mips.org>; Thu, 23 Oct 2008 14:49:58 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=vc4kjszoteVA+zP1tfhY8wamT+VGUdl0k6/SLiE3vrU=;
        b=b6yVsmOLxh1VwW0EPUvW8v1agDwr2J6xGrX037CE9OrxFN/47OwTunTle5ZbOQDoZ1
         uH+oiVDsOMKFFOLpJKBBaFFnYCr9W070zblbFrKKgrpnkHquVifZmukpRaLg9EOvrdtP
         EycUo+BfOz304D36xrQyocX8faWwsTlwzLPAY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=IKZmFVvIlqgxnbUReJTYs7LeQsCQKKeEodGGt0LYj+EiL7Q0qLt1RoYXiAw1E6HyIq
         7c37PHrG449FBxRdg4whcQZz7kKTvjbikmUvr++Dd/GFKqZcxthj18uYGtkKXkQhSzKf
         98vvMehn+zd4MMfyqYolIMgr/zDejoyG1/bLg=
Received: by 10.103.173.5 with SMTP id a5mr603408mup.117.1224798598102;
        Thu, 23 Oct 2008 14:49:58 -0700 (PDT)
Received: from ?192.168.123.7? (chello089077041080.chello.pl [89.77.41.80])
        by mx.google.com with ESMTPS id y37sm20631980mug.13.2008.10.23.14.49.55
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 23 Oct 2008 14:49:56 -0700 (PDT)
From:	Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH] ide: Add tx4939ide driver (v5)
Date:	Thu, 23 Oct 2008 22:00:35 +0200
User-Agent: KMail/1.9.10
Cc:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>, linux-mips@linux-mips.org,
	linux-ide@vger.kernel.org, ralf@linux-mips.org
References: <20081020.212701.59651580.anemo@mba.ocn.ne.jp> <48FDFE89.5030501@ru.mvista.com>
In-Reply-To: <48FDFE89.5030501@ru.mvista.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200810232200.35932.bzolnier@gmail.com>
Return-Path: <bzolnier@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20875
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: bzolnier@gmail.com
Precedence: bulk
X-list: linux-mips

On Tuesday 21 October 2008, Sergei Shtylyov wrote:

> > +		pr_err("%s: Error interrupt %#x (%s%s%s )\n",
> > +		       hwif->name, ctl,
> > +		       (ctl & TX4939IDE_INT_ADDRERR) ?
> > +		       " Address-Error" : "",
> > +		       (ctl & TX4939IDE_INT_DEVTIMING) ?
> > +		       " DEV-Timing" : "",
> > +		       (ctl & TX4939IDE_INT_BUSERR) ?
> 
>     Parens around & shouldn't be needed...

While the above remark is certainly correct we usually leave such parens
to ease the reading of the code and to match the other parts of the kernel...

[ No need to change it again, just a minor note... ]
