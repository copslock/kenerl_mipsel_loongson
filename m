Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 14 Jun 2007 08:37:32 +0100 (BST)
Received: from py-out-1112.google.com ([64.233.166.181]:42564 "EHLO
	py-out-1112.google.com") by ftp.linux-mips.org with ESMTP
	id S20022662AbXFNHha (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 14 Jun 2007 08:37:30 +0100
Received: by py-out-1112.google.com with SMTP id f31so862620pyh
        for <linux-mips@linux-mips.org>; Thu, 14 Jun 2007 00:36:29 -0700 (PDT)
DKIM-Signature:	a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Gxb8Nz0/JW9DB6ZLpw3et1ys0cI9raEtdcNi53Q6GWv3JFpRLDpUeRgPOW3SyHsGn3jnqEbiqORm0YbIRuypUGpABjJoKn8CW28WmVX5vmsOS3XXcMvhFGBzugM2rJE3Rq/M93KOGZH7/0/mizeUomljawFEcqq7yPc77aFx9Mk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=mQXiGM32mfAJhUZjf0U853s+Tqw0ou0O8kfjl2RTnAjeSRL9DQtuowQAKK0ebL8uNXsjEaGdCrCqEV42h4h/DU7M7LvcXNm0vlcFIflxTovnX01AWfkJh/U0++EAB7L9md9qi2eMB9/jke7f4f08B9B8R4lQiNuuHMEXJwhMsjY=
Received: by 10.65.81.10 with SMTP id i10mr2619010qbl.1181806587851;
        Thu, 14 Jun 2007 00:36:27 -0700 (PDT)
Received: by 10.65.204.8 with HTTP; Thu, 14 Jun 2007 00:36:27 -0700 (PDT)
Message-ID: <cda58cb80706140036p2771be21n5ed5474c029e779c@mail.gmail.com>
Date:	Thu, 14 Jun 2007 09:36:27 +0200
From:	"Franck Bui-Huu" <vagabon.xyz@gmail.com>
To:	"Yoichi Yuasa" <yoichi_yuasa@tripeaks.co.jp>
Subject: Re: [PATCH 3/3] Remove Momenco Ocelot C support
Cc:	"Ralf Baechle" <ralf@linux-mips.org>, linux-mips@linux-mips.org
In-Reply-To: <20070614161144.5725a8d5.yoichi_yuasa@tripeaks.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <11815673353523-git-send-email-fbuihuu@gmail.com>
	 <118156733610-git-send-email-fbuihuu@gmail.com>
	 <20070613185232.GA27392@linux-mips.org>
	 <20070614161144.5725a8d5.yoichi_yuasa@tripeaks.co.jp>
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15390
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vagabon.xyz@gmail.com
Precedence: bulk
X-list: linux-mips

Hi Yoichi,

On 6/14/07, Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp> wrote:
> On Wed, 13 Jun 2007 19:52:32 +0100
> Ralf Baechle <ralf@linux-mips.org> wrote:
>
> > On Mon, Jun 11, 2007 at 03:08:55PM +0200, Franck Bui-Huu wrote:
> >
> > > Momenco Ocelot C support is deprecated and scheduled for removal
> > > since September 2006.
> >
> > And totally untested since ages.  2.6.22 will be its last summer ;-)
> >
> > Patch queued up to 2.6.23, actually already a few days ago.
>
> Please queue this patch too.
>

Good catch !

Thanks
-- 
               Franck
