Received:  by oss.sgi.com id <S553795AbQLXLdJ>;
	Sun, 24 Dec 2000 03:33:09 -0800
Received: from mail.sonytel.be ([193.74.243.200]:5255 "EHLO mail.sonytel.be")
	by oss.sgi.com with ESMTP id <S553790AbQLXLdA>;
	Sun, 24 Dec 2000 03:33:00 -0800
Received: from rose.sonytel.be (rose.sonytel.be [193.74.243.35])
	by mail.sonytel.be (8.9.0/8.8.6) with ESMTP id MAA22604;
	Sun, 24 Dec 2000 12:32:44 +0100 (MET)
Date:   Sun, 24 Dec 2000 12:32:43 +0100 (MET)
From:   Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
To:     Jan-Benedict Glaw <jbglaw@lug-owl.de>
cc:     linux-mips@oss.sgi.com
Subject: Re: External SCSI connector on DECstations
In-Reply-To: <20001224122539.B25473@lug-owl.de>
Message-ID: <Pine.GSO.4.10.10012241231280.21709-100000@rose.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Sun, 24 Dec 2000, Jan-Benedict Glaw wrote:
> I've got some trouble attaching devices to DECstation's external
> SCSI connector. Is there any additional jumper (or sth like
> that) on the mobo I need to remove in order to not automatically
> terminate the bus (inside the DS) before the connector?
> 
> ...or do I do something completely wrong?

Is this an high-density 68-pin connector, like used for UW-SCSI?
If yes, be careful! Many DECstations use these connectors, but are in fact
narrow SCSI! So you need the correct (DEC) cable.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven ------------- Sony Software Development Center Europe (SDCE)
Geert.Uytterhoeven@sonycom.com ------------------- Sint-Stevens-Woluwestraat 55
Voice +32-2-7248626 Fax +32-2-7262686 ---------------- B-1130 Brussels, Belgium
