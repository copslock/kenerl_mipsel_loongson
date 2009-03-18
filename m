Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 18 Mar 2009 01:23:56 +0000 (GMT)
Received: from yx-out-1718.google.com ([74.125.44.157]:65531 "EHLO
	yx-out-1718.google.com") by ftp.linux-mips.org with ESMTP
	id S21369164AbZCRBXt convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 18 Mar 2009 01:23:49 +0000
Received: by yx-out-1718.google.com with SMTP id 3so182340yxi.24
        for <multiple recipients>; Tue, 17 Mar 2009 18:23:47 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:received:in-reply-to
         :references:date:x-google-sender-auth:message-id:subject:from:to:cc
         :content-type:content-transfer-encoding;
        bh=q+UUpo1M3Pk8FcE8+NLeOArNUlMO+QfeBw4F84KMbJE=;
        b=JVwML4bJzEjP+Mm8fOYZ1IeT4q7qw+b+4Jx2JVAbpFxwBaGDZmgILSte+C3E4VA3kF
         /FRNdm5AmamaPW6CAZe3qeuha7yczM2luybbHnUglTVAwoS7c8iqDmT9eCQ0B8Ozg18S
         i1ZpddrnjpYcEXZWc30MCuNUP8CPCPFy8nOcQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        b=CH9mMjHavDdvxhVHtYjdx+ZUy3xBxKnq64nXM1hgSET19K8scRfyit0iP43gfswgW0
         7JukRp37rZ+CM9UtL1kpgC24vl1S3QEV3s0q6hiU2gO5Kon+CntCvfA8/MM3ik+5x+TV
         DyabHlt/lmiM2k55wjDXiBmzkDxMBXNQlCrKw=
MIME-Version: 1.0
Received: by 10.114.147.7 with SMTP id u7mr386842wad.138.1237339427032; Tue, 
	17 Mar 2009 18:23:47 -0700 (PDT)
In-Reply-To: <20090318.094935.238694196.nemoto@toshiba-tops.co.jp>
References: <e9c3a7c20903162152w6b73b4b8hba8004e7b349c447@mail.gmail.com>
	 <20090318.010939.128619068.anemo@mba.ocn.ne.jp>
	 <e9c3a7c20903171002n50964148v8366fa2f00e3164c@mail.gmail.com>
	 <20090318.094935.238694196.nemoto@toshiba-tops.co.jp>
Date:	Tue, 17 Mar 2009 18:23:46 -0700
X-Google-Sender-Auth: c02529558b46bc28
Message-ID: <e9c3a7c20903171823g1e6c42b9t5f042d550a6ddd47@mail.gmail.com>
Subject: Re: [PATCH 1/2] dmaengine: TXx9 Soc DMA Controller driver
From:	Dan Williams <dan.j.williams@intel.com>
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc:	linux-mips@linux-mips.org, ralf@linux-mips.org,
	linux-kernel@vger.kernel.org, haavard.skinnemoen@atmel.com
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Return-Path: <dan.j.williams@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22096
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dan.j.williams@intel.com
Precedence: bulk
X-list: linux-mips

On Tue, Mar 17, 2009 at 5:49 PM, Atsushi Nemoto <anemo@mba.ocn.ne.jp> wrote:
> On Tue, 17 Mar 2009 10:02:14 -0700, Dan Williams <dan.j.williams@intel.com> wrote:
> BTW, there are another holes in dma_async_device_register.  If
> idr_pre_get or idr_get_new was failed, idr_ref will not be freed.

Thanks for these fixlets, I appreciate it.

Now, back to the issue at hand.  Does your driver still need direct
control over chan->chan_id, or can it now rely on the fact that
dma_async_device_register() will fail if a channel is not initialized?
 Or, just use some platform_data to identify the channel in the same
manner as atmel-mci?

Regards,
Dan
