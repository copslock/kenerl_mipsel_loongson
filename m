Received:  by oss.sgi.com id <S42431AbQIUHSa>;
	Thu, 21 Sep 2000 00:18:30 -0700
Received: from gandalf.physik.uni-konstanz.de ([134.34.144.30]:22098 "EHLO
        gandalf.physik.uni-konstanz.de") by oss.sgi.com with ESMTP
	id <S42315AbQIUHSJ>; Thu, 21 Sep 2000 00:18:09 -0700
Received: from bilbo.physik.uni-konstanz.de [134.34.144.81] 
	by gandalf.physik.uni-konstanz.de with esmtp (Exim 2.05 #1 (Debian))
	id 13c0cQ-0007GO-00; Thu, 21 Sep 2000 09:18:06 +0200
Received: from agx by bilbo.physik.uni-konstanz.de with local (Exim 3.12 #1 (Debian))
	id 13c0cQ-0001BT-00; Thu, 21 Sep 2000 09:18:06 +0200
Date:   Thu, 21 Sep 2000 09:18:06 +0200
From:   Guido Guenther <guido.guenther@gmx.net>
To:     Geert Albert Smant <smant@nlr.nl>
Cc:     linux-mips@oss.sgi.com
Subject: Re: HELP: XFree86 4.0.1 on Indy
Message-ID: <20000921091806.A4531@bilbo.physik.uni-konstanz.de>
References: <200009201534.RAA95028@uxmain.nlr.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
User-Agent: Mutt/1.0.1i
In-Reply-To: <200009201534.RAA95028@uxmain.nlr.nl>; from smant@nlr.nl on Wed, Sep 20, 2000 at 05:34:44PM +0200
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Wed, Sep 20, 2000 at 05:34:44PM +0200, Geert Albert Smant wrote:
> The system boots without any problems and I also installed
> the XFree86 4.0.1 binaries on the system, but when I start
> the X-server by typing 'startx' the graphics console
> blanks and a cursor appears on the top left corner of
> the screen.
Add 'Option "shadowfb" "yes"' to the device section of the XF86Config
file.
Hope this help,
 -- Guido

-- 
GPG-Public Key: finger agx@debian.org
