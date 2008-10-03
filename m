Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 03 Oct 2008 18:43:37 +0100 (BST)
Received: from gv-out-0910.google.com ([216.239.58.191]:51720 "EHLO
	gv-out-0910.google.com") by ftp.linux-mips.org with ESMTP
	id S20475020AbYJCRnf (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 3 Oct 2008 18:43:35 +0100
Received: by gv-out-0910.google.com with SMTP id e6so305349gvc.2
        for <linux-mips@linux-mips.org>; Fri, 03 Oct 2008 10:43:33 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version
         :content-disposition:message-id:content-type
         :content-transfer-encoding;
        bh=N+dE0NvGG5VhCY+OO9GxYMtoQVZ8n3Dj90YYtKf8+1U=;
        b=p0wis1vlPz12pyKC3H5RCmu9Xo34yNTZJGdhAEhrxkoLPrfRxFDuaTwEoyLAx1+0Nb
         Yh1+bHBHunboRY9SBrJ0D68OfewkIEzzSjNcUQHpG4QWKsRdXaifGQ6eOVUYOt5CCYXg
         uQC8OM1kfV6mrji3Ce4/p/eCX5IwjqYWHAxIU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-disposition:message-id:content-type
         :content-transfer-encoding;
        b=Xa5L1u29g/C/0OiZ91WF6lk4q4BC2UkkPs4vo/Imrzsqm7JH9U3k/jUYu6V0mt2OXJ
         N6K/dXZNWxSPT1cq/cJH0vWKwEBn+xVvGYngxTh+dCMPIeTyR/s8yXI2Gsr/2Z0lY21R
         5RYePNa8MyvdCgr8QdToia03iloDp302zSOuA=
Received: by 10.103.211.3 with SMTP id n3mr898151muq.43.1223055813591;
        Fri, 03 Oct 2008 10:43:33 -0700 (PDT)
Received: from ?192.168.123.7? (chello089077041080.chello.pl [89.77.41.80])
        by mx.google.com with ESMTPS id i5sm1190367mue.11.2008.10.03.10.43.31
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 03 Oct 2008 10:43:32 -0700 (PDT)
From:	Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH v2] IDE: Fix platform device registration in Swarm IDE driver
Date:	Fri, 3 Oct 2008 19:00:54 +0200
User-Agent: KMail/1.9.10
Cc:	Ralf Baechle <ralf@linux-mips.org>, linux-ide@vger.kernel.org,
	"Maciej W. Rozycki" <macro@linux-mips.org>,
	linux-mips@linux-mips.org
References: <20080922122853.GA15210@linux-mips.org> <20080928175450.GA8478@linux-mips.org> <48DFFC62.9050300@ru.mvista.com>
In-Reply-To: <48DFFC62.9050300@ru.mvista.com>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200810031900.55214.bzolnier@gmail.com>
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-Path: <bzolnier@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20681
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: bzolnier@gmail.com
Precedence: bulk
X-list: linux-mips

On Sunday 28 September 2008, Sergei Shtylyov wrote:
> Hello.
> 
> Ralf Baechle wrote:
> 
> > The Swarm IDE driver uses a release method which is defined in the driver
> > itself thus potentially oopsable.  The simple fix would be to just leak
> > the device but this patch goes the full length and moves the entire
> > handling of the platform device in the platform code and retains only
> > the platform driver code in drivers/ide/mips/swarm.c.
> >
> > Signed-off-by: Ralf Baechle <ralf@linux-mips.org>

wow, v2 happened really quickly :)

> Acked-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

applied

[ I removed no longer needed BLK_DEV_IDE_SWARM from ide/Kconfig while at it ]
