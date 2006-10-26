Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 26 Oct 2006 08:42:30 +0100 (BST)
Received: from web37504.mail.mud.yahoo.com ([209.191.91.151]:50867 "HELO
	web37504.mail.mud.yahoo.com") by ftp.linux-mips.org with SMTP
	id S20037742AbWJZHm0 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 26 Oct 2006 08:42:26 +0100
Received: (qmail 68002 invoked by uid 60001); 26 Oct 2006 07:42:16 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=CJaWRtjyAroSvZk4HRQVtqSRC96+UVsuie/zS5QRLY74DmuLyPjukOuUxjEShMHHORB8ssEsgR6GjAvjtZpzlGsq1Rly1pzrpxoPCyPGnH3bg+lX5FLOfVJXyeAlao5R8jHGIbAYX22Xo/Bqi0pqcAtMHVzFAtlmv+l0Bi2BcsE=  ;
Message-ID: <20061026074216.68000.qmail@web37504.mail.mud.yahoo.com>
Received: from [71.146.170.214] by web37504.mail.mud.yahoo.com via HTTP; Thu, 26 Oct 2006 00:42:16 PDT
Date:	Thu, 26 Oct 2006 00:42:16 -0700 (PDT)
From:	Manish Lachwani <m_lachwani@yahoo.com>
Subject: Re: Extreme system overhead on large IP27
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc:	creideiki+linux-mips@ferretporn.se, ralf@linux-mips.org,
	linux-mips@linux-mips.org
In-Reply-To: <20061026.130552.11963152.nemoto@toshiba-tops.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-Path: <m_lachwani@yahoo.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13098
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: m_lachwani@yahoo.com
Precedence: bulk
X-list: linux-mips

Hi Atsushi,

It could be that I am seeing a similar issue on the
SWARM board (sb1250) as well. Your patch removed the
shifts for mip_hpt_frequency from
arch/mips/sibyte/sb1250/time.c and in the
sb1250_hpt_read(). The Sibyte HPT is 1 Mhz. However,
when I added those shifts back, I did not see any
issues with the system clock. I could possibly try out
your patch with lower clocksource shift values and see
if the system clock is still wrong.

Btw, the clocksource changes seem to work well on the
BCM 1480 based board. 

Thanks,
Manish Lachwani


--- Atsushi Nemoto <anemo@mba.ocn.ne.jp> wrote:

> On Wed, 25 Oct 2006 17:45:04 +0900 (JST), Atsushi
> Nemoto <anemo@mba.ocn.ne.jp> wrote:
> > > 2. Timekeeping is broken. The clock in
> /proc/driver/rtc seems correct, but
> > > the system clock advances at about 1/16 of real
> time.
> > 
> > Is this problem still happen if you disabled
> CONFIG_OPROFILE ?
> 
> I think I found the problem at last.
> 
> static struct clocksource clocksource_mips = {
> 	.name		= "MIPS",
> 	.rating		= 250,
> 	.read		= read_mips_hpt,
> 	.shift		= 24,
> 	.is_continuous	= 1,
> };
> 
> This shift value is too large for ip27 HPT
> (1.25MHz).
> 
> 	temp = (u64) NSEC_PER_SEC <<
> clocksource_mips.shift;
> 	do_div(temp, mips_hpt_frequency);
> 	clocksource_mips.mult = (unsigned)temp;
> 
> If mips_hpt_frequency is less than 0x1000000
> (16777216), temp would be
> larger than possible 32bit value.  I'll cook a patch
> later but until
> then you can use lesser shift value, for example,
> 20.
> 
> ---
> Atsushi Nemoto
> 
> 
