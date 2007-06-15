Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 15 Jun 2007 16:35:49 +0100 (BST)
Received: from py-out-1112.google.com ([64.233.166.182]:65290 "EHLO
	py-out-1112.google.com") by ftp.linux-mips.org with ESMTP
	id S20022454AbXFOPfr (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 15 Jun 2007 16:35:47 +0100
Received: by py-out-1112.google.com with SMTP id f31so1744631pyh
        for <linux-mips@linux-mips.org>; Fri, 15 Jun 2007 08:34:46 -0700 (PDT)
DKIM-Signature:	a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=CR7hY2QXfX7CibH1bDRaJLKphbxizpl0+BdvjLEi6nVNCt3y7cNA9821x5LmdiLVbg1wz5qFVktFJSG1UQ6P4gAtCTrcJTku2UbPltcznbmKWqzKnRH8oqlXHXwi12Yl8ugDJ8gmEazADeAIdBb16RhurFBMzjvbTnOKifVl170=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=lmNG6Vq8KGrfIx5g1c4qvtYGX9AIZ+8Minr5JXJ6MvYGYOLC5xiFa9m5X9rOicxlSEl8YPvnb0b+Hw6vojV6963tSdVIj6C9Dq5eYNZcB5ja+NJBWE7vgq2D/IWIrfcyT5w795kpuBmeatp0Dmcm9wsn6aIDB2NBc368vC0iLD0=
Received: by 10.65.138.4 with SMTP id q4mr5387677qbn.1181921686349;
        Fri, 15 Jun 2007 08:34:46 -0700 (PDT)
Received: by 10.65.204.8 with HTTP; Fri, 15 Jun 2007 08:34:46 -0700 (PDT)
Message-ID: <cda58cb80706150834h88eca05o849c9b763d92d934@mail.gmail.com>
Date:	Fri, 15 Jun 2007 17:34:46 +0200
From:	"Franck Bui-Huu" <vagabon.xyz@gmail.com>
To:	"Ralf Baechle" <ralf@linux-mips.org>
Subject: Re: [PATCH 3/5] Deforest the function pointer jungle in the time code.
Cc:	"Maciej W. Rozycki" <macro@linux-mips.org>,
	linux-mips@linux-mips.org
In-Reply-To: <20070615143838.GA11094@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <11818164023940-git-send-email-fbuihuu@gmail.com>
	 <cda58cb80706140643g63c3bf34sbd5b843a15653c3d@mail.gmail.com>
	 <Pine.LNX.4.64N.0706141501080.25868@blysk.ds.pg.gda.pl>
	 <cda58cb80706140731j1b6e8e36l96d4423db1ffd9e7@mail.gmail.com>
	 <Pine.LNX.4.64N.0706141648540.25868@blysk.ds.pg.gda.pl>
	 <cda58cb80706150159j5c3d5b7p4293dc529d5ee97c@mail.gmail.com>
	 <Pine.LNX.4.64N.0706151117180.3754@blysk.ds.pg.gda.pl>
	 <20070615132613.GA16133@linux-mips.org>
	 <cda58cb80706150724i1cbbfd1aw51d23d18e35f6266@mail.gmail.com>
	 <20070615143838.GA11094@linux-mips.org>
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15427
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vagabon.xyz@gmail.com
Precedence: bulk
X-list: linux-mips

On 6/15/07, Ralf Baechle <ralf@linux-mips.org> wrote:
> On Fri, Jun 15, 2007 at 04:24:36PM +0200, Franck Bui-Huu wrote:
>
> > Do you think it's possible to work out a common version of this
> > calibration without to many hacks ? Or should we simply move the
> > current generic one into the dec code and resolve this point later ?
>
> I think that this will be pretty easy and only moderately timeconsuming.
>

Mind to send a patch that will do that ? ;)
-- 
               Franck
