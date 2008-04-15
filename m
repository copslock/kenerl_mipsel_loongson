Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 15 Apr 2008 22:20:15 +0100 (BST)
Received: from fg-out-1718.google.com ([72.14.220.158]:13950 "EHLO
	fg-out-1718.google.com") by ftp.linux-mips.org with ESMTP
	id S20026544AbYDOVT6 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 15 Apr 2008 22:19:58 +0100
Received: by fg-out-1718.google.com with SMTP id d23so2714757fga.32
        for <linux-mips@linux-mips.org>; Tue, 15 Apr 2008 14:19:53 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        bh=L8BW2XOggRiNzdKnAOii+dVtlR/IcizVGaoe/gkgte0=;
        b=qOej/3/c6bvwppNDe2AN/AsCbUCrqMIAu+DnHUXYCRQTCZ07OCWQzC8SWFgr5kDONj2d1bEORlZp7OFRik0LhkeBYfNL/E9oat/0W5cBMGS+vqIPKF4/OxaNwQDSheFn+zzQc4qS4UkzbhpCs85w1KpJ9msCRNBl8S/JpFtaA+M=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=BddKWju2d6Tmt7+kiDdsWPwBuSEJWfCh1ZVkaP8fi2Ia91ZAzLiFoJogBanZIbH9pwMRLvi0fLzPijfC5CwtvkBxqNRGzqtronxOfdZa9KoFKNFHRLvx6EJABc7LNtkD+3GZ44I6Bohpd9fJB5zajLiX3KvymxdqgMWFqo4BlMc=
Received: by 10.86.30.9 with SMTP id d9mr16853571fgd.77.1208294393734;
        Tue, 15 Apr 2008 14:19:53 -0700 (PDT)
Received: from ?192.168.123.7? ( [81.18.197.216])
        by mx.google.com with ESMTPS id s10sm11503456mue.15.2008.04.15.14.19.52
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 15 Apr 2008 14:19:53 -0700 (PDT)
From:	Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH] Au1200: IDE driver build fix
Date:	Tue, 15 Apr 2008 22:55:15 +0200
User-Agent: KMail/1.9.9
Cc:	linux-ide@vger.kernel.org, linux-mips@linux-mips.org
References: <200804142303.04661.sshtylyov@ru.mvista.com>
In-Reply-To: <200804142303.04661.sshtylyov@ru.mvista.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200804152255.15926.bzolnier@gmail.com>
Return-Path: <bzolnier@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18929
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: bzolnier@gmail.com
Precedence: bulk
X-list: linux-mips

On Monday 14 April 2008, Sergei Shtylyov wrote:
> The driver fails to compile with CONFIG_BLK_DEV_IDE_AU1XXX_MDMA2_DBDMA enabled:
> 
> drivers/ide/mips/au1xxx-ide.c: In function `auide_build_dmatable':
> drivers/ide/mips/au1xxx-ide.c:256: error: implicit declaration of function
> `sg_virt'
> drivers/ide/mips/au1xxx-ide.c:275: error: implicit declaration of function
> `sg_next'
> drivers/ide/mips/au1xxx-ide.c:275: warning: assignment makes pointer from
> integer without a cast
> 
> Fix this by including <linux/scatterlist.h>. While at it, remove the #include's
> without which the driver happily builds.
> 
> Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

applied
