Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g0VBBpg13083
	for linux-mips-outgoing; Thu, 31 Jan 2002 03:11:51 -0800
Received: from gandalf.physik.uni-konstanz.de (gandalf.physik.uni-konstanz.de [134.34.144.69])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g0VBBmd13080
	for <linux-mips@oss.sgi.com>; Thu, 31 Jan 2002 03:11:48 -0800
Received: from agx by gandalf.physik.uni-konstanz.de with local (Exim 3.12 #1 (Debian))
	id 16WEC1-00041W-00; Thu, 31 Jan 2002 11:11:45 +0100
Date: Thu, 31 Jan 2002 11:11:45 +0100
From: Guido Guenther <agx@sigxcpu.org>
To: linux-mips@oss.sgi.com
Subject: Re: Newport XZ
Message-ID: <20020131111144.A14922@gandalf.physik.uni-konstanz.de>
Mail-Followup-To: linux-mips@oss.sgi.com
References: <Pine.SOL.4.31.0201301828450.13740-100000@fury.csh.rit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.SOL.4.31.0201301828450.13740-100000@fury.csh.rit.edu>; from werkt@csh.rit.edu on Wed, Jan 30, 2002 at 06:30:38PM -0500
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Wed, Jan 30, 2002 at 06:30:38PM -0500, George Gensure wrote:
> Does the current kernel support the 2 board Newport XZ?  I have it in one
> of my machines, and I can't even get console, let alone get in there to
> run X. (no serial terminal available... damn the mac style serial)
If this is a 2 board XL, chances might be good to get this working
fairly easily. My impression was always that these are basically two XL
boards located at different base addresses, but I never ever got my
hands on such a board myself. Anyway you'll need a serial cable to debug
things anyway.
As for the XZ, there are no docs neither for single headed nor dual
head(I didn't know there's a dual head XZ too).
 -- Guido
