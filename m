Received:  by oss.sgi.com id <S42264AbQG0X7v>;
	Thu, 27 Jul 2000 16:59:51 -0700
Received: from u-151.karlsruhe.ipdial.viaginterkom.de ([62.180.19.151]:49924
        "EHLO u-151.karlsruhe.ipdial.viaginterkom.de") by oss.sgi.com
	with ESMTP id <S42222AbQG0X7m>; Thu, 27 Jul 2000 16:59:42 -0700
Received: (ralf@lappi) by lappi.waldorf-gmbh.de id <S868882AbQG0X7a>;
        Fri, 28 Jul 2000 01:59:30 +0200
Date:   Fri, 28 Jul 2000 01:59:30 +0200
From:   Ralf Baechle <ralf@oss.sgi.com>
To:     Keith M Wesolowski <wesolows@foobazco.org>
Cc:     linux-mips@oss.sgi.com
Subject: Re: sgi prom console
Message-ID: <20000728015930.A1328@bacchus.dhis.org>
References: <20000726215416.A18398@foobazco.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <20000726215416.A18398@foobazco.org>; from wesolows@foobazco.org on Wed, Jul 26, 2000 at 09:54:16PM -0700
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Wed, Jul 26, 2000 at 09:54:16PM -0700, Keith M Wesolowski wrote:

> This patch gets the sgi prom console outputting again, and eliminates
> the "cannot open initial console" error. Unfortunately, all output
> from userland goes to the serial port, not the the prom console.
> Looking at the code, this isn't at all surprising; the prom console
> pretends to be 4,64, ttyS0. It's quite beyond me how the prom console
> could ever have worked for userland.

Ok, patch applied.

  Ralf
