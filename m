Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 19 Mar 2007 10:09:30 +0000 (GMT)
Received: from qb-out-0506.google.com ([72.14.204.234]:35426 "EHLO
	qb-out-0506.google.com") by ftp.linux-mips.org with ESMTP
	id S20021414AbXCSKJ2 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 19 Mar 2007 10:09:28 +0000
Received: by qb-out-0506.google.com with SMTP id e12so4557569qba
        for <linux-mips@linux-mips.org>; Mon, 19 Mar 2007 03:08:23 -0700 (PDT)
DKIM-Signature:	a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=OyDeARL4AeloMtMmc0DHTYROFAeNCrBnS9qU/TU/k4L3nbL52SpnBMerpQCYruPsBOhBueBv0hXo0sqUVh54ywU3obHnMYSkH4FnQPD3WPV3opiMMy79NTpMg83fnj2PVF8x2OAVkaluc+Y9hNsozyc94u+fa72J7hbutd67UCM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=pwK3LCgovqd4JFWoUzxZvDXagIVmm3a1wncPJXLvxbJxZ8X+iW6Gnt4LAdNwtFhp1iAg1ucxOTrvB5GyrbE/II9gCcdFTT6NjfW4wjqEN9+z/QL6XYpzLLZpgKNDTrscE6h9jjcfpcSUPHamd63CZt+J1pS870m5ARj4ymOwe7E=
Received: by 10.65.239.14 with SMTP id q14mr7367382qbr.1174298903375;
        Mon, 19 Mar 2007 03:08:23 -0700 (PDT)
Received: by 10.114.136.11 with HTTP; Mon, 19 Mar 2007 03:08:23 -0700 (PDT)
Message-ID: <cda58cb80703190308k4e57e194u56dca25b063646b6@mail.gmail.com>
Date:	Mon, 19 Mar 2007 11:08:23 +0100
From:	"Franck Bui-Huu" <vagabon.xyz@gmail.com>
To:	"Atsushi Nemoto" <anemo@mba.ocn.ne.jp>
Subject: Re: Building 64 bit kernel on Cobalt
Cc:	maillist@jg555.com, linux-mips@linux-mips.org, ralf@linux-mips.org
In-Reply-To: <20070319.150705.100740532.nemoto@toshiba-tops.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <45FDB498.1040504@jg555.com>
	 <20070319.101209.79013781.nemoto@toshiba-tops.co.jp>
	 <45FE1D95.8050204@jg555.com>
	 <20070319.150705.100740532.nemoto@toshiba-tops.co.jp>
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14542
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vagabon.xyz@gmail.com
Precedence: bulk
X-list: linux-mips

On 3/19/07, Atsushi Nemoto <anemo@mba.ocn.ne.jp> wrote:
> On Sun, 18 Mar 2007 22:20:21 -0700, Jim Gifford <maillist@jg555.com> wrote:
> > Here's the config file I'm using http://ftp.jg555.com/cobalt.config
> > Now if I revert all changes that have occurred to setup.c from 2.6.19 to
> > 2.6.20, everything works perfectly.
> >
> > Without that patch, this is as far as it gets.
>
> You are using CONFIG_BUILD_ELF64=y and CKSEG0 load address.
> This combination does not work.  Please refer these threads:
>

Thanks Atsushi for sorting this out. It's a bit sad to get these type
of information after so many email echanges...

>
> Please try CONFIG_BUILD_ELF64=n.
>
> BTW, Ralf, any chance to Franck's CONFIG_BUILD_ELF64 cleanup patchset?
> I hope the patchset make things clearer...
>

Well, this patch may be not enough. From last thread about 64bits kernel issue:

http://marc.info/?l=linux-mips&m=117418351419352&w=2

It seems that objcopy can be used to do some addresses translations.
In that case the current patch won't help. At least we could add more
sanity checks to detect all buggy configs we can have for 64 bits
kernel and panic if they fail.
-- 
               Franck
