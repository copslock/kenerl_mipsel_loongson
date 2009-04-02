Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 02 Apr 2009 20:36:46 +0100 (BST)
Received: from mail-fx0-f175.google.com ([209.85.220.175]:36787 "EHLO
	mail-fx0-f175.google.com") by ftp.linux-mips.org with ESMTP
	id S20030218AbZDBTgk (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 2 Apr 2009 20:36:40 +0100
Received: by fxm23 with SMTP id 23so742240fxm.0
        for <linux-mips@linux-mips.org>; Thu, 02 Apr 2009 12:36:33 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version
         :content-disposition:message-id:content-type
         :content-transfer-encoding;
        bh=IgTYLBKEzDVewOE1MIFdCM/V/m7MhPdnpbgADYL5Rws=;
        b=ITYtTsjgQT9dILWs6GM+4QW/6piNxL5oDC7mCOdszBMY1jOvawnDqbtSkO2gOcAl1M
         QFv0C8Ab7FYqi9K30k9q0c2SZOgIvEG9GFszXxFhGEHP1LPLFOoZbh9skFya2+/70i+E
         Z6H/edyhg+4Vo/1dZX1yHuyV5+dXI5+t2HNz8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-disposition:message-id:content-type
         :content-transfer-encoding;
        b=wCzUvLn9a54RYp/xymJVCozMGWR26ZA8Lb88G8zZe8SV2Jbx8LKyaUBIfiHzSG+Lbh
         LCayNL0Ze74riBVgQ3kgXR2EpEDxbGbwrmC3DreDp8W0HAFTrDrjm9+43G1IlKY06d9u
         Pdu8ucestfcVpiyqv9meg0xHB3IPWCR35/qwE=
Received: by 10.103.198.20 with SMTP id a20mr178240muq.63.1238700993505;
        Thu, 02 Apr 2009 12:36:33 -0700 (PDT)
Received: from localhost.localdomain (chello089077051219.chello.pl [89.77.51.219])
        by mx.google.com with ESMTPS id 7sm848613mup.19.2009.04.02.12.36.31
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 02 Apr 2009 12:36:32 -0700 (PDT)
From:	Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To:	KOBAYASHI Yoshitake <yoshitake.kobayashi@toshiba.co.jp>
Subject: Re: [PATCH] linux-next remove wmb() from ide-dma-sff.c and scc_pata.c
Date:	Thu, 2 Apr 2009 21:08:32 +0200
User-Agent: KMail/1.11.1 (Linux/2.6.29-next-20090401; KDE/4.2.1; i686; ; )
Cc:	Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>,
	"IDE/ATA Devel" <linux-ide@vger.kernel.org>,
	Grant Grundler <grundler@google.com>,
	Atsushi Nemoto <anemo@mba.ocn.ne.jp>,
	LKML <linux-kernel@google.com>,
	"Linux/MIPS Development" <linux-mips@linux-mips.org>,
	"Linux/PPC Development" <linuxppc-dev@ozlabs.org>
References: <da824cf30903301739l688e8eb2r46086953245ebbe5@mail.gmail.com> <alpine.LRH.2.00.0903310950040.9551@vixen.sonytel.be> <49D1E384.8080009@toshiba.co.jp>
In-Reply-To: <49D1E384.8080009@toshiba.co.jp>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200904022108.32808.bzolnier@gmail.com>
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-Path: <bzolnier@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22248
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: bzolnier@gmail.com
Precedence: bulk
X-list: linux-mips

On Tuesday 31 March 2009, KOBAYASHI Yoshitake wrote:
> 2009/03/31 16:51, Geert Uytterhoeven wrote:
> > On Mon, 30 Mar 2009, Grant Grundler wrote:
> >> Followup to "[PATCH 03/10] ide: destroy DMA mappings after ending DMA"
> >> email on March 14th:
> >>     http://lkml.org/lkml/2009/3/14/17
> >>
> >> No maintainer is listed for "Toshiba CELL Reference Set IDE" (BLK_DEV_CELLEB)
> >> or tx4939ide.c in MAINTAINERS. I've CC'd "Ishizaki Kou" @Toshiba (Maintainer for
> >> "Spidernet Network Driver for CELL") and linuxppc-dev list in the hope
> >> someone else
> >> would know or would be able to ACK this patch.
> > 
> > tx49xx is MIPS, for Nemoto-san.
> 
> The patch looks good for Toshiba Cell Reference Set.

Great, I applied the patch.

Thanks,
Bart
