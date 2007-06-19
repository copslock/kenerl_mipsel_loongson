Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 19 Jun 2007 18:00:15 +0100 (BST)
Received: from wx-out-0506.google.com ([66.249.82.228]:56943 "EHLO
	wx-out-0506.google.com") by ftp.linux-mips.org with ESMTP
	id S20023660AbXFSRAN (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 19 Jun 2007 18:00:13 +0100
Received: by wx-out-0506.google.com with SMTP id s14so1781914wxc
        for <linux-mips@linux-mips.org>; Tue, 19 Jun 2007 10:00:12 -0700 (PDT)
DKIM-Signature:	a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=qkRQ8v31O+zOx3AnZN9L5KRleg3UavN8+sFeyWt9D7v/tQrz+EI+A7AFigroKxDIxb726O4kn+JceDK6VtGiAp2kSiGyCpZHAXfrcP5HEtq7KU/UAgiFb1HJDkXzERHKlOLF/L+jJtKKrz0IqL+lkAiNldic1kQlbfbejCj/wJY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=hcZ9gCw2DLnJeeghY+jAyC2FscgIPCK7m1Bqso8liuo94ZCo5+zkF2kymNSSDpR5oTkjxznMHtjYlXJjl7P1bojsw6buW0UCf/JP/IxbOoXnYp0jgv26DkkL57joH3em81h/3kZYeY+UqhW4TIhKI9z/OzP6rwQrMtqJOUIn0Y0=
Received: by 10.90.90.3 with SMTP id n3mr5168095agb.1182272412389;
        Tue, 19 Jun 2007 10:00:12 -0700 (PDT)
Received: by 10.65.204.8 with HTTP; Tue, 19 Jun 2007 10:00:12 -0700 (PDT)
Message-ID: <cda58cb80706191000o4e08dbd1t719f8f61ddd8abca@mail.gmail.com>
Date:	Tue, 19 Jun 2007 19:00:12 +0200
From:	"Franck Bui-Huu" <vagabon.xyz@gmail.com>
To:	"Atsushi Nemoto" <anemo@mba.ocn.ne.jp>
Subject: Re: [PATCH 3/5] Deforest the function pointer jungle in the time code.
Cc:	ralf@linux-mips.org, macro@linux-mips.org, sshtylyov@ru.mvista.com,
	linux-mips@linux-mips.org
In-Reply-To: <20070620.010805.23009775.anemo@mba.ocn.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <cda58cb80706180238r17da4434jcdee307b0385729b@mail.gmail.com>
	 <20070619.005121.118948229.anemo@mba.ocn.ne.jp>
	 <cda58cb80706190033y47ccec58u8fc8254ced24f96f@mail.gmail.com>
	 <20070620.010805.23009775.anemo@mba.ocn.ne.jp>
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15469
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vagabon.xyz@gmail.com
Precedence: bulk
X-list: linux-mips

On 6/19/07, Atsushi Nemoto <anemo@mba.ocn.ne.jp> wrote:
> On Tue, 19 Jun 2007 09:33:33 +0200, "Franck Bui-Huu" <vagabon.xyz@gmail.com> wrote:
> > What do you mean by "pnx8550 can have customized copy of cp0_hpt
> > routines" ? Do you mean that it should copy the whole clock event
> > driver ?
> >
> > It seems to me that using cp0 hpt as a clock event only is a valid usage...
>
> Well, I thought the customized cp0 clockevent codes (custom
> .set_next_event routine is needed anyway, isn't it?)

I don't think so.

hpt-cp0.c clock event part doesn't care if the counter is cleared when
an interrupt is triggered. It matters only for clock source (well I
think) that's why I suggested to rewrite a clock source driver only
for this platform...

-- 
               Franck
