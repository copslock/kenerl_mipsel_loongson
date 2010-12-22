Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 22 Dec 2010 11:27:48 +0100 (CET)
Received: from gateway15.websitewelcome.com ([69.56.150.8]:55588 "HELO
        gateway15.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with SMTP id S1490979Ab0LVK1o (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 22 Dec 2010 11:27:44 +0100
Received: (qmail 22218 invoked from network); 22 Dec 2010 10:27:48 -0000
Received: from gator750.hostgator.com (174.132.194.2)
  by gateway15.websitewelcome.com with SMTP; 22 Dec 2010 10:27:48 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; s=default; d=paralogos.com;
        h=Received:Message-ID:Date:From:User-Agent:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:X-Source:X-Source-Args:X-Source-Dir;
        b=WEcPoa+vVA5YNH/3DHbv7SY5xmIjyfVIZAQydnXTJcdCew8EsglOlNjYZnNermcqzN8LL/ZvjG7soP6l47MygaqvYDeNTOWKFI/zsC89+U/xzHKZjBj3c1t+Q+f+/BO7;
Received: from [88.123.214.42] (port=49815 helo=kkissell-macbookpro.local)
        by gator750.hostgator.com with esmtpsa (TLSv1:AES256-SHA:256)
        (Exim 4.69)
        (envelope-from <kevink@paralogos.com>)
        id 1PVLv0-0001V7-HJ; Wed, 22 Dec 2010 04:27:39 -0600
Message-ID: <4D11D28D.80501@paralogos.com>
Date:   Wed, 22 Dec 2010 02:27:25 -0800
From:   "Kevin D. Kissell" <kevink@paralogos.com>
User-Agent: Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10.5; en-US; rv:1.9.2.13) Gecko/20101207 Thunderbird/3.1.7
MIME-Version: 1.0
To:     "Anoop P.A." <Anoop_P.A@pmc-sierra.com>
CC:     Anoop P A <anoop.pa@gmail.com>,
        STUART VENTERS <stuart.venters@adtran.com>,
        linux-mips@linux-mips.org
Subject: Re: SMTC support status in latest git head.
References: <8F242B230AD6474C8E7815DE0B4982D7179FB880@EXV1.corp.adtran.com>        <4D0A677C.6040104@paralogos.com>        <4D0A6F63.8080206@paralogos.com>        <4D0BD7A0.1030504@paralogos.com> <AANLkTikTn_Lw=vqtfUyDW7GXxq75ZYLGi8_MyVVyPkKt@mail.gmail.com> <4D10F7A9.1020306@paralogos.com> <A7DEA48C84FD0B48AAAE33F328C020140595D731@BBY1EXM11.pmc_nt.nt.pmc-sierra.bc.ca> <A7DEA48C84FD0B48AAAE33F328C020140595D732@BBY1EXM11.pmc_nt.nt.pmc-sierra.bc.ca>
In-Reply-To: <A7DEA48C84FD0B48AAAE33F328C020140595D732@BBY1EXM11.pmc_nt.nt.pmc-sierra.bc.ca>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator750.hostgator.com
X-AntiAbuse: Original Domain - linux-mips.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - paralogos.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Return-Path: <kevink@paralogos.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28673
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kevink@paralogos.com
Precedence: bulk
X-list: linux-mips

 > Sorry I misunderstood file. git blame shows that "andi" is around for 
quite
 > some time.

I've never used git blame, so I don't know how far it can be trusted, 
but if that change was made in 2006, that would predate the major 
breakage by several
years.  So my suggestion from yesterday is a reasonable one:

 > I think that if you were to tweak mips-mt.c at line 103 to change
 > the
 >
 >        tcstatval = flags; /* And pre-dump TCStatus is flags */
 >
 > to something more like
 >
 > /* Pre-dump TCStatus Interrupt Inhibit bit is in flags variable */
 > tcstatval = (read_c0_tcstatus() & ~0x400) | flags;
 >
 > should fix the dump.

With that patch, if you re-run the experiment of hang-breakout-dump, we 
might be able to deduce something.

Ralf wrote to me independently to say that my message from yesterday 
with that suggestion and some other commentary got eaten once again by 
the LMO mail forwarder because of the HTML content.  With all due 
respect, I'm using a very standard open-source mail client (Thunderbird) 
with a very normal option (reply to text with text, HTML with HTML).  
Perhaps it it's the LMO mail system that needs to change, and not the 
mail configurations of the whole LMO community.

             Regards,

             Kevin K.
