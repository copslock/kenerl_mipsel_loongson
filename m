Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 17 Jan 2011 12:17:55 +0100 (CET)
Received: from 80-190-117-144.ip-home.de ([80.190.117.144]:47979 "EHLO
        bu3sch.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1493386Ab1AQLRw (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 17 Jan 2011 12:17:52 +0100
Received: by bu3sch.de with esmtpsa (Exim 4.69)
        (envelope-from <mb@bu3sch.de>)
        id 1Pen5o-0008CC-6M; Mon, 17 Jan 2011 12:17:48 +0100
Subject: Re: Merging SSB and HND/AI support
From:   Michael =?ISO-8859-1?Q?B=FCsch?= <mb@bu3sch.de>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     Jonas Gorski <jonas.gorski@gmail.com>, linux-mips@linux-mips.org,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org
In-Reply-To: <1295262781.3726.6.camel@jlt3.sipsolutions.net> (sfid-20110117_121317_233137_FFFFFFFFECA6016B)
References: <AANLkTi=GDcy50zsC6=Dgv1-Ty3cYK2qpx9o=q3JdXuCh@mail.gmail.com>
         (sfid-20110117_114654_053644_FFFFFFFF84F9C750)  <1295261783.24530.3.camel@maggie>
         <1295262781.3726.6.camel@jlt3.sipsolutions.net>
         (sfid-20110117_121317_233137_FFFFFFFFECA6016B)
Content-Type: text/plain; charset="UTF-8"
Date:   Mon, 17 Jan 2011 12:17:42 +0100
Message-ID: <1295263062.24530.6.camel@maggie>
Mime-Version: 1.0
X-Mailer: Evolution 2.30.3 
Content-Transfer-Encoding: 8bit
Return-Path: <mb@bu3sch.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28926
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mb@bu3sch.de
Precedence: bulk
X-list: linux-mips

On Mon, 2011-01-17 at 12:13 +0100, Johannes Berg wrote: 
> On Mon, 2011-01-17 at 11:56 +0100, Michael Büsch wrote:
> 
> > > As far as I can see, there are two possibilities:
> > > 
> > > a) Merge the HND/AI code into the current SSB code, or
> > > 
> > > b) add the missing code for SoCs to brcm80211 and replace the SSB code with it.
> > 
> > Why can't we keep those two platforms separated?
> > Is there really a lot of shared code between SSB and HND/AI?
> 
> I don't think there's a lot of shared code, but I believe that you need
> b43 to be able to target cores on both? And b43 currently uses the SSB
> APIs only.

Yeah right. That's what I was thinking about, too. Just leave SSB alone
and add bus glues to b43 for HND/AI. There's almost no SSB specific code
in b43. So it should be easily possible to add another probe entry from
the (to be written or derived from brcm80211) HND/AI subsystem.

-- 
Greetings Michael.
