Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fATG2nM18697
	for linux-mips-outgoing; Thu, 29 Nov 2001 08:02:49 -0800
Received: from dea.linux-mips.net (localhost [127.0.0.1])
	by oss.sgi.com (8.11.2/8.11.3) with ESMTP id fATG2jo18693
	for <linux-mips@oss.sgi.com>; Thu, 29 Nov 2001 08:02:46 -0800
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.1/8.11.1) id fATF2eL08386;
	Fri, 30 Nov 2001 02:02:40 +1100
Date: Fri, 30 Nov 2001 02:02:40 +1100
From: Ralf Baechle <ralf@oss.sgi.com>
To: Jun Sun <jsun@mvista.com>
Cc: linux-mips@oss.sgi.com
Subject: Re: calibrating MIPS counter frequency
Message-ID: <20011130020240.F638@dea.linux-mips.net>
References: <3C05646B.51BF79FB@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3C05646B.51BF79FB@mvista.com>; from jsun@mvista.com on Wed, Nov 28, 2001 at 02:25:47PM -0800
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Wed, Nov 28, 2001 at 02:25:47PM -0800, Jun Sun wrote:

> In the future, I think mips counter frequency really should go to mips_cpu
> structure.  If we always know the counter frequency, either by board setup
> routine or runtime calibration, we can get rid of the gettimeoffset
> calibration routines.

Better stick with the calibration procedure.  The crystal oscilators used
in most computer systems don't provide the high accuracy of frequency
that is required to keep the clock accurately over long time.  An RTC
chip which you'd probably use as reference clock is better at that so
should be used as the ultimate reference time in the kernel.

  Ralf
