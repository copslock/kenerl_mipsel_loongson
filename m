Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 16 Feb 2005 06:37:55 +0000 (GMT)
Received: from web52808.mail.yahoo.com ([IPv6:::ffff:206.190.39.172]:25729
	"HELO web52808.mail.yahoo.com") by linux-mips.org with SMTP
	id <S8224813AbVBPGhi>; Wed, 16 Feb 2005 06:37:38 +0000
Received: (qmail 65072 invoked by uid 60001); 16 Feb 2005 06:37:31 -0000
Comment: DomainKeys? See http://antispam.yahoo.com/domainkeys
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  b=oF9vC2NkrPnaVSBxw1RyAg1RXa3aTDjUvK5RiX8Z2/roT4KEltxvRQZKv2J7jRonm3nTx1fNNPzQzEbgJoJlYKMUDd6ehYC4eSYTAseoE/49JMVk/Moy3ZR4oQbfM4ywoq98FNuLIE0yoKrvIdu4+WMUYlMu8YO1Ijqq0bitjWQ=  ;
Message-ID: <20050216063731.65070.qmail@web52808.mail.yahoo.com>
Received: from [172.194.5.211] by web52808.mail.yahoo.com via HTTP; Tue, 15 Feb 2005 22:37:31 PST
Date:	Tue, 15 Feb 2005 22:37:31 -0800 (PST)
From:	Manish Lachwani <m_lachwani@yahoo.com>
Subject: RE: kernel for custom MV64341 board?
To:	Brad Larson <Brad_Larson@pmc-sierra.com>,
	'Fredrik' <fcn-sub@noon.org>, linux-mips@linux-mips.org
In-Reply-To: <04781D450CFF604A9628C8107A62FCCF013DDCA0@sjc1exm01.pmc_nt.nt.pmc-sierra.bc.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-Path: <m_lachwani@yahoo.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7264
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: m_lachwani@yahoo.com
Precedence: bulk
X-list: linux-mips

Brad,

Just to let you know, Ocelot III is also fully
supported in 2.6. MontaVista has a 2.6 port this board
as well.

Thanks
Manish Lachwani

--- Brad Larson <Brad_Larson@pmc-sierra.com> wrote:

> Fredrik,
> 
> MontaVista completed a 2.4 port to Ocelot-III with
> RM7900 (or RM7000C) and Discovery-3 (MV64440). 
> Ocelot-III is ATX form factor while previous Ocelot,
> Ocelot-C and Ocelot-G were CPCI.  This is probably
> close to the board you are describing.  Any board
> dependent changes should have been committed to
> linux-mips.org by now.
> 
> --Brad
> 
> -----Original Message-----
> From: linux-mips-bounce@linux-mips.org
> [mailto:linux-mips-bounce@linux-mips.org]On Behalf
> Of Fredrik
> Sent: Tuesday, February 15, 2005 5:56 PM
> To: linux-mips@linux-mips.org
> Subject: kernel for custom MV64341 board?
> 
> 
> Howdy,
> 
> I'm getting a custom board going: it sports an
> RM7000 and Marvell
> MV64341 system controller (alas, no external UART!).
>  I've hacked
> U-Boot to the point where I can TFTP a kernel image
> and (start to)
> boot it.
> 
> So far I've been using an old 2.4 kernel I used for
> some Ocelot-G
> work, just to get past the TFTP-load stage. MY
> QUESTION IS: What would
> be the best kernel version for me to now start
> customizing for my
> board?  Is 2.6 too bleeding-edge, 2.4 too moldy, or
> what?  Dealing
> with the MV64341 will be most of the effort, of
> course.
> 
> The Ocelot boards seem well supported, but there
> looks to be a lot of
> code that would have to change (different system
> controller, different
> memory map--though I'm flexible--a lot of
> assumptions about the
> goodies available on-board, etc.).  This is the
> first time I'll be
> porting the kernel, so it might be more productive
> for me to start
> from a minimalist configuration and add-in what I
> need.  Enough code
> to set up the memory configuration would be a big
> help.
> 
> Suggestions?
> 
> /Fredrik
> 
>
+----------------------------------------------------------------+
> |            Fredrik Noon,   Senior Software
> Engineer            |
> |            Hifn, Inc.      www.hifn.com           
>             |
> |            fnoon@hifn.com  +1 408 399 3630        
>             |
>
|-------------------+--------------------------------------------|
> |  pgp key: <http://noon.org/keys/pgpkey.txt>
> 7840AC55           |
>
+----------------------------------------------------------------+
> 
> 
> 
