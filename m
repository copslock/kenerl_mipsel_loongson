Received:  by oss.sgi.com id <S553993AbQKHOLj>;
	Wed, 8 Nov 2000 06:11:39 -0800
Received: from u-203.karlsruhe.ipdial.viaginterkom.de ([62.180.21.203]:49416
        "EHLO u-203.karlsruhe.ipdial.viaginterkom.de") by oss.sgi.com
	with ESMTP id <S553928AbQKHOLK>; Wed, 8 Nov 2000 06:11:10 -0800
Received: (ralf@lappi) by lappi.waldorf-gmbh.de id <S868643AbQKHOKs>;
        Wed, 8 Nov 2000 15:10:48 +0100
Date:   Wed, 8 Nov 2000 15:10:48 +0100
From:   Ralf Baechle <ralf@oss.sgi.com>
To:     "Kevin D. Kissell" <kevink@mips.com>
Cc:     Nicu Popovici <octavp@isratech.ro>, linux-mips@oss.sgi.com
Subject: Re: MIPS kernel!
Message-ID: <20001108151048.A13841@bacchus.dhis.org>
References: <3A09753F.DB2457EE@isratech.ro> <004101c04969$b744b160$0323c0d8@Ulysses>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <004101c04969$b744b160$0323c0d8@Ulysses>; from kevink@mips.com on Wed, Nov 08, 2000 at 10:53:14AM +0100
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Wed, Nov 08, 2000 at 10:53:14AM +0100, Kevin D. Kissell wrote:

> In general, at MIPS, we generally build native or semi-native
> (mipsel on mipseb machines and vice versa).  In cross-builds
> of other components, however, I have observed that problems
> such as those you describe can result from include files
> on the host platform being erroneously pulled in to the cross-build.
> Cross-gcc and the makefiles have been known to be set up such
> that, if the needed include file can be found neither in the explicitly
> requested directories nor in the cross-compiler's default includes, 
> it will silently search the host /usr/include directories.

This is either a bug in the version that you're using, a wrongly installed
compiled or simply wrong -I directives passed to the compiler.  The
crosscompiler rpms as distributed on oss will only search:

 /usr/lib/gcc-lib/mips-linux/egcs-2.91.66/include
 /usr/mips-linux/include

by default.  I just tried, egcs-1.1.2-2 also doesn't search silently in
other directories.  So it's not a problem of gcc itself which leaves the
makefiles.  If you find any instance of the wrong directories being
searched, please tell me.  Or better, include a patch :-)

  Ralf
