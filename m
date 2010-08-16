Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 16 Aug 2010 22:42:25 +0200 (CEST)
Received: from mail-pw0-f49.google.com ([209.85.160.49]:48977 "EHLO
        mail-pw0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491142Ab0HPUmW (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 16 Aug 2010 22:42:22 +0200
Received: by pwi9 with SMTP id 9so2339275pwi.36
        for <multiple recipients>; Mon, 16 Aug 2010 13:42:15 -0700 (PDT)
Received: by 10.142.163.19 with SMTP id l19mr4940399wfe.106.1281991334916;
        Mon, 16 Aug 2010 13:42:14 -0700 (PDT)
Received: from angua (S01060002b3d79728.cg.shawcable.net [70.72.87.49])
        by mx.google.com with ESMTPS id z1sm8741705wfd.15.2010.08.16.13.42.13
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 16 Aug 2010 13:42:13 -0700 (PDT)
Received: by angua (Postfix, from userid 1000)
        id 0FE683C014C; Mon, 16 Aug 2010 14:42:12 -0600 (MDT)
Date:   Mon, 16 Aug 2010 14:42:11 -0600
From:   Grant Likely <grant.likely@secretlab.ca>
To:     "Dezhong Diao (dediao)" <dediao@cisco.com>
Cc:     David Daney <ddaney@caviumnetworks.com>,
        devicetree-discuss@lists.ozlabs.org, linux-mips@linux-mips.org,
        ralf@linux-mips.org,
        "David VomLehn (dvomlehn)" <dvomlehn@cisco.com>
Subject: Re: [PATCH v2 1/2] MIPS: Add device tree support to MIPS
Message-ID: <20100816204211.GA17571@angua.secretlab.ca>
References: <AANLkTi=74zoQziQTmAGo-cNtF9FAT77h+KZagsNEFjEf@mail.gmail.com>
 <7A9214B0DEB2074FBCA688B30B04400D013FA46D@XMB-RCD-208.cisco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7A9214B0DEB2074FBCA688B30B04400D013FA46D@XMB-RCD-208.cisco.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Return-Path: <glikely@secretlab.ca>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 27620
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: grant.likely@secretlab.ca
Precedence: bulk
X-list: linux-mips

On Wed, Jul 28, 2010 at 03:47:20PM -0500, Dezhong Diao (dediao) wrote:
> Grant,
> 
> I agree with your approach. Please go ahead to make changes and get the patches working with latest code in test tree. Or I am able to make changes in terms of your comments too.
> 
> It is best we can have MIPS OF support in 2.6.36, but I have you and Ralf decide it.

Wasn't quite ready in time for 2.6.36, but .37 should be no problem.  All of the pending devicetree core patches are now in Linus' tree, so it is a good time to rebase.  When you repost I can pick them up into my tree to get some build test exposure.

I'll also make sure to start build testing on MIPS.  Ralf, any suggestions on defconfigs I should use?

Cheers,
g.


> 
> 
> Thanks.
> 
> 
> Dezhong  
> 
> -----Original Message-----
> From: glikely@secretlab.ca [mailto:glikely@secretlab.ca] On Behalf Of Grant Likely
> Sent: Wednesday, July 28, 2010 12:26 PM
> To: David Daney
> Cc: Dezhong Diao (dediao); devicetree-discuss@lists.ozlabs.org; linux-mips@linux-mips.org; ralf@linux-mips.org; David VomLehn (dvomlehn)
> Subject: Re: [PATCH v2 1/2] MIPS: Add device tree support to MIPS
> 
> On Wed, Jul 28, 2010 at 1:19 PM, David Daney <ddaney@caviumnetworks.com> wrote:
> > On 07/28/2010 11:54 AM, Grant Likely wrote:
> >>
> >> Hi Dezhong,
> >
> > [...]
> >>
> >> Very nice clean patch, thanks!  How/when would you like to see MIPS 
> >> OF support go into mainline?
> >>
> >
> > I can't speak for the patch authors, but my preference would be to 
> > have MIPS OF support go in to 2.6.36 if possible.
> >
> > How? To me it doesn't matter.  I would let you and Ralf fight it out.
> 
> It would probably be best if I at least pick up the first patch into my test tree to give it a spin with the latest changes.  I'd be happy to take the 2nd too to avoid ordering issues.
> 
> Cheers,
> g.
