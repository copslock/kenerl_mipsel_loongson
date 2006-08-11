Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 11 Aug 2006 08:37:31 +0100 (BST)
Received: from wx-out-0506.google.com ([66.249.82.238]:4371 "EHLO
	wx-out-0506.google.com") by ftp.linux-mips.org with ESMTP
	id S20044525AbWHKHh3 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 11 Aug 2006 08:37:29 +0100
Received: by wx-out-0506.google.com with SMTP id h30so736995wxd
        for <linux-mips@linux-mips.org>; Fri, 11 Aug 2006 00:37:25 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:reply-to:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding:from;
        b=gtXTHHXZ9xZERyB5IKahatop+97B2/6QnkCvYgG7YRod0GWj6g2n+8uEisOvLsC61MbZvmpVWrFvnORdu9I44prqHDzhjLyxBJ3RqF6ybQIfrGnb7vE+mNF3M1qyRq4vv5kFkh8+Uo2hQAhwblBiMSDmBz4OJUUBKD8kscM/2t0=
Received: by 10.70.109.12 with SMTP id h12mr4549788wxc;
        Fri, 11 Aug 2006 00:37:25 -0700 (PDT)
Received: from ?192.168.0.24? ( [194.3.162.233])
        by mx.gmail.com with ESMTP id g3sm1733620wra.2006.08.11.00.37.23;
        Fri, 11 Aug 2006 00:37:25 -0700 (PDT)
Message-ID: <44DC338A.3070602@innova-card.com>
Date:	Fri, 11 Aug 2006 09:36:42 +0200
Reply-To: Franck <vagabon.xyz@gmail.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
CC:	vagabon.xyz@gmail.com, ths@networkno.de, linux-mips@linux-mips.org,
	ralf@linux-mips.org, yoichi_yuasa@tripeaks.co.jp
Subject: Re: [PATCH 6/6] setup.c: use early_param() for early command line
 parsing
References: <44D898FE.7080006@innova-card.com>	<20060809.010526.18607898.anemo@mba.ocn.ne.jp>	<44D99B02.1070406@innova-card.com> <20060809.232551.74752502.anemo@mba.ocn.ne.jp>
In-Reply-To: <20060809.232551.74752502.anemo@mba.ocn.ne.jp>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
From:	Franck Bui-Huu <vagabon.xyz@gmail.com>
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12278
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vagabon.xyz@gmail.com
Precedence: bulk
X-list: linux-mips

Atsushi Nemoto wrote:
> On Wed, 09 Aug 2006 10:21:22 +0200, Franck Bui-Huu <vagabon.xyz@gmail.com> wrote:
>>> Maybe you can add something like "initrdmem=xxx@yyy", keeping
>>> "rd_start" and "rd_size" for the backward compatibility.  Just a
>>> thought.
>> Well that what I was planning when writing this patch but I didn't.
>> I think that we will end up with two different semantics and the
>> old one never replaced by the new one... Except if we mark them as
>> deprecated by showing a warning at boot. What do you think ?
> 
> While the kernel command line is very limited resource (only 256
> chars), I prefer a single short option to specify initrd range, if
> available.
> 
> But nothing wrong with rd_start and rd_size, and it seems there are
> some boot loader expected them already, so removing them would not be
> good (especially without some grace period).
> 
> I don't care if there were two way to specify initrd range.  It would
> be somewhat redundant, but that is usual on "Backword compatibility"
> issue, isn't it?  ;-)
> 

Well, I resent a new version (take #2) of the patchset that uses _only_
"rd_xxx" semantic. I prefer not add some code which isn't going to be
used. Mainly because only bootloaders use this parameter and I guess
they never change the way they pass initrd address. And there won't be
a lot of new bootloaders anyways.

Thanks
		Franck
