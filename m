Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 22 Aug 2006 13:26:23 +0100 (BST)
Received: from nz-out-0102.google.com ([64.233.162.205]:9059 "EHLO
	nz-out-0102.google.com") by ftp.linux-mips.org with ESMTP
	id S20038727AbWHVM0U (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 22 Aug 2006 13:26:20 +0100
Received: by nz-out-0102.google.com with SMTP id l8so926195nzf
        for <linux-mips@linux-mips.org>; Tue, 22 Aug 2006 05:26:18 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:reply-to:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding:from;
        b=Bo/FT4eGzCjwr7fhHGPl3bO88yPG12h6ZbquRiap3sR1oSF9fhan4RNE+5US4m28COiNwS23vwjVrXwhAOXcEaZPPXgZlc7mqrhUmA8TuhrK9OpIwD2miSA/1J1s2l8TqhjxZVm9G8svfjE9gFcV99RPTHWPagO9inaR+ZJMm/A=
Received: by 10.65.154.10 with SMTP id g10mr8304128qbo;
        Tue, 22 Aug 2006 05:26:18 -0700 (PDT)
Received: from ?192.168.0.24? ( [194.3.162.233])
        by mx.gmail.com with ESMTP id f13sm923076qba.2006.08.22.05.26.16;
        Tue, 22 Aug 2006 05:26:17 -0700 (PDT)
Message-ID: <44EAF7D7.8040600@innova-card.com>
Date:	Tue, 22 Aug 2006 14:25:59 +0200
Reply-To: Franck <vagabon.xyz@gmail.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To:	Ralf Baechle <ralf@linux-mips.org>, anemo@mba.ocn.ne.jp
CC:	linux-mips@linux-mips.org
Subject: Re: cleanup setup.c (take #3)
References: <1155311513926-git-send-email-vagabon.xyz@gmail.com>
In-Reply-To: <1155311513926-git-send-email-vagabon.xyz@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
From:	Franck Bui-Huu <vagabon.xyz@gmail.com>
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12395
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vagabon.xyz@gmail.com
Precedence: bulk
X-list: linux-mips

Ralf, Atsushi,

Anything wrong with this patchset ? I don't think to have miss
any comments or feedbacks...

thanks
		Franck

Franck Bui-Huu wrote:
> Here's a patchset that clean up arch/mips/kernel/setup.c file.
> 
> Changes from take #2:
> ---------------------
> - Include Atsushi Nemoto's comments.
> 
> Changes from take #1:
> ---------------------
> - don't use "initrd=xxx@yyy" semantic anymore for passing initrd
>   memory area through the command line. It sticks with the old 
>   semantic for bootloader compatibilities.
> 
> 		Franck
> 
> Overall diffstat:
> 
>  arch/mips/kernel/setup.c |  441 ++++++++++++++++++++--------------------------
>  1 files changed, 188 insertions(+), 253 deletions(-)
> 
> 
> 
> 
