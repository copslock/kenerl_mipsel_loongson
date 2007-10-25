Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 25 Oct 2007 22:46:51 +0100 (BST)
Received: from nf-out-0910.google.com ([64.233.182.186]:12763 "EHLO
	nf-out-0910.google.com") by ftp.linux-mips.org with ESMTP
	id S20027296AbXJYVql (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 25 Oct 2007 22:46:41 +0100
Received: by nf-out-0910.google.com with SMTP id c10so587888nfd
        for <linux-mips@linux-mips.org>; Thu, 25 Oct 2007 14:46:41 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        bh=i3SWtubBdyAODaaKzcCFA1VkGn2KYU46A8nm61M3RYA=;
        b=iQ4/srVv87qj0hiDeQ16id9hYr6uHuFF8lCRHb9cNDTsxk3d4MaIevV2K+I9h/aeP/I7M3XRsVFs0kjimR7k8DNA1jsMwcLV/b5pJwgkyxUujjDfZccpISU2NYvvPLN1tDOZAoTbz4XWnOgmzWsEkNCl6fs6fTBsJ4rrzsgpeGk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=IEGgyvT1n7+CGo3B6hTYRzItdeyCMLjW8kM8zz5F64ww2o9RAvzHV+XfzFW8UuRk4UXz5Ej59nF5F1vvruLqlVisn2cnjkVXO60kx4lJHzQ0WvmliV0dLXzfRsHBSvHpC0Z5uvWmPEdd6hSwHrxLhumzrLPfNr7xSfCW+m/qO1s=
Received: by 10.86.80.5 with SMTP id d5mr1671404fgb.1193348801376;
        Thu, 25 Oct 2007 14:46:41 -0700 (PDT)
Received: from ?192.168.123.7? ( [89.78.229.67])
        by mx.google.com with ESMTPS id e9sm5432117muf.2007.10.25.14.46.40
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 25 Oct 2007 14:46:40 -0700 (PDT)
From:	Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To:	Sam Ravnborg <sam@ravnborg.org>
Subject: Re: [IDE] Fix build bug
Date:	Thu, 25 Oct 2007 23:52:31 +0200
User-Agent: KMail/1.9.7
Cc:	Ralf Baechle <ralf@linux-mips.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org,
	linux-mips@linux-mips.org
References: <20071025135334.GA23272@linux-mips.org> <20071025141305.GA11698@uranus.ravnborg.org>
In-Reply-To: <20071025141305.GA11698@uranus.ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200710252352.32141.bzolnier@gmail.com>
Return-Path: <bzolnier@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17237
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: bzolnier@gmail.com
Precedence: bulk
X-list: linux-mips

On Thursday 25 October 2007, Sam Ravnborg wrote:
> On Thu, Oct 25, 2007 at 02:53:34PM +0100, Ralf Baechle wrote:
> >   CC      drivers/ide/pci/generic.o
> > drivers/ide/pci/generic.c:52: error: __setup_str_ide_generic_all_on causes a
> > +section type conflict
> > 
> > This sort of build error is becoming a regular issue.  Either all or non
> > of the elements that go into a particular section of a compilation unit
> > need to be const.  Or an error may result such as in this case if
> > CONFIG_HOTPLUG is unset.
> So we can avoid this if we invent a __constinitdata tag that uses
> a new section?

I asked similar question on LKML few days ago together with the list of
potentially problematic places:

	http://article.gmane.org/gmane.linux.kernel/594427

Now I see that the list is only partially complete since __initdata and co.
may be also hidden in things like __setup() etc.

Thanks,
Bart
