Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 10 Dec 2003 10:02:12 +0000 (GMT)
Received: from rwcrmhc12.comcast.net ([IPv6:::ffff:216.148.227.85]:45780 "EHLO
	rwcrmhc12.comcast.net") by linux-mips.org with ESMTP
	id <S8225392AbTLJKCL>; Wed, 10 Dec 2003 10:02:11 +0000
Received: from gentoo.org (pcp04939029pcs.waldrf01.md.comcast.net[68.48.72.58])
          by comcast.net (rwcrmhc12) with SMTP
          id <2003121010020401400f0vj7e>
          (Authid: kumba12345);
          Wed, 10 Dec 2003 10:02:04 +0000
Message-ID: <3FD6EF32.6070808@gentoo.org>
Date: Wed, 10 Dec 2003 05:02:26 -0500
From: Kumba <kumba@gentoo.org>
Reply-To: kumba@gentoo.org
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.5) Gecko/20031007
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-mips@linux-mips.org
Subject: Re: Kernel 2.4.23 on Cobalt Qube2
References: <Pine.GSO.4.21.0312101039270.6357-100000@waterleaf.sonytel.be>
In-Reply-To: <Pine.GSO.4.21.0312101039270.6357-100000@waterleaf.sonytel.be>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <kumba@gentoo.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3732
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kumba@gentoo.org
Precedence: bulk
X-list: linux-mips

Geert Uytterhoeven wrote:

> This `tulip halting', is it `transmit timed out', following by the chip being
> thrown in 10-base2 mode and not recovering until ifconfig down/up?
> 
> I see that one on my PPC box, and I do have a fix. It's not perfect, but the
> box now recovers within 3 minutes, instead of needing manual intervention.
> 
> Gr{oetje,eeting}s,
> 
> 						Geert

To be honest, I'm not sure what's actually occuring.  At first I thought 
it was simply halting, but it does not appear to halt completely.  Data 
will still trickle in *very* slowly.  If ping wouldn't time out after a 
few seconds, I would bet the box would respond after about 3 minutes. 
restarting the config does reset it back.

Now that you mention mode switching, however, May fit in with some data 
I gleaned using mii-diag that I spoke of in #mipslinux awhile back. 
When the tulip driver was working fine, mii-diag reported this:

  MII PHY #1 transceiver registers:
    1000 782d 7810 0003 01e1 45e1 0001 0000
    0000 0000 0000 0000 0000 0000 0000 0000
    0000 0000 4000 0000 3ffb 0010 0000 0002
    0001 0000 0000 0000 0000 0000 0000 0000


Notice the setting of the 21st register (3rd row, 5th value).  When the 
tulip driver started acting up, that value changed to this:

  MII PHY #1 transceiver registers:
    1000 782d 7810 0003 01e1 45e1 0001 0000
    0000 0000 0000 0000 0000 0000 0000 0000
    0000 0000 4000 0000 38c8 0010 0000 0002
    0001 0000 0000 0000 0000 0000 0000 0000


I didn't do very detailed searching for the meaning of the registers, 
and never found out what the 21st register's specific purpose was, but 
is this the mode switching you're mentioning perhaps?

If so, I'll give your patch a run, see if it works and if the recovery 
time can be shortened, or help to isolate the problem so it can be nailed.


--Kumba

-- 
"Such is oft the course of deeds that move the wheels of the world: 
small hands do them because they must, while the eyes of the great are 
elsewhere."  --Elrond
