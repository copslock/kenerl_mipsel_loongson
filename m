Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 02 Apr 2009 20:37:11 +0100 (BST)
Received: from mail-fx0-f175.google.com ([209.85.220.175]:19188 "EHLO
	mail-fx0-f175.google.com") by ftp.linux-mips.org with ESMTP
	id S20030717AbZDBTgl (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 2 Apr 2009 20:36:41 +0100
Received: by fxm23 with SMTP id 23so742261fxm.0
        for <linux-mips@linux-mips.org>; Thu, 02 Apr 2009 12:36:35 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=vF1vRkjWd0ntPBZDJzf8X9qwU3PZWEvRf5pd97eDhpw=;
        b=MyzXMy2v0JmauSKswcKoc4/jYf5HUKc43H+9vBMAE+x3+sxi8wOiX7ZmzxZ21VDpaJ
         ouqdSBfKXbpa7zClFzTGYO2uylxaQa5cvZ+GtCsXpD7sQLMcyoWM+Ne8YUsItEAkXzm5
         JVhbBGF3pCZZqs1heeaHOHQBR0b+VwG3L1pS8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=C7GRbzzpWFK6HzxWT6W26FBfVSQZsXXNkXkxVR+3sEw3XMmtCD7VM1M1OKw3ww0wzd
         eB8+Fu+ljs7QaKfbtW+jHnFFPnY0NQdfReS3Tgz4+PlJ/pYwQXh4hojQ/7VhNYeS8T8S
         VToYGJ4RXkmrNXLtmeGMPypiXvdZWZcj+Z5IU=
Received: by 10.103.102.18 with SMTP id e18mr174353mum.82.1238700995256;
        Thu, 02 Apr 2009 12:36:35 -0700 (PDT)
Received: from localhost.localdomain (chello089077051219.chello.pl [89.77.51.219])
        by mx.google.com with ESMTPS id 7sm848613mup.19.2009.04.02.12.36.33
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 02 Apr 2009 12:36:34 -0700 (PDT)
From:	Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Subject: Re: [PATCH] tx4939ide: remove wmb()
Date:	Thu, 2 Apr 2009 21:11:15 +0200
User-Agent: KMail/1.11.1 (Linux/2.6.29-next-20090401; KDE/4.2.1; i686; ; )
Cc:	Grant Grundler <grundler@google.com>, linux-ide@vger.kernel.org,
	linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
References: <1238516136-15852-1-git-send-email-anemo@mba.ocn.ne.jp>
In-Reply-To: <1238516136-15852-1-git-send-email-anemo@mba.ocn.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200904022111.15347.bzolnier@gmail.com>
Return-Path: <bzolnier@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22249
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: bzolnier@gmail.com
Precedence: bulk
X-list: linux-mips

On Tuesday 31 March 2009, Atsushi Nemoto wrote:
> * define CHECK_DMA_MASK
> * remove use of wmb()
> 
> Suggested-by: Grant Grundler <grundler@google.com>
> Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>

applied
