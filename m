Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f7GBGHL24427
	for linux-mips-outgoing; Thu, 16 Aug 2001 04:16:17 -0700
Received: from dea.waldorf-gmbh.de (u-116-18.karlsruhe.ipdial.viaginterkom.de [62.180.18.116])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f7GBGFj24424
	for <linux-mips@oss.sgi.com>; Thu, 16 Aug 2001 04:16:15 -0700
Received: (from ralf@localhost)
	by dea.waldorf-gmbh.de (8.11.1/8.11.1) id f7GBEMT20654;
	Thu, 16 Aug 2001 13:14:22 +0200
Date: Thu, 16 Aug 2001 13:14:22 +0200
From: Ralf Baechle <ralf@oss.sgi.com>
To: Carsten Langgaard <carstenl@mips.com>
Cc: Atsushi Nemoto <nemoto@toshiba-tops.co.jp>, wgowcher@yahoo.com,
   linux-mips@oss.sgi.com
Subject: Re: Benchmark performance
Message-ID: <20010816131422.B17970@bacchus.dhis.org>
References: <20010809215522.A1958@lucon.org> <20010813173446.61234.qmail@web11901.mail.yahoo.com> <20010816125652N.nemoto@toshiba-tops.co.jp> <20010816111803.A17469@bacchus.dhis.org> <3B7BA970.56192BB8@mips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3B7BA970.56192BB8@mips.com>; from carstenl@mips.com on Thu, Aug 16, 2001 at 01:07:28PM +0200
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Thu, Aug 16, 2001 at 01:07:28PM +0200, Carsten Langgaard wrote:

> What is probably needed too, but I still think we need the check for real
> FPU, so we only emulate one instruction at a time, if we got a real FPU.

I'm just about to put it into CVS.

  Ralf
