Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fAE9vBR12117
	for linux-mips-outgoing; Wed, 14 Nov 2001 01:57:11 -0800
Received: from faui02.informatik.uni-erlangen.de (root@faui02.informatik.uni-erlangen.de [131.188.30.102])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id fAE9v8012114
	for <linux-mips@oss.sgi.com>; Wed, 14 Nov 2001 01:57:08 -0800
Received: from rz.de (root@faui02b.informatik.uni-erlangen.de [131.188.30.151])
	by faui02.informatik.uni-erlangen.de (8.9.1/8.1.16-FAU) with ESMTP id KAA02730; Wed, 14 Nov 2001 10:56:51 +0100 (MET)
Received: (from rz@localhost)
	by rz.de (8.8.8/8.8.8) id KAA00191;
	Wed, 14 Nov 2001 10:46:56 +0100
Date: Wed, 14 Nov 2001 10:46:55 +0100
From: Richard Zidlicky <rz@linux-m68k.org>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Jun Sun <jsun@mvista.com>,
   "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>,
   Linux/MIPS Development <linux-mips@oss.sgi.com>,
   Linux/m68k <linux-m68k@lists.linux-m68k.org>,
   Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>
Subject: Re: [RFC] generic MIPS RTC driver
Message-ID: <20011114104655.A187@linux-m68k.org>
References: <20011113144240.B669@linux-m68k.org> <Pine.LNX.4.33.0111131630310.3818-100000@serv>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.33.0111131630310.3818-100000@serv>; from zippel@linux-m68k.org on Tue, Nov 13, 2001 at 04:32:42PM +0100
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Tue, Nov 13, 2001 at 04:32:42PM +0100, Roman Zippel wrote:
> Hi,
> 
> On Tue, 13 Nov 2001, Richard Zidlicky wrote:
> 
> > hwclock and a bunch of less known porgrams like chrony.
> 
> I was playing with chrony, but it was unable to adjust the time, last
> weekend I switched back to ntp and that works better.

some years ago chrony was the reason I wrote the Q40 rtc driver.
It didn't work very well for me either, but the rtc driver was
very useful in the meantime :)

Bye
Richard
