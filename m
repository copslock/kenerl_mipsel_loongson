Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 14 Dec 2010 19:50:44 +0100 (CET)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:53160 "EHLO h5.dl5rb.org.uk"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1491036Ab0LNSud (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 14 Dec 2010 19:50:33 +0100
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
        by h5.dl5rb.org.uk (8.14.4/8.14.3) with ESMTP id oBEIoWnl011389;
        Tue, 14 Dec 2010 18:50:32 GMT
Received: (from ralf@localhost)
        by h5.dl5rb.org.uk (8.14.4/8.14.4/Submit) id oBEIoV85011376;
        Tue, 14 Dec 2010 18:50:31 GMT
Date:   Tue, 14 Dec 2010 18:50:30 +0000
From:   Ralf Baechle <ralf@linux-mips.org>
To:     "Kevin D. Kissell" <kevink@paralogos.com>
Cc:     "Anoop P.A." <Anoop_P.A@pmc-sierra.com>, linux-mips@linux-mips.org
Subject: Re: SMTC support status in latest git head.
Message-ID: <20101214185030.GA9930@linux-mips.org>
References: <A7DEA48C84FD0B48AAAE33F328C02014033DADDA@BBY1EXM11.pmc_nt.nt.pmc-sierra.bc.ca>
 <4D012560.6020003@paralogos.com>
 <A7DEA48C84FD0B48AAAE33F328C020140595CEB0@BBY1EXM11.pmc_nt.nt.pmc-sierra.bc.ca>
 <4D07B859.2020805@paralogos.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4D07B859.2020805@paralogos.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28642
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Dec 14, 2010 at 10:32:57AM -0800, Kevin D. Kissell wrote:

> I am no longer associated with MIPS Technologies and no longer have
> access to my email archives from that period.  If I did, I could tell you
> which LMO kernel version(s) had SMTC working "out of the box".  There
> definitely was at least one, and I commented on it in an email.  You
> might be able to find it in the LMO email archives, but it's possible that
> I only sent it to a MIPS internal mailing list.
> 
> There was also a message I wrote that I had *thought* had gone to
> the LMO mailing list, but may have only been sent to a group of internal
> MIPS and customer engineers, in which I described the recommended
> procedure for debugging exactly this canonical problem with porting
> SMTC.

git bisect to the rescue :)  It's time consuming with a slow machine but
perfectly doable.  Go back, find some antique kernel version with
functioning SMTC and take it from there.

  Ralf
