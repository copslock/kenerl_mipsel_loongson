Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g2IG1Vh01561
	for linux-mips-outgoing; Mon, 18 Mar 2002 08:01:31 -0800
Received: from hell (buserror-extern.convergence.de [212.84.236.66])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g2IG1R901558
	for <linux-mips@oss.sgi.com>; Mon, 18 Mar 2002 08:01:28 -0800
Received: from js by hell with local (Exim 3.35 #1 (Debian))
	id 16mzae-0000qO-00; Mon, 18 Mar 2002 17:02:28 +0100
Date: Mon, 18 Mar 2002 17:02:28 +0100
From: Johannes Stezenbach <js@convergence.de>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Jan-Benedict Glaw <jbglaw@lug-owl.de>,
   SGI MIPS list <linux-mips@oss.sgi.com>
Subject: Re: Toolchain question
Message-ID: <20020318160228.GA3214@convergence.de>
Mail-Followup-To: Johannes Stezenbach <js@convergence.de>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Jan-Benedict Glaw <jbglaw@lug-owl.de>,
	SGI MIPS list <linux-mips@oss.sgi.com>
References: <20020318154202.GA3092@convergence.de> <Pine.GSO.4.21.0203181644380.5561-100000@vervain.sonytel.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.21.0203181644380.5561-100000@vervain.sonytel.be>
User-Agent: Mutt/1.3.27i
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Mon, Mar 18, 2002 at 04:47:13PM +0100, Geert Uytterhoeven wrote:
> On Mon, 18 Mar 2002, Johannes Stezenbach wrote:
> > I'm using binutils-2.12.90.0.1 and gcc-2.95.4-debian, which
> > was recommended here. Read the the thread on "gcc include strangeness"
> > around Feb. 11 for details.
> 
> Are you compiling natively, or did you create a cross-compiler using the
> gcc-2.95.4-debian sources?
> 
> In the latter case, I'm interested in the magic you used to build the
> cross-compiler, since I can't seem to build a cross-compiler for any arch using
> those sources (2.95.2 was fine).

I built a cross compiler. After 'apt-get source gcc-2.95' I did:
(The instructions in debian/README.cross did not work for me.)

- edit debian/rules.def so that
      TARGETS=mips
    (README.cross mentions you have to do this)
- run
  $ debian/rules patch
- now you have a patched source tree for mips in src-mips, which
  configures and builds fine.


HTH,
Johannes
