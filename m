Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 25 Jul 2009 21:10:55 +0200 (CEST)
Received: from mail-px0-f178.google.com ([209.85.216.178]:33887 "EHLO
	mail-px0-f178.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1493442AbZGYTKt (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sat, 25 Jul 2009 21:10:49 +0200
Received: by pxi8 with SMTP id 8so1750310pxi.22
        for <linux-mips@linux-mips.org>; Sat, 25 Jul 2009 12:10:42 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=uKDnQ5sP5iShFdZ+0Ls1+D/gKVOdG0XpsThnwGve36U=;
        b=IpnvxWN8CFBCHvktFtUWUw8tWsIQmSDHxP83zmVhbH8zYaGchCoXja9x7CQfYrQ8Rz
         Pjnn1sAVJMd36Yte7RWTHqX+5JGLu8+jSeVp90gTOw+AOeokvNgyjeeNO/hmPXnKy4kQ
         atqiYt9E0qc7Vk67elb9sajYmM5zpNqN/3Tn0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=sOV3PqvkgJPicjheVGWmjoc9l1r6QoE0ibBwK7EeLMmcMZ63xMJbH4WiEmBbIgIXRo
         G7lYRnKH9YWSCj++48rzuafdJf7zACW+HdxyMjHrf/YSLSaMbI+jgX7cUZHirLeXszcS
         ZnJnJkknqsfpecDarVF2CKVgSBD0Ep5LclSEM=
Received: by 10.141.1.19 with SMTP id d19mr3071560rvi.145.1248549042290;
        Sat, 25 Jul 2009 12:10:42 -0700 (PDT)
Received: from mailhub.coreip.homeip.net (c-24-6-153-137.hsd1.ca.comcast.net [24.6.153.137])
        by mx.google.com with ESMTPS id g14sm6757832rvb.30.2009.07.25.12.10.40
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 25 Jul 2009 12:10:41 -0700 (PDT)
Date:	Sat, 25 Jul 2009 12:10:37 -0700
From:	Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:	Frans Pop <elendil@planet.nl>
Cc:	Manuel Lauss <manuel.lauss@googlemail.com>,
	linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
	Manuel Lauss <manuel.lauss@gmail.com>,
	"Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH V2] au1xmmc: dev_pm_ops conversion
Message-ID: <20090725191037.GE14062@dtor-d630.eng.vmware.com>
References: <1248275919-3296-1-git-send-email-manuel.lauss@gmail.com> <20090725174449.GC14062@dtor-d630.eng.vmware.com> <200907252019.01266.elendil@planet.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200907252019.01266.elendil@planet.nl>
User-Agent: Mutt/1.5.19 (2009-01-05)
Return-Path: <dmitry.torokhov@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23775
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dmitry.torokhov@gmail.com
Precedence: bulk
X-list: linux-mips

On Sat, Jul 25, 2009 at 08:18:58PM +0200, Frans Pop wrote:
> On Saturday 25 July 2009, Dmitry Torokhov wrote:
> > On Wed, Jul 22, 2009 at 05:18:39PM +0200, Manuel Lauss wrote:
> > > Cc: Frans Pop <elendil@planet.nl>
> > > Signed-off-by: Manuel Lauss <manuel.lauss@gmail.com>
> > >
> > > +
> > > +static struct dev_pm_ops au1xmmc_pmops = {
> > > +	.resume		= au1xmmc_resume,
> > > +	.suspend	= au1xmmc_suspend,
> > > +};
> > > +
> >
> > Was suspend to disk tested? It requires freeze()/thaw().
> 
> Is that a regression introduced by this patch then? If so, many more of 
> the recent dev_pm_ops conversion patches would need to be revisited.

Yes, as far as I understand they would. Let's ask Rafael to confirm...

-- 
Dmitry
