Received:  by oss.sgi.com id <S42231AbQJJDOm>;
	Mon, 9 Oct 2000 20:14:42 -0700
Received: from wo1133.wohnheim.uni-wuerzburg.de ([132.187.221.133]:58407 "EHLO
        wo1133.wohnheim.uni-wuerzburg.de") by oss.sgi.com with ESMTP
	id <S42230AbQJJDO2>; Mon, 9 Oct 2000 20:14:28 -0700
Received: (from rhoenie@localhost)
	by wo1133.wohnheim.uni-wuerzburg.de (SGI-8.9.3/8.9.3) id FAA36565
	for linux-mips@oss.sgi.com; Tue, 10 Oct 2000 05:13:48 +0200 (CEST)
Date:   Tue, 10 Oct 2000 05:13:48 +0200
From:   Marcus Herbert <rhoenie@spam-filter.de>
To:     Linux on MIPS <linux-mips@oss.sgi.com>
Subject: Re: sgiserial.c
Message-ID: <20001010051348.A36498@wo1133.wohnheim.uni-wuerzburg.de>
Mail-Followup-To: Marcus Herbert <rhoenie@spam-filter.de>,
	Linux on MIPS <linux-mips@oss.sgi.com>
References: <39E22B5A.66587B5A@ridgerun.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.2i
In-Reply-To: <39E22B5A.66587B5A@ridgerun.com>; from gmcnutt@ridgerun.com on Mon, Oct 09, 2000 at 02:32:26PM -0600
X-Wisdom: Do not dangle the mouse by its cable or throw the mouse at co-workers.
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Mon, Oct 09, 2000 at 02:32:26PM -0600, Gordon McNutt wrote:
> I'm trying to get the Indy's serial port to drive a peripheral card at
> 115200 baud. It appears to work OK at 9600 baud (the serial port that is
> -- the card expects 115200 baud).

It is limited to 38400 bit/second on hardware side. Read IRIX serial 
manpage:

[..]
SUPPORTED SPEEDS
     The serial ports of all SGI systems support several standard rates
     up through 38400 bps (see termio(7) for these standard rates).
     The serial ports on O2, OCTANE, Origin2000, Onyx2 and Origin200
     systems also support
     
                                31250   57600
                                76800   115200
[..]

This is common knowlegde btw ;-)

-- 
      PGP2 Key-ID: 666/36540865 1997/06/09 <rhoenie@spam-filter.de>
       GPG Key-ID: 1024D/2E2DAB44 2000-01-30 <rhoenie@spam-filter.de>
        Geek-Code: GCS b O e+ h
