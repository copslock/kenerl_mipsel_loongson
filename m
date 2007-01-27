Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 27 Jan 2007 05:05:22 +0000 (GMT)
Received: from nf-out-0910.google.com ([64.233.182.185]:2009 "EHLO
	nf-out-0910.google.com") by ftp.linux-mips.org with ESMTP
	id S20027667AbXA0FFS (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sat, 27 Jan 2007 05:05:18 +0000
Received: by nf-out-0910.google.com with SMTP id l24so1260884nfc
        for <linux-mips@linux-mips.org>; Fri, 26 Jan 2007 21:04:17 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=DH+ABQSE4cPTuyBKOSy9b0ZC12TcCVhYuv296bKJCIMrfXdrNz+CT2hpIMw2CfiKrGgBby7Oe5FFyPSZih79GGn6TdgO3TyaQrPdpW1VOcwUC92GkBIy4xQAbpv+N/BhkMFHQrXGzKiCNSSGzIUIjtcHpX6sKz+eyAJ0JE8y7i8=
Received: by 10.82.188.15 with SMTP id l15mr2324211buf.1169874257063;
        Fri, 26 Jan 2007 21:04:17 -0800 (PST)
Received: by 10.82.179.13 with HTTP; Fri, 26 Jan 2007 21:04:17 -0800 (PST)
Message-ID: <50c9a2250701262104g63c0aa0bg82124a216fbedf3d@mail.gmail.com>
Date:	Sat, 27 Jan 2007 13:04:17 +0800
From:	zhuzhenhua <zzh.hust@gmail.com>
To:	"Ladislav Michl" <ladis@linux-mips.org>
Subject: Re: how to choose journal filesystem for embedded linux?
Cc:	linux-mips <linux-mips@linux-mips.org>
In-Reply-To: <20070124144557.GA19790@orphique>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <50c9a2250701231805y62ec67f0v83d2fcf3ae2c55da@mail.gmail.com>
	 <45B6E02D.1040206@gmail.com>
	 <50c9a2250701232104k317049b3ve1890524cc2ddfea@mail.gmail.com>
	 <20070124144557.GA19790@orphique>
Return-Path: <zzh.hust@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13827
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: zzh.hust@gmail.com
Precedence: bulk
X-list: linux-mips

On 1/24/07, Ladislav Michl <ladis@linux-mips.org> wrote:
> On Wed, Jan 24, 2007 at 01:04:03PM +0800, zhuzhenhua wrote:
> > On 1/24/07, Maarten Lankhorst <m.b.lankhorst@gmail.com> wrote:
> > >Have you tried jffs2? Journaled Flash FileSystem 2
> >
> > the JFFS2 is combile filesytem with FLASH. but our FLASH driver team
> > have developed a driver good enough to handle FLASH as HD, so we don't
> > want to use the special FLASH filesystem
>
> Could you provide a short explanation about advantages of such solution?
>
>         ladis
>
>
because for support USB gadget file-storage, it must support VFAT
based something like FTL.
