Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 26 Oct 2006 09:41:15 +0100 (BST)
Received: from [80.76.149.213] ([80.76.149.213]:27524 "EHLO
	ch-smtp02.sth.basefarm.net") by ftp.linux-mips.org with ESMTP
	id S20037554AbWJZIlM (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 26 Oct 2006 09:41:12 +0100
Received: from c83-250-8-219.bredband.comhem.se ([83.250.8.219]:35319 helo=mail.ferretporn.se)
	by ch-smtp02.sth.basefarm.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.63)
	(envelope-from <creideiki+linux-mips@ferretporn.se>)
	id 1Gd0nW-0006pM-6f; Thu, 26 Oct 2006 10:41:10 +0200
Received: from www.ferretporn.se (unknown [192.168.0.3])
	by mail.ferretporn.se (Postfix) with ESMTP id BC74D3B73;
	Thu, 26 Oct 2006 10:41:02 +0200 (CEST)
Received: from 136.163.203.3
        (SquirrelMail authenticated user creideiki)
        by www.ferretporn.se with HTTP;
        Thu, 26 Oct 2006 10:41:02 +0200 (CEST)
Message-ID: <54630.136.163.203.3.1161852062.squirrel@www.ferretporn.se>
In-Reply-To: <20061026.130552.11963152.nemoto@toshiba-tops.co.jp>
References: <20061024140614.GB27800@linux-mips.org>
    <6285.136.163.203.3.1161704681.squirrel@www.ferretporn.se>
    <20061025.174504.71086461.nemoto@toshiba-tops.co.jp>
    <20061026.130552.11963152.nemoto@toshiba-tops.co.jp>
Date:	Thu, 26 Oct 2006 10:41:02 +0200 (CEST)
Subject: Re: Extreme system overhead on large IP27
From:	"Karl-Johan Karlsson" <creideiki+linux-mips@ferretporn.se>
To:	"Atsushi Nemoto" <anemo@mba.ocn.ne.jp>
Cc:	linux-mips@linux-mips.org
User-Agent: SquirrelMail/1.4.8
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Priority: 3 (Normal)
Importance: Normal
X-Scan-Result: No virus found in message 1Gd0nW-0006pM-6f.
X-Scan-Signature: ch-smtp02.sth.basefarm.net 1Gd0nW-0006pM-6f f60690501a9475ddfc8bc4d6ffb7fae6
Return-Path: <creideiki+linux-mips@ferretporn.se>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13099
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: creideiki+linux-mips@ferretporn.se
Precedence: bulk
X-list: linux-mips

On Thu, October 26, 2006 06:05, Atsushi Nemoto wrote:
> static struct clocksource clocksource_mips = {
> 	.name		= "MIPS",
> 	.rating		= 250,
> 	.read		= read_mips_hpt,
> 	.shift		= 24,
> 	.is_continuous	= 1,
> };
>
> [...]
>
> I'll cook a patch later but until
> then you can use lesser shift value, for example, 20.

Setting it to 20 works, thanks.

-- 
Karl-Johan Karlsson
