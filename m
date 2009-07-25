Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 25 Jul 2009 19:45:04 +0200 (CEST)
Received: from wf-out-1314.google.com ([209.85.200.170]:28641 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org
	with ESMTP id S1493422AbZGYRo6 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sat, 25 Jul 2009 19:44:58 +0200
Received: by wf-out-1314.google.com with SMTP id 28so159972wfa.21
        for <linux-mips@linux-mips.org>; Sat, 25 Jul 2009 10:44:54 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=s1/Cc067N9VXYITtDUnSVil/Z5Rgw4LGzDyqdHrYlaE=;
        b=vWtTqEp6C15pFbH7QK4mP3euwGiYAZfn0r6by/eFjKBlLlgijFeJRqspqGXyqHTcca
         i/jpxPIxgLrPcJrw/YXkacVlcEjsWFgUbDynJhc7alorecxuprwlmMxzZpV78dI9OR4R
         dOdh4lzeIdVJa3zNoekw2QH+mGpDSMzzWGGmQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=JQLLWNwHStUeEJM6f9kvKYeLiuGFGRlGrJHAEfyTx7WfdXHnYf5a/qt5ErI/EmVn76
         sDYY/L37Q+4ITEi49jQcsmy233lXDaOsU6IUuUpN2CRrrqArWS6/PfOQ4Vx/R1hurtF4
         gfVO4GMc2eNNoCFgpMFT2gtJ3v6jzxWDqxMv4=
Received: by 10.142.173.6 with SMTP id v6mr718698wfe.233.1248543894170;
        Sat, 25 Jul 2009 10:44:54 -0700 (PDT)
Received: from mailhub.coreip.homeip.net (c-24-6-153-137.hsd1.ca.comcast.net [24.6.153.137])
        by mx.google.com with ESMTPS id f21sm12000837rvb.6.2009.07.25.10.44.52
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 25 Jul 2009 10:44:53 -0700 (PDT)
Date:	Sat, 25 Jul 2009 10:44:50 -0700
From:	Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:	Manuel Lauss <manuel.lauss@googlemail.com>
Cc:	linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
	Manuel Lauss <manuel.lauss@gmail.com>,
	Frans Pop <elendil@planet.nl>
Subject: Re: [PATCH V2] au1xmmc: dev_pm_ops conversion
Message-ID: <20090725174449.GC14062@dtor-d630.eng.vmware.com>
References: <1248275919-3296-1-git-send-email-manuel.lauss@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1248275919-3296-1-git-send-email-manuel.lauss@gmail.com>
User-Agent: Mutt/1.5.19 (2009-01-05)
Return-Path: <dmitry.torokhov@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23772
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dmitry.torokhov@gmail.com
Precedence: bulk
X-list: linux-mips

Hi Manuel,

On Wed, Jul 22, 2009 at 05:18:39PM +0200, Manuel Lauss wrote:
> Cc: Frans Pop <elendil@planet.nl>
> Signed-off-by: Manuel Lauss <manuel.lauss@gmail.com>
>
> +
> +static struct dev_pm_ops au1xmmc_pmops = {
> +	.resume		= au1xmmc_resume,
> +	.suspend	= au1xmmc_suspend,
> +};
> +

Was suspend to disk tested? It requires freeze()/thaw().

-- 
Dmitry
