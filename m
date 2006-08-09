Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 09 Aug 2006 09:22:13 +0100 (BST)
Received: from nf-out-0910.google.com ([64.233.182.190]:31203 "EHLO
	nf-out-0910.google.com") by ftp.linux-mips.org with ESMTP
	id S20041940AbWHIIWK (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 9 Aug 2006 09:22:10 +0100
Received: by nf-out-0910.google.com with SMTP id o60so81478nfa
        for <linux-mips@linux-mips.org>; Wed, 09 Aug 2006 01:22:02 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:reply-to:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding:from;
        b=rX6ZQb8ycR9hqXQhjundRoMv5hDRCGjADhru5rhB8aYlvdD3LpYInf5wsSVpamoC2l80DxCPw9D5KUAaDDOVO9e3Jhr9cab0+IlKc5h1tfIiQ7DQjeB1q1jMTHdRgQmC8RFX571V+NntXmvI0d4/GpNwW8OmovpcJhqQnTaDOzQ=
Received: by 10.48.210.20 with SMTP id i20mr1029234nfg;
        Wed, 09 Aug 2006 01:22:02 -0700 (PDT)
Received: from ?192.168.0.24? ( [194.3.162.233])
        by mx.gmail.com with ESMTP id x24sm1975269nfb.2006.08.09.01.22.01;
        Wed, 09 Aug 2006 01:22:02 -0700 (PDT)
Message-ID: <44D99B02.1070406@innova-card.com>
Date:	Wed, 09 Aug 2006 10:21:22 +0200
Reply-To: Franck <vagabon.xyz@gmail.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
CC:	vagabon.xyz@gmail.com, ths@networkno.de, linux-mips@linux-mips.org,
	ralf@linux-mips.org, yoichi_yuasa@tripeaks.co.jp
Subject: Re: [PATCH 6/6] setup.c: use early_param() for early command line
 parsing
References: <1155041313139-git-send-email-vagabon.xyz@gmail.com>	<20060808125604.GI29989@networkno.de>	<44D898FE.7080006@innova-card.com> <20060809.010526.18607898.anemo@mba.ocn.ne.jp>
In-Reply-To: <20060809.010526.18607898.anemo@mba.ocn.ne.jp>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
From:	Franck Bui-Huu <vagabon.xyz@gmail.com>
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12244
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vagabon.xyz@gmail.com
Precedence: bulk
X-list: linux-mips

Hi Atsushi,

Atsushi Nemoto wrote:
> On Tue, 08 Aug 2006 16:00:30 +0200, Franck Bui-Huu <vagabon.xyz@gmail.com> wrote:
>>>> NOTE ! This patch also changes the initrd semantic. Old code
>>>> was expecting "rd_start=xxx rd_size=xxx" which uses two
>>>> parameters. Now the code expects "initrd=xxx@yyy" which is
>>>> really simpler to parse and to use. No default config files
>>>> use these parameters anyways but not sure for bootloader's
>>>> users...
>>> This code is there precisely because most mips bootloaders use
>>> rd_start/rd_size.
>> OK, I guess we have to stick with this weird semantic...
> 
> Maybe you can add something like "initrdmem=xxx@yyy", keeping
> "rd_start" and "rd_size" for the backward compatibility.  Just a
> thought.
> 

Well that what I was planning when writing this patch but I didn't.
I think that we will end up with two different semantics and the
old one never replaced by the new one... Except if we mark them as
deprecated by showing a warning at boot. What do you think ?

		Franck
