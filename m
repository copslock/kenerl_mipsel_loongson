Received:  by oss.sgi.com id <S553868AbQLKUG2>;
	Mon, 11 Dec 2000 12:06:28 -0800
Received: from gandalf.physik.uni-konstanz.de ([134.34.144.69]:14857 "EHLO
        gandalf.physik.uni-konstanz.de") by oss.sgi.com with ESMTP
	id <S553809AbQLKUGX>; Mon, 11 Dec 2000 12:06:23 -0800
Received: from bilbo.physik.uni-konstanz.de [134.34.144.81] 
	by gandalf.physik.uni-konstanz.de with esmtp (Exim 3.12 #1 (Debian))
	id 145ZDJ-0005EQ-00; Mon, 11 Dec 2000 21:06:21 +0100
Received: from agx by bilbo.physik.uni-konstanz.de with local (Exim 3.12 #1 (Debian))
	id 145ZDJ-0008Rx-00; Mon, 11 Dec 2000 21:06:21 +0100
Date:   Mon, 11 Dec 2000 21:06:21 +0100
From:   Guido Guenther <guido.guenther@gmx.net>
To:     linux-mips@oss.sgi.com
Subject: latest xfree86
Message-ID: <20001211210621.A32448@bilbo.physik.uni-konstanz.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

Hi,
AFAIK the folks at xfree86 are about to release a new version of X
quiet soon now. Since this will include the newport driver we ''indy 
folks'' should be able to build xfree86 without additional patches from
now on.  Could someone please check this? - it worked for me at last.
How to obtain latest XFree-cvs is described at:
http://sunsite.org.uk/XFree86/cvs/ 
Xnest is currently not building so you might want to add: 
'#define XnestServer NO' to your xc/config/cf/host.def when building
form source(or figure out why the build fails :).

I'll additionally uploaded a precompiled tarball to:
http://honk.physik.uni-konstanz.de/linux-mips/x/test/
You can simply untar it in / and run ldconfig afterwards. I'd be glad if
someone could check out this one too.

Regards,
 -- Guido
