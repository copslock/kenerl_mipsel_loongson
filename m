Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 19 Mar 2007 10:18:58 +0000 (GMT)
Received: from qb-out-0506.google.com ([72.14.204.237]:7117 "EHLO
	qb-out-0506.google.com") by ftp.linux-mips.org with ESMTP
	id S20021419AbXCSKSx (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 19 Mar 2007 10:18:53 +0000
Received: by qb-out-0506.google.com with SMTP id p30so4527869qba
        for <linux-mips@linux-mips.org>; Mon, 19 Mar 2007 03:17:48 -0700 (PDT)
DKIM-Signature:	a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=D3iMSjsPvoIZ9EnVQEF6Oy0u1qmwWRwHVYUKwoeAHq/qkaIF/uDdSZPUoakMnyd0P/qjXkxxaJ0cv2RJZsPPC4lLcfIYauTRXmVlXY8quPOKkr4HT/d1F9EQr/hIN9M3tQt8IG/kYu0eBnaC30aX7r2M326t4WEznd8455QvLQE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=KcMHhnDDaIk5YfM0EVSWt1ZD65jPuUg3/a3THSCBxtWwjXVDpzzqFvHAaXVBQ9XbwhbTFTeRz77xzoTk69AoHiAEOx74Zga+Mng0ULDGgxnVW29aTCJCV/M5nAJn/p0pC4S6TaGz7A9J1q66BqkQbxGv16Ll0k28a6vwpw2g2GA=
Received: by 10.64.199.2 with SMTP id w2mr8600423qbf.1174299468701;
        Mon, 19 Mar 2007 03:17:48 -0700 (PDT)
Received: by 10.114.136.11 with HTTP; Mon, 19 Mar 2007 03:17:48 -0700 (PDT)
Message-ID: <cda58cb80703190317h80cfd53x4acee55f2c757907@mail.gmail.com>
Date:	Mon, 19 Mar 2007 11:17:48 +0100
From:	"Franck Bui-Huu" <vagabon.xyz@gmail.com>
To:	"Atsushi Nemoto" <anemo@mba.ocn.ne.jp>
Subject: Re: Building 64 bit kernel on Cobalt
Cc:	maillist@jg555.com, linux-mips@linux-mips.org, ralf@linux-mips.org
In-Reply-To: <cda58cb80703190308k4e57e194u56dca25b063646b6@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <45FDB498.1040504@jg555.com>
	 <20070319.101209.79013781.nemoto@toshiba-tops.co.jp>
	 <45FE1D95.8050204@jg555.com>
	 <20070319.150705.100740532.nemoto@toshiba-tops.co.jp>
	 <cda58cb80703190308k4e57e194u56dca25b063646b6@mail.gmail.com>
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14543
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vagabon.xyz@gmail.com
Precedence: bulk
X-list: linux-mips

On 3/19/07, Franck Bui-Huu <vagabon.xyz@gmail.com> wrote:
> On 3/19/07, Atsushi Nemoto <anemo@mba.ocn.ne.jp> wrote:
> > On Sun, 18 Mar 2007 22:20:21 -0700, Jim Gifford <maillist@jg555.com> wrote:
> > > Here's the config file I'm using http://ftp.jg555.com/cobalt.config
> > > Now if I revert all changes that have occurred to setup.c from 2.6.19 to
> > > 2.6.20, everything works perfectly.
> > >
> > > Without that patch, this is as far as it gets.
> >
> > You are using CONFIG_BUILD_ELF64=y and CKSEG0 load address.
> > This combination does not work.  Please refer these threads:
> >
>
> Thanks Atsushi for sorting this out. It's a bit sad to get these type
> of information after so many email echanges...
>

BTW, how this config has ever worked for a 2.6.19 kernel ? I don't see
why using __pa() instead of CPHYSADDR() breaks this config...
-- 
               Franck
