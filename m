Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 17 Jan 2011 11:56:38 +0100 (CET)
Received: from 80-190-117-144.ip-home.de ([80.190.117.144]:45099 "EHLO
        bu3sch.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1493377Ab1AQK4f (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 17 Jan 2011 11:56:35 +0100
Received: by bu3sch.de with esmtpsa (Exim 4.69)
        (envelope-from <mb@bu3sch.de>)
        id 1PemlB-00088B-DE; Mon, 17 Jan 2011 11:56:29 +0100
Subject: Re: Merging SSB and HND/AI support
From:   Michael =?ISO-8859-1?Q?B=FCsch?= <mb@bu3sch.de>
To:     Jonas Gorski <jonas.gorski@gmail.com>
Cc:     linux-mips@linux-mips.org, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org
In-Reply-To: <AANLkTi=GDcy50zsC6=Dgv1-Ty3cYK2qpx9o=q3JdXuCh@mail.gmail.com> (sfid-20110117_114654_053644_FFFFFFFF84F9C750)
References: <AANLkTi=GDcy50zsC6=Dgv1-Ty3cYK2qpx9o=q3JdXuCh@mail.gmail.com>
         (sfid-20110117_114654_053644_FFFFFFFF84F9C750)
Content-Type: text/plain; charset="UTF-8"
Date:   Mon, 17 Jan 2011 11:56:23 +0100
Message-ID: <1295261783.24530.3.camel@maggie>
Mime-Version: 1.0
X-Mailer: Evolution 2.30.3 
Content-Transfer-Encoding: 7bit
Return-Path: <mb@bu3sch.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28923
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mb@bu3sch.de
Precedence: bulk
X-list: linux-mips

On Mon, 2011-01-17 at 11:46 +0100, Jonas Gorski wrote: 
> Hello,
> 
> I am currently looking into adding support for the newer Broadcom
> BCM47xx/53xx SoCs. They require having HND/AI support, which probably
> means merging the current SSB code and the HND/AI code from the
> brcm80211 driver. Is anyone already working on this?
> 
> As far as I can see, there are two possibilities:
> 
> a) Merge the HND/AI code into the current SSB code, or
> 
> b) add the missing code for SoCs to brcm80211 and replace the SSB code with it.

Why can't we keep those two platforms separated?
Is there really a lot of shared code between SSB and HND/AI?

It's true that there's currently a lot of device functionality built
into ssb. Like pci bridge, mips core, extif, etc...
If you take all that code out, you're probably not left with anything.

So why do we need to replace or merge SSB in the first place? Can't
it co-exist with HND/AI?

-- 
Greetings Michael.
