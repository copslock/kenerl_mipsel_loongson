Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fBICRic32677
	for linux-mips-outgoing; Tue, 18 Dec 2001 04:27:44 -0800
Received: from gandalf.physik.uni-konstanz.de (gandalf.physik.uni-konstanz.de [134.34.144.69])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id fBICRgo32673
	for <linux-mips@oss.sgi.com>; Tue, 18 Dec 2001 04:27:43 -0800
Received: from agx by gandalf.physik.uni-konstanz.de with local (Exim 3.12 #1 (Debian))
	id 16GIPL-0004Xw-00; Tue, 18 Dec 2001 12:27:39 +0100
Date: Tue, 18 Dec 2001 12:27:39 +0100
From: Guido Guenther <agx@sigxcpu.org>
To: Greg MATTHEWS <G.Matthews@cs.ucl.ac.uk>
Cc: linux-mips@oss.sgi.com, debian-mips@lists.debian.org
Subject: Re: Console corruption with newport & XFree86
Message-ID: <20011218122739.B17384@gandalf.physik.uni-konstanz.de>
Mail-Followup-To: Greg MATTHEWS <G.Matthews@cs.ucl.ac.uk>,
	linux-mips@oss.sgi.com, debian-mips@lists.debian.org
References: <20011218001546.B11359@galadriel.physik.uni-konstanz.de> <4498.1008671659@cs.ucl.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <4498.1008671659@cs.ucl.ac.uk>; from G.Matthews@cs.ucl.ac.uk on Tue, Dec 18, 2001 at 10:34:19AM +0000
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Tue, Dec 18, 2001 at 10:34:19AM +0000, Greg MATTHEWS wrote:
> under what circumstances does corruption take place on the relevant newport?
You start X and switch back to the console(CTRL-ALT-F1) and your screen
becomes completely black - switching back to X works fine though. It's
actually the reading of the old colormap data on server *startup* that
fails on these boards.
 -- Guido
