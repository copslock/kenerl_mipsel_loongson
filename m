Received:  by oss.sgi.com id <S42250AbQIZRe5>;
	Tue, 26 Sep 2000 10:34:57 -0700
Received: from rotor.chem.unr.edu ([134.197.32.176]:31759 "EHLO
        rotor.chem.unr.edu") by oss.sgi.com with ESMTP id <S42229AbQIZRef>;
	Tue, 26 Sep 2000 10:34:35 -0700
Received: (from wesolows@localhost)
	by rotor.chem.unr.edu (8.9.3/8.9.3) id KAA16398;
	Tue, 26 Sep 2000 10:33:14 -0700
Date:   Tue, 26 Sep 2000 10:33:14 -0700
From:   Keith M Wesolowski <wesolows@chem.unr.edu>
To:     "Jordan, Shane" <SJordan@aivia.net>
Cc:     linux-mips@oss.sgi.com
Subject: Re: Getting started
Message-ID: <20000926103313.B15401@chem.unr.edu>
References: <D1E34549DAC3D311A05D0020940F00FF62D460@exchmail.velocityenterprises.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <D1E34549DAC3D311A05D0020940F00FF62D460@exchmail.velocityenterprises.net>; from SJordan@aivia.net on Tue, Sep 26, 2000 at 10:20:14AM -0500
X-Complaints-To: postmaster@chem.unr.edu
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Tue, Sep 26, 2000 at 10:20:14AM -0500, Jordan, Shane wrote:

> Ok I have a older Indy box here and I was wondering what I need to do to get
> this thing running Linux.  From what I understand you have to have Irix
> already installed on it.  Unfortunently we just threw a new harddrive in
> with nothing on it and we don't have a copy of Irix.  Is there anyway to
> install Linux on this badboy from scratch?  I'm willing to help our with
> making binary package's ect if I can just get this thing booting into linux!
> Any ideas, cd's ect?

Afaik there are still no CDs you can use. However, it is not true that
you need Irix. The current problem is lack of a bootloader. So most
people just boot over the network and then use local disk. Another
option, the one that requires Irix, calls for placing a Linux kernel
in an Irix efs filesystem. A third option, not terribly easy to do
without Irix, calls for placing an entire Linux kernel in the boot
block. I recommend netbooting for now, especially if you don't have
Irix.

There are several distributions of varying non-production quality
available. Start with the HOWTO at
http://oss.sgi.com/mips/mips-howto.html. For some reason, my distro
isn't included in that document even though I wrote a piece for it
(Ralf?), so see also http://foobazco.org/~wesolows/Install-HOWTO.html
- note that 0.2b is out but already getting fairly old. I know for a
fact that you can install it without Irix because that's what I did
from day one.

-- 
Keith M Wesolowski			wesolows@chem.unr.edu
University of Nevada			http://www.chem.unr.edu
Chemistry Department Systems and Network Administrator
