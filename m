Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 19 Sep 2008 00:53:57 +0100 (BST)
Received: from rv-out-0708.google.com ([209.85.198.247]:55140 "EHLO
	rv-out-0708.google.com") by ftp.linux-mips.org with ESMTP
	id S20032672AbYIRXxw (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 19 Sep 2008 00:53:52 +0100
Received: by rv-out-0708.google.com with SMTP id c5so177375rvf.24
        for <linux-mips@linux-mips.org>; Thu, 18 Sep 2008 16:53:49 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=HY+ytoVFskxwiuZtTLJRpU1mxO9c2ndCEbfp1OHLk9A=;
        b=rEKvVIuwF9YE1G/VneHFi15+JY1Vo5jQmNcqXfKhqQNnlbQ/j7QHD77ckukUn4Ieqw
         535SG2TOYn865qAlcy0ZzPpXPA/JP0YyzdKG5/1uofyA+q+HNSybJTJqLm56JpuHyMWl
         qstnYW+kYVrOu9UkeN6aTbAyMaaiCQDsh0RSk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=P/0PlEWChxluSmBONOkDs9U8/GWGKvZpML5R1m3ITS50d/ET6SMz8xaknfJPYLO7dl
         ksQUuq0Bk/qG5j17F6bKAbNCmDR70tiriIEWc0w5L2JKzsI5RksB3N5EAcLE6xm7lzDl
         DIKYbPX+1/uSj+3RDO5rdnYJ+KVvzUG8Lb5yI=
Received: by 10.141.113.6 with SMTP id q6mr8003844rvm.135.1221782028983;
        Thu, 18 Sep 2008 16:53:48 -0700 (PDT)
Received: from host-246-131.pubnet.pdx.edu ( [131.252.246.131])
        by mx.google.com with ESMTPS id k2sm232532rvb.1.2008.09.18.16.53.46
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 18 Sep 2008 16:53:47 -0700 (PDT)
From:	Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Subject: Re: [PATCH 1/2] ide: Add tx4939ide driver (v2)
Date:	Thu, 18 Sep 2008 16:45:09 -0700
User-Agent: KMail/1.9.9
Cc:	linux-mips@linux-mips.org, linux-ide@vger.kernel.org,
	ralf@linux-mips.org, sshtylyov@ru.mvista.com
References: <20080918.001342.52129176.anemo@mba.ocn.ne.jp>
In-Reply-To: <20080918.001342.52129176.anemo@mba.ocn.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200809181645.10410.bzolnier@gmail.com>
Return-Path: <bzolnier@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20537
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: bzolnier@gmail.com
Precedence: bulk
X-list: linux-mips

On Wednesday 17 September 2008 08:13:42 Atsushi Nemoto wrote:
> This is the driver for the Toshiba TX4939 SoC ATA controller.
> 
> This controller has standard ATA taskfile registers and DMA
> command/status registers, but the register layout is swapped on big
> endian.  There are some other endian issue and some special registers
> which requires many custom dma_ops/port_ops routines.
> 
> Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
> ---
> This patch is against linux-next 20080916.
> 
> Changes since v1:
> * rework IO accessors
> * rework pio/dma timing setup
> * use ide_get_pair_dev
> * do not do ATA hard reset
> * and so on  (Many thanks to Sergei)

Sergei, are you OK with this version?

[ I tentatively applied it to pata tree.  I still see the use of legacy
  HWIF()/HWGROUP() macros but I can deal with it myself before pushing
  the patch upstream. ]
