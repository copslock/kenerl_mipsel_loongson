Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 31 Jul 2006 17:31:25 +0100 (BST)
Received: from wx-out-0102.google.com ([66.249.82.198]:38291 "EHLO
	wx-out-0102.google.com") by ftp.linux-mips.org with ESMTP
	id S8126944AbWGaQbO (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 31 Jul 2006 17:31:14 +0100
Received: by wx-out-0102.google.com with SMTP id h29so97936wxd
        for <linux-mips@linux-mips.org>; Mon, 31 Jul 2006 09:31:10 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:reply-to:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding:from;
        b=U+xoXEpQLVJuRoi1agsT3tEfSOsk8M8tO2krJk6E6rbHB5FpaB7p+Nd/QZ+rfXab6cPWQbu8GxpWbnHqJg/aowIpHjUAbSH+NyBo1+H7GN8hKwC4TvJadmyfSbWgBlWncUC725RnyMMZ9oPVmQl519/ruaGMa5gu2QIVmzRRyv0=
Received: by 10.70.67.4 with SMTP id p4mr2946400wxa;
        Mon, 31 Jul 2006 09:31:10 -0700 (PDT)
Received: from ?192.168.0.24? ( [194.3.162.233])
        by mx.gmail.com with ESMTP id i14sm1828626wxd.2006.07.31.09.31.08;
        Mon, 31 Jul 2006 09:31:09 -0700 (PDT)
Message-ID: <44CE3015.8040605@innova-card.com>
Date:	Mon, 31 Jul 2006 18:30:13 +0200
Reply-To: Franck <vagabon.xyz@gmail.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
CC:	vagabon.xyz@gmail.com, linux-mips@linux-mips.org,
	ralf@linux-mips.org
Subject: Re: [PATCH] dump_stack() based on prologue code analysis (take 2)
References: <20060729.232720.108740310.anemo@mba.ocn.ne.jp>	<44CDC657.9090403@innova-card.com> <20060731.235626.86888625.anemo@mba.ocn.ne.jp>
In-Reply-To: <20060731.235626.86888625.anemo@mba.ocn.ne.jp>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
From:	Franck Bui-Huu <vagabon.xyz@gmail.com>
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12137
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vagabon.xyz@gmail.com
Precedence: bulk
X-list: linux-mips

Atsushi Nemoto wrote:
> On Mon, 31 Jul 2006 10:59:03 +0200, Franck Bui-Huu <vagabon.xyz@gmail.com> wrote:
>> my comments included with this patch...(you can find the plain patch
>> at the end of this email)
>>

This time your patch a _really_ been commited. So there won't be a take 3.
I'll start a new thread including my comments I sent tomorrow.

Thanks.
		Franck
