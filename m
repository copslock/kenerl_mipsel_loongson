Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 24 Jan 2007 05:05:08 +0000 (GMT)
Received: from nf-out-0910.google.com ([64.233.182.184]:21455 "EHLO
	nf-out-0910.google.com") by ftp.linux-mips.org with ESMTP
	id S20038962AbXAXFFE (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 24 Jan 2007 05:05:04 +0000
Received: by nf-out-0910.google.com with SMTP id l24so450651nfc
        for <linux-mips@linux-mips.org>; Tue, 23 Jan 2007 21:04:04 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=WnVaDt3CG4VmNi0oUmiNE1KwkgwzNTHZ5b2lez/iMPhvrohcMvN5vto9FfD/+V9EzALuGX5fc7yEvwZKiPfIokiTe6H0nXSuEA9yKG0rBtr7HtaLqJgSwMgT5n4qS6l5WqBfRFmBxrdMXPZTLeu3XXyokT7hB/3Jym4NHZkLoQY=
Received: by 10.82.179.9 with SMTP id b9mr77546buf.1169615043662;
        Tue, 23 Jan 2007 21:04:03 -0800 (PST)
Received: by 10.82.179.13 with HTTP; Tue, 23 Jan 2007 21:04:03 -0800 (PST)
Message-ID: <50c9a2250701232104k317049b3ve1890524cc2ddfea@mail.gmail.com>
Date:	Wed, 24 Jan 2007 13:04:03 +0800
From:	zhuzhenhua <zzh.hust@gmail.com>
To:	"Maarten Lankhorst" <m.b.lankhorst@gmail.com>
Subject: Re: how to choose journal filesystem for embedded linux?
Cc:	linux-mips <linux-mips@linux-mips.org>
In-Reply-To: <45B6E02D.1040206@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <50c9a2250701231805y62ec67f0v83d2fcf3ae2c55da@mail.gmail.com>
	 <45B6E02D.1040206@gmail.com>
Return-Path: <zzh.hust@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13777
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: zzh.hust@gmail.com
Precedence: bulk
X-list: linux-mips

On 1/24/07, Maarten Lankhorst <m.b.lankhorst@gmail.com> wrote:
> zhuzhenhua schreef:
> > hello all:
> >          i now work on a mips board, and want to store my system code
> > on NAND Flash.
> > our Flash driver can handle the Flash features(bad block,  phy  to
> > logic addr, spare,etc.),
> > so i just want to select a journal filesystem to handle sudden poweroff.
> > Our system code(writeable) is about 10M~50M. i am not sure what
> > journal filesystem will be suitable, ext3,xfs,jfs,or reiserFS?
> > i have try ext3, it runs well, but seems to waste too much space
> > while mkfs.ext3.
> Have you tried jffs2? Journaled Flash FileSystem 2
>

the JFFS2 is combile filesytem with FLASH. but our FLASH driver team
have developed a driver good enough to handle FLASH as HD, so we don't
want to use the special FLASH filesystem

Best Regards
