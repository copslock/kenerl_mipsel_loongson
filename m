Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 10 Feb 2013 17:43:47 +0100 (CET)
Received: from keetweej.vanheusden.com ([80.101.105.103]:55531 "EHLO
        keetweej.vanheusden.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6827437Ab3BJQnqmWKRe (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 10 Feb 2013 17:43:46 +0100
Received: from belle.intranet.vanheusden.com (unknown [192.168.64.100])
        by keetweej.vanheusden.com (Postfix) with ESMTP id C177E15FA43;
        Sun, 10 Feb 2013 17:43:45 +0100 (CET)
Received: by belle.intranet.vanheusden.com (Postfix, from userid 1000)
        id A41C593510; Sun, 10 Feb 2013 17:43:45 +0100 (CET)
Date:   Sun, 10 Feb 2013 17:43:45 +0100
From:   folkert <folkert@vanheusden.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org
Subject: Re: prom start
Message-ID: <20130210164344.GE8791@belle.intranet.vanheusden.com>
References: <20130206160508.GR2118@belle.intranet.vanheusden.com>
 <20130210125625.GA32552@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20130210125625.GA32552@linux-mips.org>
Organization: www.unixexpert.nl
X-Chameleon-Return-To: folkert@vanheusden.com
X-Xfmail-Return-To: folkert@vanheusden.com
X-Phonenumber: +31-6-41278122
X-URL:  http://www.vanheusden.com/
X-PGP-KeyID: 1F28D8AE
X-GPG-fingerprint: AC89 09CE 41F2 00B4 FCF2  B174 3019 0E8C 1F28 D8AE
X-Key:  http://pgp.surfnet.nl:11371/pks/lookup?op=get&search=0x1F28D8AE
Read-Receipt-To: <folkert@vanheusden.com>
Reply-By: Sat Feb  9 18:32:07 CET 2013
X-Message-Flag: PGP key-id: 0x1f28d8ae - consider encrypting your e-mail to
 me with PGP!
User-Agent: Mutt/1.5.21 (2010-09-15)
X-archive-position: 35733
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: folkert@vanheusden.com
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

Hi,

> > Is this mailing list also meant for generic mips questions? (if not: any
> > suggestions for one that is?)
> > 
> > If so: I'mm experimenting a bit with mips, specifically on SGI hardware
> > (Indigo). Now it seems all mips systems have the prom at 0xbfc00000. But
> > how does it start? The first 0x3c0 bytes seem to be nonsense. Somewhere
> > on the web I found that 0xbfc00884 is the starting point but after
> > single stepping 5 instructions, the program counter jumps to 0x00000000
> > so I don't think that's the right one either. Also, reading the first 4
> > bytes from bfc00000 and using that as a pointer seems to be invalid too:
> > 0bf000f0.
> > Anyone with insights regarding the booting of the prom on sgi systems?
> 
> All MIPS processors start execution at 0xbfc00000 after a hardware reset
> or NMI.  0xbfc00884 is not an address that has any specific meaning in
> the processor architecture itself.  I think it's being used in the GXemul
> documentation just for sake of an example.

Yes that seems to be the case. If I start at 0xbfc00000 it looks
meaningful.

> If your disassembler defaults to like MIPS I / R3000 it won't disassemble
> all instructions for the MIPS III R4000 processor.  I'd expect some
> cache initialization code right at 0xbfc00000 and that could would be
> affected.

I'm not entirely sure yet. My D-A (well, an emulator to be honest)
implements the mips as described in MD00086 (by Mips technologies) of
June 2003 and at the bottom that document acknowledges the MIPS R3000,
4000, 5000 and 10000.

It's really fun to do, writing that mips code. All new to me. I'm at the
point that it emulates enough of the prom that it reaches points where
it gets even more interesting: undocumented hardware (0xbfa00030 and
0xbfa01004 anyone?) and fiddeling with COP0.



Folkert van Heusden

-- 
Curious about the inner workings of your car? Then check O2OO: it'll
tell you all that there is to know about your car's engine!
http://www.vanheusden.com/O2OO/
----------------------------------------------------------------------
Phone: +31-6-41278122, PGP-key: 1F28D8AE, www.vanheusden.com
