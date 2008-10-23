Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 23 Oct 2008 22:50:29 +0100 (BST)
Received: from gv-out-0910.google.com ([216.239.58.186]:3516 "EHLO
	gv-out-0910.google.com") by ftp.linux-mips.org with ESMTP
	id S22248760AbYJWVuB (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 23 Oct 2008 22:50:01 +0100
Received: by gv-out-0910.google.com with SMTP id e6so120293gvc.2
        for <linux-mips@linux-mips.org>; Thu, 23 Oct 2008 14:50:00 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=VRbNGiuk5b3o45etXNs3ollGquxUQDdJcE/4J3C7Zuc=;
        b=oyrmVSN/yVK18qVuI0ewSYUEIESufQiFFUB+G3iv4DoIT0t5B5JoVUydFXkhK/w4JS
         bwCuSw2vozi14j5glbUNz064uoyd/W9AaIlPTV59PnP61BY3e/ZJjpNnKH3BWQ8rW+5r
         jBWMG5HepIX59yja/6Y0Vaghab8jhA1rHAr8I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=xVZCpuofzI+EkuBObdpL07esb3n0RhJIkuGMIS2Ow6NMQuHje4HGwRAT9yJeK5SPci
         eyP9NHafjNVYWgwhiT6+MnD4ZHpGIbiNsmy2s0rfRHwfRrMBGU0yG3N14MDZoUvpYsWu
         QA5jIOt+TUssB8kQDLjWzKnnbmNjoLttBYVNk=
Received: by 10.103.227.13 with SMTP id e13mr616101mur.49.1224798600126;
        Thu, 23 Oct 2008 14:50:00 -0700 (PDT)
Received: from ?192.168.123.7? (chello089077041080.chello.pl [89.77.41.80])
        by mx.google.com with ESMTPS id y37sm20631980mug.13.2008.10.23.14.49.58
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 23 Oct 2008 14:49:59 -0700 (PDT)
From:	Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Subject: Re: [PATCH] ide: Add tx4939ide driver (v6)
Date:	Thu, 23 Oct 2008 22:02:07 +0200
User-Agent: KMail/1.9.10
Cc:	linux-mips@linux-mips.org, linux-ide@vger.kernel.org,
	ralf@linux-mips.org, sshtylyov@ru.mvista.com
References: <20081023.010607.07457252.anemo@mba.ocn.ne.jp>
In-Reply-To: <20081023.010607.07457252.anemo@mba.ocn.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200810232202.07849.bzolnier@gmail.com>
Return-Path: <bzolnier@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20876
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: bzolnier@gmail.com
Precedence: bulk
X-list: linux-mips

On Wednesday 22 October 2008, Atsushi Nemoto wrote:
> This is the driver for the Toshiba TX4939 SoC ATA controller.
> 
> This controller has standard ATA taskfile registers and DMA
> command/status registers, but the register layout is swapped on big
> endian.  There are some other endian issue and some special registers
> which requires many custom dma_ops/tp_ops routines and build_dmatable.
> 
> Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
> Acked-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

applied
