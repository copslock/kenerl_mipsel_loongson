Received:  by oss.sgi.com id <S553896AbRAYBJA>;
	Wed, 24 Jan 2001 17:09:00 -0800
Received: from gateway-1237.mvista.com ([12.44.186.158]:15609 "EHLO
        hermes.mvista.com") by oss.sgi.com with ESMTP id <S553890AbRAYBIr>;
	Wed, 24 Jan 2001 17:08:47 -0800
Received: from mvista.com (IDENT:ppopov@zeus.mvista.com [10.0.0.112])
	by hermes.mvista.com (8.11.0/8.11.0) with ESMTP id f0P15gI16997;
	Wed, 24 Jan 2001 17:05:42 -0800
Message-ID: <3A6F7CB8.322668CF@mvista.com>
Date:   Wed, 24 Jan 2001 17:09:12 -0800
From:   Pete Popov <ppopov@mvista.com>
Organization: Monta Vista Software
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.2.17 i586)
X-Accept-Language: bg, en
MIME-Version: 1.0
To:     Ralf Baechle <ralf@oss.sgi.com>
CC:     Jun Sun <jsun@mvista.com>, Quinn Jensen <jensenq@Lineo.COM>,
        linux-mips@oss.sgi.com
Subject: Re: CONFIG_MIPS_UNCACHED
References: <3A6E132B.9000103@Lineo.COM> <3A6E1977.2B18484D@mvista.com> <3A6F36B8.4F10759B@mvista.com> <20010124163101.F863@bacchus.dhis.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

Ralf Baechle wrote:
> 
> On Wed, Jan 24, 2001 at 12:10:32PM -0800, Jun Sun wrote:
> 
> > It is really surprising to know this.  It sounds like a CPU bug to me.  Can
> > some MIPS "gods" clarify if such a behaviour is a bug or allowed?
> >
> > BTW, the CPU in EV96100 is QED RM7000, I believe.
> 
> If you want to be strictly correct you have to execute the code that
> disables caching of KSEG0 in uncached space like KSEG1, then flush the
> caches before you can resume execution in KSEG0.  Otherwise you might
> end up with dirty d-caches which when flushed will overwrite more
> uptodate data in memory.  The window is very small but yet exists if
> things are just right.

The EV96100 running Galileo's pmon exhibits exactly this symptom.  Pmon
apparently sets up kseg0 to cache coherency 3;  but eventhough the
kernel also sets it to 3, if I don't flush the caches first I end up
with overwritten data.  A different version of pmon that I have sets
kseg0 to 1 (writethrough). Changing that to 3 isn't a problem -- or at
least it doesn't seem to cause any problems.

Pete
