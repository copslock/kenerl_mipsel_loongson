Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fACCVhd18806
	for linux-mips-outgoing; Mon, 12 Nov 2001 04:31:43 -0800
Received: from dea.linux-mips.net (localhost [127.0.0.1])
	by oss.sgi.com (8.11.2/8.11.3) with ESMTP id fACCVf018803
	for <linux-mips@oss.sgi.com>; Mon, 12 Nov 2001 04:31:41 -0800
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.1/8.11.1) id fACCUV409976;
	Mon, 12 Nov 2001 23:30:31 +1100
Date: Mon, 12 Nov 2001 23:30:31 +1100
From: Ralf Baechle <ralf@oss.sgi.com>
To: Han-Seong Kim <khs@digital-digital.com>
Cc: linux-mips@fnet.fr, linux-mips@oss.sgi.com
Subject: Re: Power MGMT on mips
Message-ID: <20011112233031.A6493@dea.linux-mips.net>
References: <000001c16b51$f05f6070$cbadfea9@khs>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <000001c16b51$f05f6070$cbadfea9@khs>; from khs@digital-digital.com on Mon, Nov 12, 2001 at 05:13:40PM +0900
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Mon, Nov 12, 2001 at 05:13:40PM +0900, Han-Seong Kim wrote:

> I want to ask about Power-Mnagement on mips.
> 1. Is it possible to use power mgnt (ex. apm,acpi) features of linux kernel?

Both are PC stuff, so no.

> 2.If no, how can manage CPU and Bidge chips for power mgnt ?

Right now Linux/MIPS will only use the CPU's power managment features, that
is the wait instruction or similar.

  Ralf
