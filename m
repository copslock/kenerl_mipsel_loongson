Received:  by oss.sgi.com id <S42255AbQJKWnW>;
	Wed, 11 Oct 2000 15:43:22 -0700
Received: from u-252.karlsruhe.ipdial.viaginterkom.de ([62.180.18.252]:6663
        "EHLO u-252.karlsruhe.ipdial.viaginterkom.de") by oss.sgi.com
	with ESMTP id <S42252AbQJKWnH>; Wed, 11 Oct 2000 15:43:07 -0700
Received: (ralf@lappi) by lappi.waldorf-gmbh.de id <S870105AbQJKPfg>;
        Wed, 11 Oct 2000 17:35:36 +0200
Date:   Wed, 11 Oct 2000 17:35:36 +0200
From:   Ralf Baechle <ralf@oss.sgi.com>
To:     linux-mips@oss.sgi.com
Subject: Re: Problem w/ serial console after power-on
Message-ID: <20001011173536.A19367@bacchus.dhis.org>
References: <20001011013803.A5873@lug-owl.de> <20001011074850.A999@excalibur.cologne.de> <20001011091831.A11757@lug-owl.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <20001011091831.A11757@lug-owl.de>; from jbglaw@lug-owl.de on Wed, Oct 11, 2000 at 09:18:32AM +0200
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Wed, Oct 11, 2000 at 09:18:32AM +0200, Jan-Benedict Glaw wrote:

> [Nonfunctional null modem cable]
> 
> > Well known effect :-)
> > I have a "normal" 7-wire-nullmodem cable that works fine when connecting
> 
> Yes, that's true...
> 
> > The soloution: use a 3-wire-nullmodem cable and inside each of the
> > connectors connect RTS-CTS and DTR-DSR-DCD.
> 
> Oh, where's my foot? ...want to shoot it;)

No probleem with knocking out hardware handshaking of the serial console
like that.  You can't do rts-cts or you risk hard to track temporary
freezes of the machine.  It's been what has caused the freezes of
oss.sgi.com some time ago ...

  Ralf
