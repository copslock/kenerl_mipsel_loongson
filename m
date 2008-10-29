Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 29 Oct 2008 21:03:05 +0000 (GMT)
Received: from fg-out-1718.google.com ([72.14.220.156]:57083 "EHLO
	fg-out-1718.google.com") by ftp.linux-mips.org with ESMTP
	id S22681425AbYJ2VC5 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 29 Oct 2008 21:02:57 +0000
Received: by fg-out-1718.google.com with SMTP id d23so183709fga.32
        for <multiple recipients>; Wed, 29 Oct 2008 14:02:56 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=byvFHRdf6Qi043v4aLDynOcqTo+cDr0gTl8CmW85/k0=;
        b=sSyM5YcyoQW5TwvVfgDQDIkoed8hb8+O8YbT+6zle3niqzbBflXK5iiYlwJeFHXBhU
         c7QwRB/woQPCg0noLcmoLjpJNaLZ2kLTj+xOgOLiUae92JzM0pHoFCNUWm5qxfeSA4wg
         9EJ3weusaMkPnQL6im8EqOe13J/Pp/YO4VNPU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=Hs9101AA/8iszHkHjgYLEs1lkcS0exrTAjQ/G6MBCOhZ/lTqCfKsANgds6uXQIxgcd
         0+hh25IDS2PWymtxhmwilHHdgQN03E/gmbk4nW830V4DbCORIH1/rp55jXCydmkjVvs/
         y479e7hpknDka3cQAoF3rOm6AirhSmKH24CR0=
Received: by 10.181.144.11 with SMTP id w11mr2514616bkn.27.1225314176328;
        Wed, 29 Oct 2008 14:02:56 -0700 (PDT)
Received: by 10.180.239.14 with HTTP; Wed, 29 Oct 2008 14:02:56 -0700 (PDT)
Message-ID: <90edad820810291402q3a9bbf41i45401867c28535fb@mail.gmail.com>
Date:	Wed, 29 Oct 2008 23:02:56 +0200
From:	"Dmitri Vorobiev" <dmitri.vorobiev@gmail.com>
To:	"Ralf Baechle" <ralf@linux-mips.org>
Subject: Re: [PATCH] CHAR: Delete old and now unused M48T35 RTC driver for SGI IP27.
Cc:	linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
	"Dmitri Vorobiev" <dmitri.vorobiev@movial.fi>
In-Reply-To: <1225113552-15376-2-git-send-email-ralf@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <90edad820810270453s57954112m627859eac685f404@mail.gmail.com>
	 <1225113552-15376-2-git-send-email-ralf@linux-mips.org>
Return-Path: <dmitri.vorobiev@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21095
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dmitri.vorobiev@gmail.com
Precedence: bulk
X-list: linux-mips

2008/10/27 Ralf Baechle <ralf@linux-mips.org>:
> It was only used by this one SGI platform which recently was converted to
> RTC_LIB and with RTC_LIB enabled the legacy drivers are no more selectable.
>
> Signed-off-by: Ralf Baechle <ralf@linux-mips.org>

Acked-by: Dmitri Vorobiev <dmitri.vorobiev@movial.fi>
