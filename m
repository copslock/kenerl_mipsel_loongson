Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 05 Mar 2013 15:19:17 +0100 (CET)
Received: from mail-pb0-f44.google.com ([209.85.160.44]:55663 "EHLO
        mail-pb0-f44.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6827567Ab3CEOTOrxfMl (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 5 Mar 2013 15:19:14 +0100
Received: by mail-pb0-f44.google.com with SMTP id wz12so4508018pbc.17
        for <linux-mips@linux-mips.org>; Tue, 05 Mar 2013 06:19:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=W8qs3DaoJ+oGmebyAAKKw4FnKFauxNv9k57+a7Hl7vA=;
        b=hQZcik2UhJna1zd/4nBBxA01g7vr49hW001B8fDHA5EKcOAV/8JT8DuGDMTRHtVMcc
         UM9SRVUWyF6xmTtGfu1Cg4CR24+hbyzz/sJV3PUrN5GmiBc/GbsDGKqQJS/zEK42VKnX
         5EiI5tMRT8y9zzXmjxaIxyWrD3ffAs+mosGlM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent:x-gm-message-state;
        bh=W8qs3DaoJ+oGmebyAAKKw4FnKFauxNv9k57+a7Hl7vA=;
        b=TEFOMpeRymnbJIeLpHkGkIqrnyW0x19iS09LCcX41+9QZixxXI1w71VtHgytLdVx8e
         Od2lQvwwh/xuwxJ0OvT8zIrEfgZqQpO7R4cDBhwPxg43408zvxS/ccZUQEeeG7jnU485
         5QhjyP5OAs3TAHDEmw/7UPQB6yZUZwPQUz+AqaIQ+T3+/+u3HSOlnG8sY958uX+bTmPd
         LgriPI/iAFg6o+emA0Z6FHFBSZtL03nUKYPPVtVAnIXldcniVit8wDK05WCNavVAYXYb
         Y1CKt4LLrgbzNboDJ0sqxb0Id9/+I6xdBkUGS11Owo42/0liQDam4RAf5lQDV6zKrBHb
         XjZg==
X-Received: by 10.68.136.42 with SMTP id px10mr38173450pbb.32.1362493147537;
        Tue, 05 Mar 2013 06:19:07 -0800 (PST)
Received: from localhost (li262-33.members.linode.com. [173.255.252.33])
        by mx.google.com with ESMTPS id eh5sm26837608pbc.44.2013.03.05.06.19.04
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 05 Mar 2013 06:19:06 -0800 (PST)
Date:   Tue, 5 Mar 2013 22:19:29 +0800
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Ganesan Ramalignam <ganesanr@broadcom.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: Re: [PATCH] Staging: Netlogic XLR/XLS GMAC driver
Message-ID: <20130305141929.GA4434@kroah.com>
References: <1362464958-8722-1-git-send-email-ganesanr@broadcom.com>
 <20130305065851.GA30028@kroah.com>
 <20130305141353.GB29102@ganesanr.netlogicmircro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20130305141353.GB29102@ganesanr.netlogicmircro.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Gm-Message-State: ALoCoQlplnUaBVc5CBczL8mNd6Nr8PVPHDbM4KZJkuHqmPunbmHIYx16zp3tVakZjeZRg8/3Xvxo
X-archive-position: 35856
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: gregkh@linuxfoundation.org
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

On Tue, Mar 05, 2013 at 07:43:54PM +0530, Ganesan Ramalignam wrote:
> On Tue, Mar 05, 2013 at 02:58:51PM +0800, Greg Kroah-Hartman wrote:
> > On Tue, Mar 05, 2013 at 11:59:18AM +0530, ganesanr@broadcom.com wrote:
> > >  This patch has to be merged via staging tree.
> > > 
> > >  This driver has been submitted to netdev tree and reviewed, the comments 
> > >  are list in TODO list, will be addressed in next cycle of submission, till
> > >  that time I wanted this driver to be in staging tree.
> > > 
> > >  This driver shall be sent to netdev@vger.kernel.org and David Miller <davem@davemloft.net>
> > >  for further review.
> > 
> > When is that going to happen?
> > 
> 
> In two months.

Why then?  What is so magic about 2 months?  In two months, this driver
is not going to be in a released version of the kernel yet.

> > > --- /dev/null
> > > +++ b/drivers/staging/netlogic/Kconfig
> > > @@ -0,0 +1,7 @@
> > > +config NETLOGIC_XLR_NET
> > > +	tristate "Netlogic XLR/XLS network device"
> > > +	depends on CPU_XLR
> > 
> > Why will this not build on any other platform?  It should, right?
> > 
> >
> 
> This driver is for XLR processor ethernet, which is depend on FMN
> for any communication between packet processing agents, so this driver
> depend on XLR platform.

What is "FMN"?

thanks,

greg k-h
