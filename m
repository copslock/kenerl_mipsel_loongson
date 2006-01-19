Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 19 Jan 2006 08:40:27 +0000 (GMT)
Received: from mail.gmx.de ([213.165.64.21]:28306 "HELO mail.gmx.net")
	by ftp.linux-mips.org with SMTP id S8133648AbWASIkG (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 19 Jan 2006 08:40:06 +0000
Received: (qmail 14840 invoked by uid 0); 19 Jan 2006 08:43:49 -0000
Received: from 62.58.165.83 by www33.gmx.net with HTTP;
	Thu, 19 Jan 2006 09:43:49 +0100 (MET)
Date:	Thu, 19 Jan 2006 09:43:49 +0100 (MET)
From:	"freshy98" <freshy98@gmx.net>
To:	linux-mips@linux-mips.org
MIME-Version: 1.0
References: <43CF4526.2090104@bitbox.co.uk>
Subject: Re: Cobalt Raq2 HD upgrade - Advice required
X-Priority: 3 (Normal)
X-Authenticated: #11016536
Message-ID: <18948.1137660229@www33.gmx.net>
X-Mailer: WWW-Mail 1.6 (Global Message Exchange)
X-Flags: 0001
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Return-Path: <freshy98@gmx.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9975
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: freshy98@gmx.net
Precedence: bulk
X-list: linux-mips

> --- Urspr¸ngliche Nachricht ---
> Von: Peter Horton <phorton@bitbox.co.uk>
> An: freshy98 <freshy98@gmx.net>
> Kopie: linux-mips@linux-mips.org
> Betreff: Re: Cobalt Raq2 HD upgrade - Advice required
> Datum: Thu, 19 Jan 2006 07:52:06 +0000
> 
> freshy98 wrote:
> > Dominique Quatravaux wrote:
> > 
> >>
> >> I'd like to beef up the machine, with more RAM and another HD for
> >> backups. I found the appropriate Wiki page
> >> (http://www.linux-mips.org/wiki/Cobalt) and I believe I can deal with
> >> the RAM part. OTOH as regards the hard drive, the page is a bit
> evasive:
> >> exactly what kind of HD can I put there (one for a laptop perhaps)?
> Will
> >> I need any duct tape to fasten the second disk? Is there anything
> >> special I should know about the operation?
> >>
> > 
> > All you need is a new IDE cable since the default one only has the 
> > Master connector and you need the Slave as well.
> > Apart from that it should be easy.
> > Oh, you also need a Molex splitter since the default one is only good 
> > for one drive.
> > 
> 
> If you have some soldering experience it's also quite easy to fit the 
> components for the second IDE channel (it's just a handful of resistors, 
> a diode and the connector IIRC).
> 
> P.
> 

I've never bothered going that far, but it indeed should be quite easy.
Might also gain some speed as both drives don't need to go over the same
controler/cable?
The speed ain't too good as it is I think.

Tom

-- 
DSL-Aktion wegen groﬂer Nachfrage bis 28.2.2006 verl‰ngert:
GMX DSL-Flatrate 1 Jahr kostenlos* http://www.gmx.net/de/go/dsl
