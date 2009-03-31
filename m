Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 31 Mar 2009 20:35:09 +0100 (BST)
Received: from rv-out-0708.google.com ([209.85.198.245]:17893 "EHLO
	rv-out-0506.google.com") by ftp.linux-mips.org with ESMTP
	id S20023740AbZCaTfC convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 31 Mar 2009 20:35:02 +0100
Received: by rv-out-0506.google.com with SMTP id b17so1668105rvf.0
        for <multiple recipients>; Tue, 31 Mar 2009 12:34:59 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:received:in-reply-to
         :references:date:x-google-sender-auth:message-id:subject:from:to:cc
         :content-type:content-transfer-encoding;
        bh=cL9WIvUvZQA+dBNMltyy+yY7mfo7xk8stSTL+Hwr2dQ=;
        b=DFnHVrOI8mBbrBA4b488ZZrR2A8scyhegqPi//YZkReN89VzvN6ipbT8vvYtsFbQXr
         yqf+RKlnpTrwmGkJaHf28GwKWGBVo9FlgXvDlud5jg4zBxwJoI+UnLGAaoEFCXVC6AQF
         CYUH1FhXrM6KcicrHL1NGOQcs3TRlB8YmnmtQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        b=xrqXYMiJmYBSIWl9LpgRjfkETTa/WdGPoxCHLvLBW5wIf87hJmwQ/JmRYZVIh6EARe
         PO00K9dTJbxU7TADxtI3Y23HTcVkZBTxjtOr70PT5LI8qJsesaC8fPYVkxw7IEFgxeSH
         73Vp3jmVxFaoyg4jWjYZ2nX2rfR8U2yjMPXuk=
MIME-Version: 1.0
Received: by 10.114.174.2 with SMTP id w2mr4603332wae.195.1238528099289; Tue, 
	31 Mar 2009 12:34:59 -0700 (PDT)
In-Reply-To: <20090326.231243.112855442.anemo@mba.ocn.ne.jp>
References: <20090318.110154.76582864.nemoto@toshiba-tops.co.jp>
	 <e9c3a7c20903181026h1801ef6i945e6ce9ccb36b8a@mail.gmail.com>
	 <20090321.212920.25912728.anemo@mba.ocn.ne.jp>
	 <20090326.231243.112855442.anemo@mba.ocn.ne.jp>
Date:	Tue, 31 Mar 2009 12:34:59 -0700
X-Google-Sender-Auth: ef1f37b66b6e19c6
Message-ID: <e9c3a7c20903311234t63335987l46480cd27a326022@mail.gmail.com>
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
X-archive-position: 22219
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dan.j.williams@intel.com
Precedence: bulk
X-list: linux-mips

On Thu, Mar 26, 2009 at 7:12 AM, Atsushi Nemoto <anemo@mba.ocn.ne.jp> wrote:
> On Sat, 21 Mar 2009 21:29:20 +0900 (JST), Atsushi Nemoto <anemo@mba.ocn.ne.jp> wrote:
> Unfortunately, not so simple.  If I created a dma_device for each
> channel, all chan->chan_id will be 0 and all chan->device->dev points
> same platform device.  This makes client driver hard to select the
> particular channel.  Making a platform device for each channel will
> solve this, but it looks wrong way to go for me.

Why?  mv_xor, iop-adma, and ioat each have a platform or pci device
per channel so you would be in good company.
