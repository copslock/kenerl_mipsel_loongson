Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g0F0NxR27318
	for linux-mips-outgoing; Mon, 14 Jan 2002 16:23:59 -0800
Received: from dea.linux-mips.net (localhost [127.0.0.1])
	by oss.sgi.com (8.11.2/8.11.3) with ESMTP id g0F0Nwg27315
	for <linux-mips@oss.sgi.com>; Mon, 14 Jan 2002 16:23:58 -0800
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.1/8.11.1) id g0ENNtm29454;
	Mon, 14 Jan 2002 15:23:55 -0800
Date: Mon, 14 Jan 2002 15:23:55 -0800
From: Ralf Baechle <ralf@oss.sgi.com>
To: "Kevin D. Kissell" <kevink@mips.com>
Cc: Dominic Sweetman <dom@algor.co.uk>, Matthew Dharm <mdharm@momenco.com>,
   linux-mips@oss.sgi.com
Subject: Re: MIPS64 status?
Message-ID: <20020114152355.E29242@dea.linux-mips.net>
References: <20020113211323.A7115@momenco.com> <15426.48692.795968.819750@gladsmuir.algor.co.uk> <00ee01c19cfa$ab8d3640$0deca8c0@Ulysses>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <00ee01c19cfa$ab8d3640$0deca8c0@Ulysses>; from kevink@mips.com on Mon, Jan 14, 2002 at 01:54:42PM +0100
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Mon, Jan 14, 2002 at 01:54:42PM +0100, Kevin D. Kissell wrote:

> The official MIPS64[tm] architecture spec from MIPS 
> Technologies also provides a bit (Status.PX) which enables
> the 64-bit data path without affecting address generation
> and translation, which removes this quirk.  Only the very
> most recent 64-bit cores and CPUs implement it, however.

And Linux doesn't use PX at all.

  Ralf
