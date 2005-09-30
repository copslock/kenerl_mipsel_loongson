Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 30 Sep 2005 12:48:42 +0100 (BST)
Received: from gw.icm.edu.pl ([212.87.0.39]:55990 "EHLO atol.icm.edu.pl")
	by ftp.linux-mips.org with ESMTP id S3465570AbVI3LsW (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 30 Sep 2005 12:48:22 +0100
Received: from fs.icm.edu.pl (fs.icm.edu.pl [192.168.1.165])
	by atol.icm.edu.pl (8.13.1/8.13.1/rzm-5.1/icm) with ESMTP id j8UBmIbm020204
	for <linux-mips@linux-mips.org>; Fri, 30 Sep 2005 13:48:18 +0200
Received: from ws-gradcol1.icm.edu.pl (ws-gradcol1.icm.edu.pl [192.168.1.26])
	by fs.icm.edu.pl (8.13.3/8.13.2/rzm-5.0hub/icm) with ESMTP id j8UBmIxj015749
	for <linux-mips@linux-mips.org>; Fri, 30 Sep 2005 13:48:18 +0200 (CEST)
Received: by ws-gradcol1.icm.edu.pl (Postfix, from userid 5242)
	id 065D1920DA; Fri, 30 Sep 2005 13:48:17 +0200 (CEST)
Date:	Fri, 30 Sep 2005 13:48:16 +0200
From:	"Dominik 'Rathann' Mierzejewski" <D.Mierzejewski@icm.edu.pl>
To:	linux-mips@linux-mips.org
Subject: Re: Floating point performance
Message-ID: <20050930114816.GB13730@ws-gradcol1.icm.edu.pl>
Mail-Followup-To: linux-mips@linux-mips.org
References: <6EC3F44BE5E6B742BE3EBC3465525944096814@emea-exchange3.emea.dps.local> <1127992600.10179.19.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1127992600.10179.19.camel@localhost.localdomain>
User-Agent: Mutt/1.5.9i
X-Rcpt-To: <linux-mips@linux-mips.org>
X-Classes: vf: <linux-mips@linux-mips.org>, vh: , sf: <linux-mips@linux-mips.org>, sh:  (MDrzm)
X-Filtry: w sprawie filtracji wirusow i spamu pisz do: spam@icm.edu.pl
X-Scanned-By: MIMEDefang 2.51 on 192.168.1.242
Return-Path: <D.Mierzejewski@icm.edu.pl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9094
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: D.Mierzejewski@icm.edu.pl
Precedence: bulk
X-list: linux-mips

On Thu, Sep 29, 2005 at 01:16:40PM +0200, Matej Kupljen wrote:
> Hi
> 
> > > I've built soft float toolchain (with crosstool) and then build
> > > MPlayer with it. The performance is very low. I cannot even play the
> > > mp3 file with MPlayer on DBAU1200 with 400MHz CPU!
> > [...]
> > > Any other suggestions?
> > 
> > I'm not sure what you are doing, but if you only want to play music, 
> > I'd use Ogg Vorbis instead, which has a decoder that only uses integer 
> > arithmetic for exactly the case of FPU-less machines and the Au1200. 
> > I could also imagine an MP3 decoder written for integer only being 
> > written somewhere, but I don't know anything about it.
> 
> Yes, I can use madplay (libmad) for music only, which uses int
> arithmetics (also special version for MIPS).
> 
> But I also want to play video and currently I am testing this with
> MPlayer (maybe I'll add support for MAE, sometime in the future).
> Then I found out, that MPlayer can use libmad for MP3 and it
> works great know.
> 
> Now I'll try to write XV driver for MAE backend so I'll have
> HW accelerated Color Space Conversion (form YV12->RGB) and
> Scaling. 

If you're interested in video playback using MPlayer, you may
want to port the assembly parts of its code to MIPS. We (MPlayer
developers) would be grateful if you could contribute your code
back to MPlayer. I'm sure that you can get assistance from our
coders if you have any problems and questions about the code.

Regards,
R.

-- 
Dominik 'Rathann' Mierzejewski <rathann*at*icm.edu.pl>
Interdisciplinary Centre for Mathematical and Computational Modelling
Warsaw University  |  http://www.icm.edu.pl  |  tel. +48 (22) 5540810
