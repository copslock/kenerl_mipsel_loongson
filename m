Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 11 Aug 2006 12:56:26 +0100 (BST)
Received: from py-out-1112.google.com ([64.233.166.177]:5612 "EHLO
	py-out-1112.google.com") by ftp.linux-mips.org with ESMTP
	id S20044670AbWHKL4W (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 11 Aug 2006 12:56:22 +0100
Received: by py-out-1112.google.com with SMTP id m51so122152pye
        for <linux-mips@linux-mips.org>; Fri, 11 Aug 2006 04:56:19 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:reply-to:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding:from;
        b=G11HRnirWYnffi+/SzA8xpxu5rumJ5KHVEcNrf8AnQbzgDITvQ60YoWZ3ADeY2InAsPAucZpFvRgAPq1m44TuO27Px92SviYM73H8V5o+PIDTPU5J98XtElY1wXPdypsswsqwL/jTM8IbiVL4wosRmvjh8qk1xksSN/5heM37zY=
Received: by 10.65.122.20 with SMTP id z20mr3888069qbm;
        Fri, 11 Aug 2006 04:56:19 -0700 (PDT)
Received: from ?192.168.0.24? ( [194.3.162.233])
        by mx.gmail.com with ESMTP id e19sm1436333qba.2006.08.11.04.56.17;
        Fri, 11 Aug 2006 04:56:18 -0700 (PDT)
Message-ID: <44DC703C.4050109@innova-card.com>
Date:	Fri, 11 Aug 2006 13:55:40 +0200
Reply-To: Franck <vagabon.xyz@gmail.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To:	Franck Bui-Huu <vagabon.xyz@gmail.com>
CC:	linux-mips@linux-mips.org, anemo@mba.ocn.ne.jp,
	ralf@linux-mips.org, yoichi_yuasa@tripeaks.co.jp
Subject: Re: [PATCH 6/6] setup.c: use early_param() for early command line
 parsing
References: <11551351581277-git-send-email-vagabon.xyz@gmail.com> <11551351592752-git-send-email-vagabon.xyz@gmail.com>
In-Reply-To: <11551351592752-git-send-email-vagabon.xyz@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
From:	Franck Bui-Huu <vagabon.xyz@gmail.com>
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12280
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vagabon.xyz@gmail.com
Precedence: bulk
X-list: linux-mips

Franck Bui-Huu wrote:
> There's no point to rewrite some logic to parse command line
> to pass initrd parameters or to declare a user memory area.
> We could use instead parse_early_param() that does the same
> thing.
> 

Funny, Rusty Russel has recently posted a patch to make all
arch use early_param(). See

http://marc.theaimsgroup.com/?l=linux-kernel&m=115528095722115&w=2

So this patch seems come at the right time.

		Franck
