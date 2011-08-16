Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 16 Aug 2011 12:07:01 +0200 (CEST)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:54973 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S1491988Ab1HPKGv (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 16 Aug 2011 12:06:51 +0200
Received: from duck.linux-mips.net (duck.linux-mips.net [127.0.0.1])
        by duck.linux-mips.net (8.14.4/8.14.4) with ESMTP id p7GA5lWq012726;
        Tue, 16 Aug 2011 11:05:48 +0100
Received: (from ralf@localhost)
        by duck.linux-mips.net (8.14.4/8.14.4/Submit) id p7GA5jcc012724;
        Tue, 16 Aug 2011 11:05:45 +0100
Date:   Tue, 16 Aug 2011 11:05:45 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     "Jayachandran C." <jayachandranc@netlogicmicro.com>
Cc:     Arnaud Lacombe <lacombar@gmail.com>,
        Sergei Shtylyov <sshtylyov@mvista.com>,
        linux-kernel@vger.kernel.org, Sam Ravnborg <sam@ravnborg.org>,
        linux-mips@linux-mips.org
Subject: Re: [PATCH 02/11] arch/mips: do not use EXTRA_CFLAGS
Message-ID: <20110816100544.GA12658@linux-mips.org>
References: <1313384834-24433-1-git-send-email-lacombar@gmail.com>
 <1313384834-24433-3-git-send-email-lacombar@gmail.com>
 <4E48EAA0.5020901@mvista.com>
 <20110815135515.GA1441@linux-mips.org>
 <CACqU3MVyg_hA1m+1sJZ+aTHdxvzxviVXr0Fvom7p9EEHXVOMtA@mail.gmail.com>
 <CA+7sy7DEBgcUYCf895yf8cKMS=iDgz-n9Nh7R8_EO_O-QX3MfA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+7sy7DEBgcUYCf895yf8cKMS=iDgz-n9Nh7R8_EO_O-QX3MfA@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-archive-position: 30885
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 11596

On Mon, Aug 15, 2011 at 10:58:27PM +0530, Jayachandran C. wrote:

> On Mon, Aug 15, 2011 at 9:49 PM, Arnaud Lacombe <lacombar@gmail.com> wrote:
> > Hi,
> >
> > On Mon, Aug 15, 2011 at 9:55 AM, Ralf Baechle <ralf@linux-mips.org> wrote:
> >> On Mon, Aug 15, 2011 at 01:45:04PM +0400, Sergei Shtylyov wrote:
> >>
> >>>    You didn't sign off.
> >>
> >> True - but I won't make a big fuzz about that for a one-line.  I'm sure
> >> Arnaud will vow to do right the next time :-)
> >>
> > You are welcome to slap me. If it's not too late:
> >
> > Signed-off-by: Arnaud Lacombe <lacombar@gmail.com>
> 
> Thanks for fixing this up.   Looks like an acked-by is not needed :)

No - but generally an Acked-by: a maintainer or Reviewed-by: or Tested-by:
somebody else is always welcome.  The more eyeballs, the better :-)

  Ralf
