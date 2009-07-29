Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 29 Jul 2009 16:27:14 +0200 (CEST)
Received: from mail-fx0-f224.google.com ([209.85.220.224]:33664 "EHLO
	mail-fx0-f224.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1492999AbZG2O1H convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 29 Jul 2009 16:27:07 +0200
Received: by fxm24 with SMTP id 24so975006fxm.31
        for <multiple recipients>; Wed, 29 Jul 2009 07:27:02 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=NYfw3E1+6yaU7iUpNsvdMuJlwdxtb9VTk0S19OSrAbY=;
        b=KvP9W1zuygBy7eF7tvP9v/Kd55bgawkkpC8WU74nQjeVpAYus+UYj0SlHAd/x4WJWc
         mi0IC1cSn72iD9YggwVzDpSFFnDhyR3A5zhPtotw6n+3YjukeoDJ+69wqvH0oLfJBSGT
         AjKJBHBFHv4WC8UccGKhVXa2Tq5KWkwl0sgAQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=EcoKoU6ekfcSPzrqbW6uMSIMaEeDtH9hARWpbrB8FPdcMLhzBMZi+fYS1lM22h1h7P
         rXRfJkY824ZDPUrkmTODLAuVOpq5TpE6vUcIw7TVlCnK1tqGd+Js1lw41bfwc01R4abU
         tfo6VLVLOf0Qn/1EvpMZxULEYch7ELlGJoqkY=
MIME-Version: 1.0
Received: by 10.223.126.69 with SMTP id b5mr4384313fas.34.1248877622411; Wed, 
	29 Jul 2009 07:27:02 -0700 (PDT)
In-Reply-To: <4A70517A.6060006@ru.mvista.com>
References: <200907282300.14118.florian@openwrt.org>
	 <f861ec6f0907290015v34d277beh18efed6aac10aa79@mail.gmail.com>
	 <200907291010.09526.florian@openwrt.org>
	 <4A70517A.6060006@ru.mvista.com>
Date:	Wed, 29 Jul 2009 16:27:02 +0200
Message-ID: <f861ec6f0907290727q3955d0fave0fb0a18bb035284@mail.gmail.com>
Subject: Re: [PATCH 1/4] alchemy: register au1000_eth as a platform driver 
	part one
From:	Manuel Lauss <manuel.lauss@googlemail.com>
To:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc:	Florian Fainelli <florian@openwrt.org>,
	Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Return-Path: <manuel.lauss@googlemail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23791
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: manuel.lauss@googlemail.com
Precedence: bulk
X-list: linux-mips

Hi Sergei,

>> Yes I know ;) I was just wanting to get this out quickly before you kill
>> platform.c
>
>   I'd NAK such patch (and have already done so, AFAIR).

I've already surrendered myself to the fact that I'll never be able to get rid
of this file in my lifetime.  However I've set a timer on my mail machine to
send a patch (which I'll keep rebasing to latest sources) trying that again
in 80 years or so ;-)


>> I will make the au1000-eth devices be registered on a per-board basis.
>
>   Please don't. You can register them in platform.c, and yet leave actually
> board specific platform data in the board files. There's no reason to
> duplicate the platfrom device itself.

Let's say I have 2 pieces of hardware, indentical in all things,
except one has an Au1100, and the other Au1500 (different MAC mmio
address and unit counts).  I want to build a kernel which runs on both.
This can certainly be done, but the existence of common/platform.c and
your insistence on maintaining the status-quo limits me to one board
per kernel (theoretical example currently, i know).

I also dislike having to #ifdef around this file when a new platform
is introduced which doesn't need/use all devices registered in there!
(for example au1200 mmc platform data. Suppose I have a platform
which doesn't use mmc; I can either add a #ifdef for my new board or
provide empty platform data stubs in my board code.  Both solutions
suck IMO; the former because then when I (and others) submit new
board code upstream common/platform.c will develop into a mess of
random #ifdefs (just look at common/reset.c!) and the latter because
platform data and -device registration are in different places in the
source tree.

Manuel Lauss
