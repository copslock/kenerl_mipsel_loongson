Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 10 Sep 2009 01:28:55 +0200 (CEST)
Received: from mail-ew0-f225.google.com ([209.85.219.225]:38841 "EHLO
	mail-ew0-f225.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1493189AbZIIX2s (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 10 Sep 2009 01:28:48 +0200
Received: by ewy25 with SMTP id 25so4363071ewy.33
        for <linux-mips@linux-mips.org>; Wed, 09 Sep 2009 16:28:42 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=K4JpS9mGrP+JUUt40SmWWJaX27kt0wRummwlgmrXSEQ=;
        b=ave5Fe7ddls7c80i54qCZPhTxFIEJa10TO6dMkb308a9CbK+z7oDXw7Fql9kGXSjJQ
         KUL2bGQXXdlkf8v8oreYsz8pA5C42FfNOBC9Lz8NsyeHqL+RfZS1q1akixU/fUM27Di0
         8z3F95Ni+oyvhaNtLq2Qu+EOxK0pOlA61R2dg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=i5907mrgCcjMl62aazUCkmAla/3pmElaU40W9R1DnDaA2c6oLj2PtoLLWIawqIHM3J
         1jpTTi08oc7NqLMEZerM0xCL5ddDknk+Xl0IhZT6aTuVgR0OxPy8CGbGVDuVUZLV0DEz
         odOKwMEd2TJf0LV3D36hfJh1H2eo4+oyb+lDQ=
MIME-Version: 1.0
Received: by 10.216.36.196 with SMTP id w46mr232293wea.76.1252538922053; Wed, 
	09 Sep 2009 16:28:42 -0700 (PDT)
In-Reply-To: <1252531371-14866-4-git-send-email-w.sang@pengutronix.de>
References: <1252531371-14866-1-git-send-email-w.sang@pengutronix.de>
	 <1252531371-14866-4-git-send-email-w.sang@pengutronix.de>
Date:	Wed, 9 Sep 2009 18:28:42 -0500
Message-ID: <808c8e9d0909091628v3681c0cch50759d24393e570a@mail.gmail.com>
Subject: Re: [PATCH 3/4] i2c/chips: Remove deprecated pca9539-driver
From:	Ben Gardner <gardner.ben@gmail.com>
To:	Wolfram Sang <w.sang@pengutronix.de>
Cc:	linux-i2c@vger.kernel.org, linuxppc-dev@ozlabs.org,
	linux-arm-kernel@lists.infradead.org, linux-mips@linux-mips.org,
	uclinux-dist-devel@blackfin.uclinux.org,
	Jean Delvare <khali@linux-fr.org>
Content-Type: text/plain; charset=ISO-8859-1
Return-Path: <gardner.ben@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24003
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: gardner.ben@gmail.com
Precedence: bulk
X-list: linux-mips

On Wed, Sep 9, 2009 at 4:22 PM, Wolfram Sang<w.sang@pengutronix.de> wrote:
> The pca9539-driver in drivers/i2c/chips which just exports its registers to
> sysfs is superseeded by drivers/gpio/pca953x.c which properly uses the gpiolib.
> As this driver has been deprecated for more than a year, finally remove it.
>
> Signed-off-by: Wolfram Sang <w.sang@pengutronix.de>
> Cc: Ben Gardner <gardner.ben@gmail.com>
> Cc: Jean Delvare <khali@linux-fr.org>

Acked-by: Ben Gardner <gardner.ben@gmail.com>

Thanks for taking care of this.
Ben
