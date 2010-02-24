Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 24 Feb 2010 12:39:52 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:48371 "EHLO h5.dl5rb.org.uk"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S1492220Ab0BXLjt (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 24 Feb 2010 12:39:49 +0100
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
        by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id o1OBdjWO014475;
        Wed, 24 Feb 2010 12:39:46 +0100
Received: (from ralf@localhost)
        by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id o1OBdiTJ014473;
        Wed, 24 Feb 2010 12:39:45 +0100
Date:   Wed, 24 Feb 2010 12:39:44 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Manuel Lauss <manuel.lauss@googlemail.com>
Cc:     Linux-MIPS <linux-mips@linux-mips.org>,
        Manuel Lauss <manuel.lauss@gmail.com>
Subject: Re: [PATCH -queue v2] MIPS: Alchemy: use 36bit addresses for PCMCIA
 resources.
Message-ID: <20100224113943.GA14446@linux-mips.org>
References: <1266956534-24753-1-git-send-email-manuel.lauss@gmail.com>
 <20100223230618.GD21949@linux-mips.org>
 <f861ec6f1002232357l112e2396qd063fd1c1bbdb46@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f861ec6f1002232357l112e2396qd063fd1c1bbdb46@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-08-17)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26017
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Feb 24, 2010 at 08:57:27AM +0100, Manuel Lauss wrote:

> On Wed, Feb 24, 2010 at 12:06 AM, Ralf Baechle <ralf@linux-mips.org> wrote:
> > On Tue, Feb 23, 2010 at 09:22:14PM +0100, Manuel Lauss wrote:
> >
> >> On Alchemy the PCMCIA area lies at the end of the chips 36bit system
> >> bus area.  Currently, addresses at the far end of the 32bit area
> >> are assumed to belong to the PCMCIA area and fixed up to the real
> >> 36bit address before being passed to ioremap().
> >>
> >> A previous commit enabled 64 bit physical size for the resource
> >> datatype on Alchemy and this allows to use the correct
> >> 36bit addresses when registering the PCMCIA sockets.
> >>
> >> This patch removes the 32-to-36bit address fixup and registers the
> >> Alchemy demoboard pcmcia socket with the correct 36bit physical
> >> addresses.
> >>
> >> Tested on DB1200, with a CF card (ide-cs driver) and a 3c589 pcmcia
> >> ethernet card.
> >>
> >> Signed-off-by: Manuel Lauss <manuel.lauss@gmail.com>
> >
> > Thanks, queued for 2.6.34.
> 
> Please drop this one for now, I forgot to change the XXS1500 board
> and driver code.  I'll resend an updated version.

Done.

  Ralf
