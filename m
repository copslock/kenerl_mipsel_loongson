Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 04 Jul 2007 00:03:02 +0100 (BST)
Received: from smtp119.sbc.mail.sp1.yahoo.com ([69.147.64.92]:49788 "HELO
	smtp119.sbc.mail.sp1.yahoo.com") by ftp.linux-mips.org with SMTP
	id S20022489AbXGCXDA (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 4 Jul 2007 00:03:00 +0100
Received: (qmail 73057 invoked from network); 3 Jul 2007 23:02:52 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=pacbell.net;
  h=Received:X-YMail-OSG:From:To:Subject:Date:User-Agent:Cc:References:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-Disposition:Message-Id;
  b=gE57zmHqly+bO4cQynB492vPilAE0qBL9or1gZWMoPWD+gztv2q8+iBf22klgc67eg/75xoE4955XQUtjgrt6OBh6EyG6ZNo8FTSkpPsuWh2M6jb9cw57P0PTyqoQEIP3ohcxN3osm11WH7VUTw7I9xwx63/X1uBsNaLsbcjOZU=  ;
Received: from unknown (HELO ascent) (david-b@pacbell.net@69.226.213.6 with plain)
  by smtp119.sbc.mail.sp1.yahoo.com with SMTP; 3 Jul 2007 23:02:52 -0000
X-YMail-OSG: EUB3pq0VM1ksXNUsdOT4sNN6XaF6wzzoaS4Vh40YYS4.MTHSRuqkiODucJFzSbrDEJvMuwMJVQ--
From:	David Brownell <david-b@pacbell.net>
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Subject: Re: [PATCH] TXx9 SPI controller driver (take 3)
Date:	Tue, 3 Jul 2007 15:18:54 -0700
User-Agent: KMail/1.9.6
Cc:	linux-mips@linux-mips.org, ralf@linux-mips.org,
	sshtylyov@ru.mvista.com, mlachwani@mvista.com,
	spi-devel-general@lists.sourceforge.net
References: <20070702.230210.130241293.anemo@mba.ocn.ne.jp>
In-Reply-To: <20070702.230210.130241293.anemo@mba.ocn.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200707031518.55506.david-b@pacbell.net>
Return-Path: <david-b@pacbell.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15600
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: david-b@pacbell.net
Precedence: bulk
X-list: linux-mips

On Monday 02 July 2007, Atsushi Nemoto wrote:
> This is a driver for SPI controller built into TXx9 MIPS SoCs.
> This driver is derived from arch/mips/tx4938/toshiba_rbtx4938/spi_txx9.c.
> 
> Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>

Thanks.  I fixed a few whitespace bugs (indents *ONLY* tabs etc)
and forwarded it for merging.

- Dave
