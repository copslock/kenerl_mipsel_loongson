Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 31 Jan 2005 21:25:06 +0000 (GMT)
Received: from father.pmc-sierra.com ([IPv6:::ffff:216.241.224.13]:36258 "HELO
	father.pmc-sierra.bc.ca") by linux-mips.org with SMTP
	id <S8225254AbVAaVYv>; Mon, 31 Jan 2005 21:24:51 +0000
Received: (qmail 23460 invoked by uid 101); 31 Jan 2005 21:24:44 -0000
Received: from unknown (HELO ogyruan.pmc-sierra.bc.ca) (216.241.226.236)
  by father.pmc-sierra.com with SMTP; 31 Jan 2005 21:24:44 -0000
Received: from bby1exi01.pmc_nt.nt.pmc-sierra.bc.ca (bby1exi01.pmc-sierra.bc.ca [216.241.231.251])
	by ogyruan.pmc-sierra.bc.ca (8.12.9/8.12.7) with ESMTP id j0VLOhVi006627;
	Mon, 31 Jan 2005 13:24:43 -0800
Received: by bby1exi01.pmc_nt.nt.pmc-sierra.bc.ca with Internet Mail Service (5.5.2656.59)
	id <CPW1JKQP>; Mon, 31 Jan 2005 13:24:43 -0800
Message-ID: <04781D450CFF604A9628C8107A62FCCF013DDC23@sjc1exm01.pmc_nt.nt.pmc-sierra.bc.ca>
From:	Brad Larson <Brad_Larson@pmc-sierra.com>
To:	"'Ralf Baechle'" <ralf@linux-mips.org>,
	Joseph Chiu <joseph@omnilux.net>
Cc:	Clem Taylor <clem.taylor@gmail.com>, linux-mips@linux-mips.org
Subject: RE: initial bootstrap and jtag
Date:	Mon, 31 Jan 2005 13:24:42 -0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2656.59)
Content-Type: text/plain
Return-Path: <Brad_Larson@pmc-sierra.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7091
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Brad_Larson@pmc-sierra.com
Precedence: bulk
X-list: linux-mips

Yes, rom emulators still serve a useful purpose, especially when a brand new board/cpu or ejtag firmware can't communicate to each other properly.  Wait for that to get fixed (no), walk to the flash programmer for every new image (tedious), or plug in the rom emulator (30 seconds to change the image).

--Brad

> -----Original Message-----
> From: linux-mips-bounce@linux-mips.org
> [mailto:linux-mips-bounce@linux-mips.org]On Behalf Of Ralf Baechle
> Sent: Monday, January 31, 2005 1:08 PM
> To: Joseph Chiu
> Cc: Clem Taylor; linux-mips@linux-mips.org
> Subject: Re: initial bootstrap and jtag
> 
> 
> On Mon, Jan 31, 2005 at 12:42:07PM -0800, Joseph Chiu wrote:
> 
> > Do people still use ROM emulators?  I think the turnaround 
> time for getting the machine bootstrapped would have been 
> faster with a ROMulator (at least for the stuff I was doing)...
> 
> It's a while since then but the PromICE has been extremly valuable for
> some development a few years ago.  A good JTAG probe is more universal
> so may be a better investment though.
> 
>   Ralf
> 
