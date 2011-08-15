Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 15 Aug 2011 15:13:22 +0200 (CEST)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:36542 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S1491942Ab1HONNS (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 15 Aug 2011 15:13:18 +0200
Received: from duck.linux-mips.net (duck.linux-mips.net [127.0.0.1])
        by duck.linux-mips.net (8.14.4/8.14.4) with ESMTP id p7FDCWCb030124;
        Mon, 15 Aug 2011 14:12:32 +0100
Received: (from ralf@localhost)
        by duck.linux-mips.net (8.14.4/8.14.4/Submit) id p7FDCVso030123;
        Mon, 15 Aug 2011 14:12:31 +0100
Date:   Mon, 15 Aug 2011 14:12:31 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Manuel Lauss <manuel.lauss@googlemail.com>
Cc:     Greg KH <gregkh@suse.de>, Linux-MIPS <linux-mips@linux-mips.org>,
        linux-usb@vger.kernel.org
Subject: Re: [PATCH V2 1/8] MIPS: Alchemy: abstract USB block control
 register access
Message-ID: <20110815131231.GA25911@linux-mips.org>
References: <1313172753-31088-1-git-send-email-manuel.lauss@googlemail.com>
 <20110812184227.GA17057@suse.de>
 <CAOLZvyH3_UuJYUduhb5A+ziPrU+7M9WK8pCAr4P_7-QARYwchw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOLZvyH3_UuJYUduhb5A+ziPrU+7M9WK8pCAr4P_7-QARYwchw@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-archive-position: 30877
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 10814

On Fri, Aug 12, 2011 at 08:48:41PM +0200, Manuel Lauss wrote:

> > Much nicer, thanks.
> >
> > I can take this in the USB tree if the MIPS developers want, or if not,
> > feel free to add:
> >        Acked-by: Greg Kroah-Hartman <gregkh@suse.de>
> > and take it through the MIPS tree.
> 
> Great, thanks.  Other patches to the  MIPS tree depend on this one, so
> I hope Ralf will take it.

Yes, queued for 3.2.  I'm much happier with this one :-)

  Ralf
