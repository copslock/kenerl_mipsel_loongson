Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 27 Jun 2003 18:35:13 +0100 (BST)
Received: from mx2.idealab.com ([IPv6:::ffff:64.208.8.4]:990 "EHLO
	butch.idealab.com") by linux-mips.org with ESMTP
	id <S8225311AbTF0RfJ>; Fri, 27 Jun 2003 18:35:09 +0100
Received: (qmail 46154 invoked by uid 72); 27 Jun 2003 17:35:01 -0000
Received: from joseph@omnilux.net by butch.idealab.com with qmail-scanner-1.03 (sweep: 2.6/3.49. . Clean. Processed in 3.265369 secs); 27 Jun 2003 17:35:01 -0000
X-Qmail-Scanner-Mail-From: joseph@omnilux.net via butch.idealab.com
X-Qmail-Scanner: 1.03 (Clean. Processed in 3.265369 secs)
Received: from unknown (HELO c002079) (10.1.2.63)
  by 0 with SMTP; 27 Jun 2003 17:34:57 -0000
From: "Joseph Chiu" <joseph@omnilux.net>
To: "Steven J. Hill" <sjhill@realitydiluted.com>
Cc: "Ralf Baechle" <ralf@linux-mips.org>,
	"Pete Popov" <ppopov@mvista.com>,
	"Linux MIPS mailing list" <linux-mips@linux-mips.org>
Subject: RE: wired tlb entry?
Date: Fri, 27 Jun 2003 10:38:36 -0700
Message-ID: <BPEELMGAINDCONKDGDNCIEOHDMAA.joseph@omnilux.net>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4807.1700
In-Reply-To: <3EFB9796.5070701@realitydiluted.com>
Return-Path: <joseph@omnilux.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2709
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: joseph@omnilux.net
Precedence: bulk
X-list: linux-mips

This is on our own board.  We're developing a optical wireless transceiver
system (see www.omnilux.net) and we use the Au1000 as the central
controller.

It's a pretty simple board -- the au1000 static bus interfaces connects to
FLASH, and two external peripheral devices; one of them being a PCMCIA card.
(We put the card directly on the bus -- no "end user proofing" buffers or
any such things).

The non-PCMCIA peripheral sits within the directly accessible low memory
range.  In fact, outside of user pages, the only thing that needs TLB is the
small windows pointing to the PCMCIA card.

Joseph
-----Original Message-----
From: Steven J. Hill [mailto:sjhill@realitydiluted.com]
Sent: Thursday, June 26, 2003 6:02 PM
To: Joseph Chiu
Cc: Ralf Baechle; Pete Popov; Linux MIPS mailing list
Subject: Re: wired tlb entry?


Joseph Chiu wrote:
>
> Thanks Ralf.  It is "just one" wired global TLB entry (admiteddly, out of
a
> paltry 32).   Using the wired entry has fixed the immediate problem at
hand,
> so I decided it's worth it for now.
>
If you can, which board is this on?

-Steve
