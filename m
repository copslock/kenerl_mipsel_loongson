Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 23 Oct 2008 22:51:11 +0100 (BST)
Received: from gv-out-0910.google.com ([216.239.58.190]:64968 "EHLO
	gv-out-0910.google.com") by ftp.linux-mips.org with ESMTP
	id S22248770AbYJWVuH (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 23 Oct 2008 22:50:07 +0100
Received: by gv-out-0910.google.com with SMTP id e6so120279gvc.2
        for <linux-mips@linux-mips.org>; Thu, 23 Oct 2008 14:50:04 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version
         :content-disposition:message-id:content-type
         :content-transfer-encoding;
        bh=8PHhOS0huUQ1iEkagZL5BWms6RjpoYYqZDdFwrz4PiU=;
        b=Mv6UvzyDK7xlb6V2bngrmM9jfkJP2XdBHwKf3FYOP2eJwvGtkbGhph/y5dNBHn2jV2
         0Urayuar27bgLK0qZuC+Qat1KLoFGBf2101L2z7+y0eiKlJMEH1tyWaNWfXhWOUSQgg4
         c54mOrewbutUKcqCXad6EaZaY8oHXzInOJ8H4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-disposition:message-id:content-type
         :content-transfer-encoding;
        b=KLcsJRSaWkzUSwkHY52tA+DtK25OtTfd3TAWVWUoTye+vnD22OGc5ckIVmrnM2omwu
         z9pDzWTJ5epkqRMfNaR63bMTEJyRj6jqaaJg49EUe4i2H9r9aHkHWh8VzbW3H4MtHuwG
         cG1DI80BzhsZbYWi59aFQkMBoqUJmFKxlQCUU=
Received: by 10.103.243.9 with SMTP id v9mr615107mur.59.1224798603912;
        Thu, 23 Oct 2008 14:50:03 -0700 (PDT)
Received: from ?192.168.123.7? (chello089077041080.chello.pl [89.77.41.80])
        by mx.google.com with ESMTPS id y37sm20631980mug.13.2008.10.23.14.50.02
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 23 Oct 2008 14:50:02 -0700 (PDT)
From:	Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Subject: Re: [PATCH] ide: Add tx4938ide driver (v2)
Date:	Thu, 23 Oct 2008 22:47:05 +0200
User-Agent: KMail/1.9.10
Cc:	linux-mips@linux-mips.org, linux-ide@vger.kernel.org,
	ralf@linux-mips.org, sshtylyov@ru.mvista.com
References: <20081023.012013.52129771.anemo@mba.ocn.ne.jp>
In-Reply-To: <20081023.012013.52129771.anemo@mba.ocn.ne.jp>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200810232247.05686.bzolnier@gmail.com>
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-Path: <bzolnier@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20878
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: bzolnier@gmail.com
Precedence: bulk
X-list: linux-mips

On Wednesday 22 October 2008, Atsushi Nemoto wrote:
> This is the driver for the Toshiba TX4938 SoC EBUS controller ATA mode.
> It has custom set_pio_mode and some hacks for big endian.
> 
> Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>

I applied it so please address issues left (if any) with incremental patches.

Thanks for all your work on TX493x drivers.
