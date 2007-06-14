Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 14 Jun 2007 15:32:03 +0100 (BST)
Received: from ag-out-0708.google.com ([72.14.246.240]:46642 "EHLO
	ag-out-0708.google.com") by ftp.linux-mips.org with ESMTP
	id S20022957AbXFNOcB (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 14 Jun 2007 15:32:01 +0100
Received: by ag-out-0708.google.com with SMTP id 33so272269agc
        for <linux-mips@linux-mips.org>; Thu, 14 Jun 2007 07:31:47 -0700 (PDT)
DKIM-Signature:	a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=BO8ZE9KmjLS69JSvmvqmaTYny6OWZ0lp2SpFwkx5o4r9nv3QioxdqdhRlap3GGvXgrDsXxm7Dxh7axO58xh5lK7N9+VVTWIY2SFH+OEOoqs47vtLQaPv+bmQx2nhr50/GCQwhwfOLdSrX2wllGK/hOx6g1gceo3KA5n9moA5uGk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=LkRr9+DPds71/7er9fFBX2ACUR6NH3ryWyLRWqekr941rB8u5p0HVhFEQiZOfe/bkMLN/staCsl8UAj7nmPVADZEIdBTlfWqFuZ4Wmhvi8Ccac2KLtHTnKprRpoepM9sqbXqZCQaTTZOFTQI3HCawKuKK8Tcz/kWvlvYFXCqPbY=
Received: by 10.90.52.18 with SMTP id z18mr1481107agz.1181831507261;
        Thu, 14 Jun 2007 07:31:47 -0700 (PDT)
Received: by 10.65.204.8 with HTTP; Thu, 14 Jun 2007 07:31:47 -0700 (PDT)
Message-ID: <cda58cb80706140731j1b6e8e36l96d4423db1ffd9e7@mail.gmail.com>
Date:	Thu, 14 Jun 2007 16:31:47 +0200
From:	"Franck Bui-Huu" <vagabon.xyz@gmail.com>
To:	"Maciej W. Rozycki" <macro@linux-mips.org>
Subject: Re: [PATCH 3/5] Deforest the function pointer jungle in the time code.
Cc:	"Thomas Bogendoerfer" <tsbogend@alpha.franken.de>,
	linux-mips@linux-mips.org, "Ralf Baechle" <ralf@linux-mips.org>
In-Reply-To: <Pine.LNX.4.64N.0706141501080.25868@blysk.ds.pg.gda.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <11818164011355-git-send-email-fbuihuu@gmail.com>
	 <11818164023940-git-send-email-fbuihuu@gmail.com>
	 <20070614111748.GA8223@alpha.franken.de>
	 <cda58cb80706140643g63c3bf34sbd5b843a15653c3d@mail.gmail.com>
	 <Pine.LNX.4.64N.0706141501080.25868@blysk.ds.pg.gda.pl>
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15402
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vagabon.xyz@gmail.com
Precedence: bulk
X-list: linux-mips

Hi,

On 6/14/07, Maciej W. Rozycki <macro@linux-mips.org> wrote:
> On Thu, 14 Jun 2007, Franck Bui-Huu wrote:
>
> > The current code doesn't automatically calibrate any hpt. It was
> > really hard to guess which ones need that so now if you need to
> > calibrate your hpt, then you have to call calibrate_hpt().
>
>  You are wrong -- calibration is currently automatic if a platform
> provides a HPT, but has not set up its frequency:

Well it all depends on what you call "current" code... My own fault I
should have said "new" instead of "current", sorry.

> Which should normally be the case unless there is no way to do
> calibration, when a platform can provide a hardcoded value.  There is
> nothing to guess here.
>

Are you sure it's the normal case? I would say that only DEC needs
that calibration:

Doing the following on the _current_ tree:

$ git grep -l mips_timer_state arch/mips
arch/mips/dec/time.c
arch/mips/kernel/time.c

>  I'll have a look at your patches, but I hope you have got about the most
> interesting configuration right, which is the DEC platform, where you can
> have one of these:

As I said, all platforms haven't been migrated, but DEC seems an
interesting one to migrate. I'll try to do it and see if you can
accept such changes.

>
> 1. No HPT at all.
>
> 2. HPT in the chipset.
>
> 3. HPT in CP0.
>
> depending on the configuration as determined at the run time, with no
> predefined frequency in the cases #2 and #3.
>

Good to know.

Thanks
-- 
               Franck
