Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 23 Oct 2008 22:50:49 +0100 (BST)
Received: from gv-out-0910.google.com ([216.239.58.186]:3516 "EHLO
	gv-out-0910.google.com") by ftp.linux-mips.org with ESMTP
	id S22248765AbYJWVuC (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 23 Oct 2008 22:50:02 +0100
Received: by gv-out-0910.google.com with SMTP id e6so120293gvc.2
        for <linux-mips@linux-mips.org>; Thu, 23 Oct 2008 14:50:02 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=nCjAdkTMleNs/KJorj/Aog512KrjhNz+yf8Yl72miJQ=;
        b=VzBR0CFNglI6F9Im7yP9TS6wVGXRLFYr4IrVJIVWff/B3/7WQ7vVCRTwlVzpYQdBWX
         Ui8ipDEUEMtbTol2x16NMNo3ar7EMVpFTn+T8L4WkYulCl1HAdshnxjcNFEhaRluK1sl
         UBLJH/zi7R6463BEZljPPa93DjtboJIR5gm4E=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=DdawIINxC/rrltYYYCSZMC5Mg9zUGcsDtazjKGJNQMNacaOto93sVBJiABpesQGn/E
         n5i2jHun7xXJXdtxfcPtb13UFFAMnk47/wYpU/jComPTl7LLZWCHa7y6YA8w9wjTcf8F
         3c+KlOTKevxihTZALfu/63zWzCXkmv5kUr7Zw=
Received: by 10.103.1.5 with SMTP id d5mr607935mui.99.1224798601972;
        Thu, 23 Oct 2008 14:50:01 -0700 (PDT)
Received: from ?192.168.123.7? (chello089077041080.chello.pl [89.77.41.80])
        by mx.google.com with ESMTPS id y37sm20631980mug.13.2008.10.23.14.50.00
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 23 Oct 2008 14:50:01 -0700 (PDT)
From:	Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH] TXx9: Add TX4938 ATA support (v2)
Date:	Thu, 23 Oct 2008 22:06:50 +0200
User-Agent: KMail/1.9.10
Cc:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>, linux-mips@linux-mips.org,
	linux-ide@vger.kernel.org, ralf@linux-mips.org
References: <20081023.011646.51867355.anemo@mba.ocn.ne.jp> <20081023.231618.126142426.anemo@mba.ocn.ne.jp> <4900ACA8.2030303@ru.mvista.com>
In-Reply-To: <4900ACA8.2030303@ru.mvista.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200810232206.50973.bzolnier@gmail.com>
Return-Path: <bzolnier@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20877
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: bzolnier@gmail.com
Precedence: bulk
X-list: linux-mips

On Thursday 23 October 2008, Sergei Shtylyov wrote:
> Hello.
> 
> Atsushi Nemoto wrote:
> 
> > From: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
> > Subject: [PATCH] TXx9: Add TX4938 ATA support (v3)
> 
> > Add a helper routine to register tx4938ide driver and use it on
> > RBTX4938 board.
> 
> > Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
> 
>     The patch already had my
> 
> Acked-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

applied
