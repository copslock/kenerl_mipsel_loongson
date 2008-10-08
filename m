Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 08 Oct 2008 20:29:08 +0100 (BST)
Received: from gv-out-0910.google.com ([216.239.58.190]:21865 "EHLO
	gv-out-0910.google.com") by ftp.linux-mips.org with ESMTP
	id S20965599AbYJHT3A (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 8 Oct 2008 20:29:00 +0100
Received: by gv-out-0910.google.com with SMTP id e6so686871gvc.2
        for <linux-mips@linux-mips.org>; Wed, 08 Oct 2008 12:28:58 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=REv1GcPIoJbD5s1n/0MkFwNr/E96cyiIKOmUPI5MC+Q=;
        b=aLjW5/Bh8KMRTg0vu9hj5b3/tCgxhNy7lYo+q3LjsytUo17EixWgRAuCE8ppt65aDl
         BnQJ7fw1m2wNdZ5aTpOWlUmmG3EQ497VcmsI0A+JOZlB7jDRv8A7BvGwmKlR0WvEOolz
         0b4dWjEzV9sdRfgYl8CYsizf0NxtjYEoSDdGU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=v4En8fiaKR945LjssknvdWQd7trDVqpaLOvw0ZLolzA1CZrdcgJGlOpKSGwyGqMpjj
         2g3q27NqOsjLyyPnoCUHDjuw3rL1jRUJEHcxY/nxsuSw6hNmSPqBAXqrrWmrOPSTckj7
         nWel2OL+RGl1WYrMUC5Sbo4E0fofzls07PpHQ=
Received: by 10.103.242.7 with SMTP id u7mr4658318mur.125.1223494138450;
        Wed, 08 Oct 2008 12:28:58 -0700 (PDT)
Received: from ?192.168.123.7? (chello089077041080.chello.pl [89.77.41.80])
        by mx.google.com with ESMTPS id u26sm15643945mug.5.2008.10.08.12.28.56
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 08 Oct 2008 12:28:57 -0700 (PDT)
From:	Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Subject: Re: [PATCH] ide: Add tx4939ide driver (v3)
Date:	Wed, 8 Oct 2008 21:09:58 +0200
User-Agent: KMail/1.9.10
Cc:	linux-mips@linux-mips.org, linux-ide@vger.kernel.org,
	ralf@linux-mips.org, sshtylyov@ru.mvista.com
References: <20081003.000838.27954527.anemo@mba.ocn.ne.jp>
In-Reply-To: <20081003.000838.27954527.anemo@mba.ocn.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200810082109.58282.bzolnier@gmail.com>
Return-Path: <bzolnier@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20708
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: bzolnier@gmail.com
Precedence: bulk
X-list: linux-mips

On Thursday 02 October 2008, Atsushi Nemoto wrote:
> This is the driver for the Toshiba TX4939 SoC ATA controller.
> 
> This controller has standard ATA taskfile registers and DMA
> command/status registers, but the register layout is swapped on big
> endian.  There are some other endian issue and some special registers
> which requires many custom dma_ops/tp_ops routines and build_dmatable.
> 
> Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
> ---
> This patch is against linux-next 20080919.
> 
> Changes since v2:
> * more consistent symbol naming
> * drop custom selectproc
> * more reasonable delay values
> * custom ide_build_dmatable for big endian
> * cleanup irq handling
> * use ide_host_alloc/ide_host_register instead of ide_host_alloc
> * drop custom init_iops
> * and so on  (Many many thanks to Sergei)

I think that Sergei is still on vacation so it may take a while to
get his feedback.

[ in the meantime I replaced v2 by v3 in pata tree ]
