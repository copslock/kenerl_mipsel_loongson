Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 28 May 2009 11:38:13 +0100 (BST)
Received: from mail-fx0-f175.google.com ([209.85.220.175]:60101 "EHLO
	mail-fx0-f175.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S20023983AbZE1KiG convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 28 May 2009 11:38:06 +0100
Received: by fxm23 with SMTP id 23so5552345fxm.0
        for <multiple recipients>; Thu, 28 May 2009 03:37:59 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=0IOrSEpUtrzOHrmn2Jzo4crGgpKsnh5bEfQC/xEX+kI=;
        b=Q1kZw1e5O485AQ/39Qam9IZPniLz/V5QPARH9Sk4WdMJiD9y+rRUuFhJ0MjO+nHnxb
         tifEiVIb9uCEz9NF9CxLc058R4XAgvhw0Dzy3SsQhWT9n9mtE0sb1ekGJ/arndFw0xQ1
         YvO4At74osFgWFkxN96o3DtsCe4V+p+DAaDEI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=Nxy9jEr5Z4XIb/FuEFLILFE5lF3uY01AAPOLOlqQJIE1qNbVRPSd8BatiGpIJFmuOK
         O7QTnTWu+3P3SJD9uIFOQ2c5pco2EzNMtQVPJQZYnjJfKf7qLm45tGjpnW+DgUM6HHPM
         NkVlXj3crjHM2NzMNCPsCQPh39w4igMaSC4mI=
Received: by 10.103.244.19 with SMTP id w19mr715579mur.106.1243507079837;
        Thu, 28 May 2009 03:37:59 -0700 (PDT)
Received: from florian.lab.openpattern.org (lab.openpattern.org [82.240.16.241])
        by mx.google.com with ESMTPS id i7sm2428857mue.18.2009.05.28.03.37.58
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 28 May 2009 03:37:58 -0700 (PDT)
From:	Florian Fainelli <florian@openwrt.org>
To:	Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [PATCH] rb532: fix irq number check in rb532_set_type
Date:	Thu, 28 May 2009 12:37:54 +0200
User-Agent: KMail/1.9.9
Cc:	linux-mips@linux-mips.org
References: <200905271414.07074.florian@openwrt.org> <20090527131535.GC7755@linux-mips.org>
In-Reply-To: <20090527131535.GC7755@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200905281237.55899.florian@openwrt.org>
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23022
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian@openwrt.org
Precedence: bulk
X-list: linux-mips

Le Wednesday 27 May 2009 15:15:35 Ralf Baechle, vous avez écrit :
> On Wed, May 27, 2009 at 02:14:06PM +0200, Florian Fainelli wrote:
> > We only have 14 GPIO interrupt sources numbered
> > from 0 to 13. Therefore the check against irq_nr
> > in rb532_set_type is off-by-one. This fixes a mistake
> > introduced by commit 1b4f571632ffb0caa4170d886694f2555c0d9a4b.
>
> Thanks; I've folded this patch into your old patch.

Thank you !

>
> A note on commit IDs on the -queue tree.  The -queue tree is really
> maintained in quilt and respun every time I change any of the commits
> on it.  This means the commit IDs will also change, so they should be
> considered volatile.

I will take that into account next time, thanks for fixing this.
-- 
Best regards, Florian Fainelli
Email : florian@openwrt.org
http://openwrt.org
-------------------------------
