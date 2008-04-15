Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 15 Apr 2008 22:19:59 +0100 (BST)
Received: from fk-out-0910.google.com ([209.85.128.190]:13796 "EHLO
	fk-out-0910.google.com") by ftp.linux-mips.org with ESMTP
	id S20026534AbYDOVT5 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 15 Apr 2008 22:19:57 +0100
Received: by fk-out-0910.google.com with SMTP id f40so4215339fka.0
        for <linux-mips@linux-mips.org>; Tue, 15 Apr 2008 14:19:56 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-disposition:message-id:content-type:content-transfer-encoding;
        bh=baOtjHGeW11SJ1cEGq6bP/dSCU8Afhqi/omkh/Noy3Q=;
        b=B3wYvDgGoahgpTs/yGQAwzLrBRVLu54fTGviARvA/PhyRSkBeTHBxdx/EzIViS/KgLnBYFzcw6mXMuJo9htL8HB54NgLt7BWf8hzBGERnGkcDOvIiiq7FR43cD/i4tGmv+WcM0q8G+aegiWdLeDt8VJyMPvk6qig/hhd5t/H7eQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-disposition:message-id:content-type:content-transfer-encoding;
        b=SEVyqf7TcHLEkt9oHt/v+JgFASaw5oQ8QXdfJoP4s6BAfGsfYjEm+BTfNE3a9cxveJ0LCsrcAhEMPcGDn2Hn+Tnf96J48o0BfwQNJCKQKKs/Mf8HHndyEylncSx5qatd+KIsVDCUTvkh5ZYPUcjpfsj01Gxam4cwtsHN9aFnjI0=
Received: by 10.82.151.14 with SMTP id y14mr5550251bud.62.1208294395444;
        Tue, 15 Apr 2008 14:19:55 -0700 (PDT)
Received: from ?192.168.123.7? ( [81.18.197.216])
        by mx.google.com with ESMTPS id s10sm11503456mue.15.2008.04.15.14.19.53
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 15 Apr 2008 14:19:54 -0700 (PDT)
From:	Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH] Pb1200/DBAu1200: fix bad IDE resource size
Date:	Tue, 15 Apr 2008 23:09:11 +0200
User-Agent: KMail/1.9.9
Cc:	linux-mips@linux-mips.org, linux-ide@vger.kernel.org,
	ralf@linux-mips.org
References: <200804152044.32912.sshtylyov@ru.mvista.com>
In-Reply-To: <200804152044.32912.sshtylyov@ru.mvista.com>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200804152309.11471.bzolnier@gmail.com>
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-Path: <bzolnier@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18928
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: bzolnier@gmail.com
Precedence: bulk
X-list: linux-mips

On Tuesday 15 April 2008, Sergei Shtylyov wrote:
> The header files for the Pb1200/DBAu1200 boards have wrong definition for the
> IDE interface's  decoded range length -- it should be 512 bytes according to
> what the IDE driver does.  In addition, the IDE platform device claims 1 byte
> too many for its memory resource -- fix the platform code and the IDE driver
> in accordance.
> 
> Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>
> 
> ---
> I'm not sure thru which tree this should go -- probably thru Linux/MIPS one...

Well, since I've been already merging the other au1xxx-ide patches
to IDE tree I've also applied this one while at it...

>  arch/mips/au1000/common/platform.c    |    2 +-
>  drivers/ide/mips/au1xxx-ide.c         |    7 ++++---
>  include/asm-mips/mach-db1x00/db1200.h |    4 ++--
>  include/asm-mips/mach-pb1x00/pb1200.h |    4 ++--
>  4 files changed, 9 insertions(+), 8 deletions(-)
