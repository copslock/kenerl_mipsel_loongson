Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 12 Sep 2013 14:13:57 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:36118 "EHLO
        localhost.localdomain" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6817329Ab3ILMNyCCkQB (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 12 Sep 2013 14:13:54 +0200
Date:   Thu, 12 Sep 2013 13:13:53 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@linux-mips.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
cc:     Ralf Baechle <ralf@linux-mips.org>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>
Subject: Re: [PATCH] MIPS: DECstation HRT calibration bug fixes
In-Reply-To: <CAMuHMdWdc1ncuh4vcLFPmZPj1bdK6ma_Zu9RTJrbMk2ysPuEug@mail.gmail.com>
Message-ID: <alpine.LFD.2.03.1309121312500.24771@linux-mips.org>
References: <alpine.LFD.2.03.1309041410160.11570@linux-mips.org>        <20130905180825.GB11592@linux-mips.org>        <alpine.LFD.2.03.1309052118560.11570@linux-mips.org>        <20130907073450.GE11592@linux-mips.org>        <alpine.LFD.2.03.1309071304090.19552@linux-mips.org>
 <CAMuHMdWdc1ncuh4vcLFPmZPj1bdK6ma_Zu9RTJrbMk2ysPuEug@mail.gmail.com>
User-Agent: Alpine 2.03 (LFD 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37802
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

On Sat, 7 Sep 2013, Geert Uytterhoeven wrote:

> >  BTW, is it normal these days that /proc entries like /proc/iomem,
> > /proc/net or /proc/sys are omitted from the /proc directory listing?  They
> > can still be opened if you know the name.  I've been wondering if it's
> > been a change made sometime or an odd effect of a possible compiler bug.
> 
> That's a regression introduced in early v3.11-rcX, and fixed in v3.11-rc7.

 Good to know (-rc2 used here, will update sometime), thanks!

  Maciej
