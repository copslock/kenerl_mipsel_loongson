Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 25 Jun 2003 19:02:32 +0100 (BST)
Received: from mx2.idealab.com ([IPv6:::ffff:64.208.8.4]:22453 "EHLO
	butch.idealab.com") by linux-mips.org with ESMTP
	id <S8225244AbTFYSC2>; Wed, 25 Jun 2003 19:02:28 +0100
Received: (qmail 65338 invoked by uid 72); 25 Jun 2003 18:02:15 -0000
Received: from joseph@omnilux.net by butch.idealab.com with qmail-scanner-1.03 (sweep: 2.6/3.49. . Clean. Processed in 1.904417 secs); 25 Jun 2003 18:02:15 -0000
X-Qmail-Scanner-Mail-From: joseph@omnilux.net via butch.idealab.com
X-Qmail-Scanner: 1.03 (Clean. Processed in 1.904417 secs)
Received: from unknown (HELO c002079) (10.1.2.63)
  by 0 with SMTP; 25 Jun 2003 18:02:13 -0000
From: "Joseph Chiu" <joseph@omnilux.net>
To: "Ralf Baechle" <ralf@linux-mips.org>
Cc: "Pete Popov" <ppopov@mvista.com>,
	"Linux MIPS mailing list" <linux-mips@linux-mips.org>
Subject: RE: wired tlb entry?
Date: Wed, 25 Jun 2003 11:05:49 -0700
Message-ID: <BPEELMGAINDCONKDGDNCIEMGDMAA.joseph@omnilux.net>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4807.1700
In-Reply-To: <20030625045916.GA28556@linux-mips.org>
Return-Path: <joseph@omnilux.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2704
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: joseph@omnilux.net
Precedence: bulk
X-list: linux-mips

On Tuesday, June 24, 2003 9:59 PM Ralf Baechle wrote:

> Usual warning - wired entries are almost always a bad idea.  TLB entries
> are a scarce resource and wiring will reduce the number available for
> random replacement even further raising the amount of CPU burned in the
> TLB reload handler.

Thanks Ralf.  It is "just one" wired global TLB entry (admiteddly, out of a
paltry 32).   Using the wired entry has fixed the immediate problem at hand,
so I decided it's worth it for now.

Joseph
