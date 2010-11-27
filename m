Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 27 Nov 2010 20:28:19 +0100 (CET)
Received: from 80-190-117-144.ip-home.de ([80.190.117.144]:46756 "EHLO
        bu3sch.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1492342Ab0K0T2L (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sat, 27 Nov 2010 20:28:11 +0100
Received: by bu3sch.de with esmtpsa (Exim 4.69)
        (envelope-from <mb@bu3sch.de>)
        id 1PMQRM-00012Q-MW; Sat, 27 Nov 2010 20:28:08 +0100
Subject: Re: [PATCH RESEND] ssb: fix nvram_get on bcm47xx platform
From:   Michael =?ISO-8859-1?Q?B=FCsch?= <mb@bu3sch.de>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Hauke Mehrtens <hauke@hauke-m.de>, linux-mips@linux-mips.org,
        netdev@vger.kernel.org
In-Reply-To: <20101127192407.GA7175@linux-mips.org> (sfid-20101127_202412_992616_FFFFFFFF948CDA76)
References: <1290882392-28327-1-git-send-email-hauke@hauke-m.de>
         <20101127191138.GB4867@linux-mips.org>
         <20101127192407.GA7175@linux-mips.org>
         (sfid-20101127_202412_992616_FFFFFFFF948CDA76)
Content-Type: text/plain; charset="UTF-8"
Date:   Sat, 27 Nov 2010 20:27:57 +0100
Message-ID: <1290886077.15605.0.camel@maggie>
Mime-Version: 1.0
X-Mailer: Evolution 2.30.3 
Content-Transfer-Encoding: 7bit
Return-Path: <mb@bu3sch.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28552
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mb@bu3sch.de
Precedence: bulk
X-list: linux-mips

On Sat, 2010-11-27 at 19:24 +0000, Ralf Baechle wrote: 
> On Sat, Nov 27, 2010 at 07:11:38PM +0000, Ralf Baechle wrote:
> 
> > On Sat, Nov 27, 2010 at 07:26:32PM +0100, Hauke Mehrtens wrote:
> > > Date:   Sat, 27 Nov 2010 19:26:32 +0100
> > > From: Hauke Mehrtens <hauke@hauke-m.de>
> > > To: ralf@linux-mips.org, linux-mips@linux-mips.org
> > > Cc: mb@bu3sch.de, netdev@vger.kernel.org, Hauke Mehrtens <hauke@hauke-m.de>
> > > Subject: [PATCH RESEND] ssb: fix nvram_get on bcm47xx platform
> > 
> > This has been applied in August, so bitbucket.
> 
> Sorry - there was a different patch of similar subject which I accepted.
> Will feed this one upstream after I seen an ACK from one of the SSB/BCM47xx
> folks.

Acked-by: Michael Buesch <mb@bu3sch.de>

-- 
Greetings Michael.
