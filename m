Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 19 Sep 2008 18:11:14 +0100 (BST)
Received: from rv-out-0708.google.com ([209.85.198.250]:38650 "EHLO
	rv-out-0708.google.com") by ftp.linux-mips.org with ESMTP
	id S29558965AbYISRLH (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 19 Sep 2008 18:11:07 +0100
Received: by rv-out-0708.google.com with SMTP id c5so570050rvf.24
        for <linux-mips@linux-mips.org>; Fri, 19 Sep 2008 10:11:05 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version
         :content-disposition:message-id:content-type
         :content-transfer-encoding;
        bh=ZcwHg7lK60+y8mFPHrcrfl7URNfnAG67iww/u+UcHYo=;
        b=OtHyktkhvr8fcvSWd4QOgX02vU1DPcxTjSDUMBFUdDL89zm3CcWFC23uPC4vIjJwmv
         RMOkpMFlKKRHmFb2bcnISxEjKu0OqvjxHpNLLSE108rsOvwToqnlHwvRCZvcoiD/d5DM
         rzH+Q6epUfyWUWPJuubVwiq+7uprTsTeoR9zA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-disposition:message-id:content-type
         :content-transfer-encoding;
        b=afcmis+HkkyncKEPyGrvSmHY3HQhsVenNB+mune4qULAZDNzanPK+JBeX3Pumwo5rm
         Gjue8nSj34TCPfhXJj0OOVH5kxxIpPN8gmXBJxxpI1m/Bpn6Q2++8vNk9bZpOl5bClt3
         E103tfPW7yPnm7t1F9dqlLvIBIMe15m5IMgBk=
Received: by 10.140.136.6 with SMTP id j6mr188579rvd.231.1221844264993;
        Fri, 19 Sep 2008 10:11:04 -0700 (PDT)
Received: from host-246-131.pubnet.pdx.edu ( [131.252.246.131])
        by mx.google.com with ESMTPS id b39sm1502873rvf.0.2008.09.19.10.10.58
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 19 Sep 2008 10:11:02 -0700 (PDT)
From:	Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 1/2] ide: Add tx4939ide driver (v2)
Date:	Fri, 19 Sep 2008 10:10:08 -0700
User-Agent: KMail/1.9.9
Cc:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>, linux-mips@linux-mips.org,
	linux-ide@vger.kernel.org, ralf@linux-mips.org
References: <20080918.001342.52129176.anemo@mba.ocn.ne.jp> <200809181645.10410.bzolnier@gmail.com> <48D37025.2030501@ru.mvista.com>
In-Reply-To: <48D37025.2030501@ru.mvista.com>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200809191010.09457.bzolnier@gmail.com>
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-Path: <bzolnier@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20566
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: bzolnier@gmail.com
Precedence: bulk
X-list: linux-mips

On Friday 19 September 2008 02:25:57 Sergei Shtylyov wrote:
> Hello.
> 
> Bartlomiej Zolnierkiewicz wrote:
> 
> >> This is the driver for the Toshiba TX4939 SoC ATA controller.
> >>
> >> This controller has standard ATA taskfile registers and DMA
> >> command/status registers, but the register layout is swapped on big
> >> endian.  There are some other endian issue and some special registers
> >> which requires many custom dma_ops/port_ops routines.
> >>
> >> Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
> >> ---
> >> This patch is against linux-next 20080916.
> >>
> >> Changes since v1:
> >> * rework IO accessors
> >> * rework pio/dma timing setup
> >> * use ide_get_pair_dev
> >> * do not do ATA hard reset
> >> * and so on  (Many thanks to Sergei)
> >>     
> >
> > Sergei, are you OK with this version?
> >   
> 
>    I didn't have tome to look at it.

I didn't mean to rush you.  I just prefer to have it in pata tree
because I may not have much time to work on ide next week and also
since the code looks much better now the further changes could be
addressed more effectively with the incremental patches.

Thanks,
Bart
