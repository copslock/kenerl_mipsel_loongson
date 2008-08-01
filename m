Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 01 Aug 2008 11:49:40 +0100 (BST)
Received: from web25806.mail.ukl.yahoo.com ([217.12.10.191]:58297 "HELO
	web25806.mail.ukl.yahoo.com") by ftp.linux-mips.org with SMTP
	id S20026712AbYHAKtb convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 1 Aug 2008 11:49:31 +0100
Received: (qmail 16644 invoked by uid 60001); 1 Aug 2008 10:49:25 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.co.uk;
  h=Received:X-Mailer:Date:From:Reply-To:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID;
  b=LvYPZ9vNkBOyHeSDmeqxcBH96Jo7Y79Bo/0p6Jpg5ovR3BrO+RSetC7O1+4dLadv7hFgqV5VO0QXqckM8pQRhFscmo13iyufIJqrGQx2EWvKGkdXbZzD81SHHHGL4GH9tDyNQnJGaQXbMmsAByqeiPUleHtzTlWFXQ2cvDjCadU=;
Received: from [83.166.184.142] by web25806.mail.ukl.yahoo.com via HTTP; Fri, 01 Aug 2008 10:49:25 GMT
X-Mailer: YahooMailWebService/0.7.218
Date:	Fri, 1 Aug 2008 10:49:25 +0000 (GMT)
From:	Glyn Astill <glynastill@yahoo.co.uk>
Reply-To: glynastill@yahoo.co.uk
Subject: Re: Debian etch on cobalt
To:	Martin Michlmayr <tbm@cyrius.com>
Cc:	linux-mips@linux-mips.org
In-Reply-To: <20080725234605.GE2512@deprecation.cyrius.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Message-ID: <197761.16530.qm@web25806.mail.ukl.yahoo.com>
Return-Path: <glynastill@yahoo.co.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20072
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: glynastill@yahoo.co.uk
Precedence: bulk
X-list: linux-mips

Hi Chaps,

Just a little update on my progress with this, I would post to the debian mips list, but alas I can't seem to sign up. I tried a whole bunch of things but the problem still persisted using etch. As soon as I went down to sarge/oldstable whings were ok.

Heres what I've tried, and all of this made no change to the problem:

- A fresh etch install, only adding ssh, screen and any packages needed to compile stuff.

- Switched out the ram. The machine is using 3.3v ram, I swapped it for 5v as I had no other spare and it's worked fine before.

- Tried another qube, (just swapped the disks)

- Turned of IDE DMA using hdparm

So hardware wize I've tried averything apart from another hard disk (I don't have one spare unfortunately).

Sarge seems okay, however I'd rather run etch. Is there anything else I can check?

Glyn

--- On Sat, 26/7/08, Martin Michlmayr <tbm@cyrius.com> wrote:

> From: Martin Michlmayr <tbm@cyrius.com>
> Subject: Re: Debian etch on cobalt
> To: "Glyn Astill" <glynastill@yahoo.co.uk>
> Cc: linux-mips@linux-mips.org
> Date: Saturday, 26 July, 2008, 12:46 AM
> * Glyn Astill <glynastill@yahoo.co.uk> [2008-07-25
> 21:45]:
> > I tried subscribing to the debian mipsel ilist with no
> luck.
> 
> There's no debian-mipsel list.  debian-mips is used to
> discuss both
> the mips and mipsel ports.
> 
> > When I start compiling postgres 8.3.3 it crashes
> randomly, if I keep
> > rebooting I can get it compiled, however theres
> something seriously
> > sh*gged here.
> > 
> > Are there known problems?
> 
> It's not a known problem.  Do you have a serial
> console?  Is anything
> printed on it when the machine crashes, or is it a hard
> lockup without
> anything on the console?
> -- 
> Martin Michlmayr
> http://www.cyrius.com/


      __________________________________________________________
Not happy with your email address?.
Get the one you really want - millions of new email addresses available now at Yahoo! http://uk.docs.yahoo.com/ymail/new.html
