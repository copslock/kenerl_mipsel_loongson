Received:  by oss.sgi.com id <S305155AbQEMOn6>;
	Sat, 13 May 2000 14:43:58 +0000
Received: from deliverator.sgi.com ([204.94.214.10]:10068 "EHLO
        deliverator.sgi.com") by oss.sgi.com with ESMTP id <S305154AbQEMOnr>;
	Sat, 13 May 2000 14:43:47 +0000
Received: from nodin.corp.sgi.com (nodin.corp.sgi.com [192.26.51.193]) by deliverator.sgi.com (980309.SGI.8.8.8-aspam-6.2/980310.SGI-aspam) via ESMTP id HAA03270; Sat, 13 May 2000 07:38:57 -0700 (PDT)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by nodin.corp.sgi.com (980427.SGI.8.8.8/980728.SGI.AUTOCF) via ESMTP id HAA51537; Sat, 13 May 2000 07:42:01 -0700 (PDT)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id HAA68765
	for linux-list;
	Sat, 13 May 2000 07:33:44 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id HAA20729
	for <linux@cthulhu.engr.sgi.com>;
	Sat, 13 May 2000 07:33:42 -0700 (PDT)
	mail_from (agx@bert.physik.uni-konstanz.de)
Received: from gandalf.physik.uni-konstanz.de (gandalf.physik.uni-konstanz.de [134.34.144.30]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id HAA00588
	for <linux@cthulhu.engr.sgi.com>; Sat, 13 May 2000 07:33:41 -0700 (PDT)
	mail_from (agx@bert.physik.uni-konstanz.de)
Received: from bert.physik.uni-konstanz.de [134.34.144.20] 
	by gandalf.physik.uni-konstanz.de with smtp (Exim 2.05 #1 (Debian))
	id 12qcz6-0000bA-00; Sat, 13 May 2000 16:33:40 +0200
Received: by bert.physik.uni-konstanz.de (sSMTP sendmail emulation); Sat, 13 May 2000 16:29:08 +0200
Date:   Sat, 13 May 2000 16:29:08 +0200
From:   Guido Guenther <agx@bert.physik.uni-konstanz.de>
To:     linux-mips@fnet.fr, linux@cthulhu.engr.sgi.com
Subject: Re: xfree86 on an indy
Message-ID: <20000513162907.A16713@bert.physik.uni-konstanz.de>
Mail-Followup-To: Guido Guenther <guido.guenther@uni-konstanz.de>,
	linux-mips@fnet.fr, linux@cthulhu.engr.sgi.com
References: <20000507130325.B27271@bilbo.physik.uni-konstanz.de> <Pine.LNX.4.21.0005070451410.978-100000@calypso.engr.sgi.com> <20000507150606.A27447@bilbo.physik.uni-konstanz.de> <20000509113131.D258@bilbo.physik.uni-konstanz.de> <20000509194817.A1090@bert.physik.uni-konstanz.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.1.9i
In-Reply-To: <20000509194817.A1090@bert.physik.uni-konstanz.de>; from agx@bert.physik.uni-konstanz.de on Tue, May 09, 2000 at 07:48:17PM +0200
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing

And using -cc 2 gives a 256 _color_ display - silly me( I still don't know
why the PseudoColor visual doesn't work correctly, but I'll look into
getting the mouse going first now). That the xfree86 guys don't have public
mailing lists and BTS doesn't make life easier ... 
 -- Guido

On Tue, May 09, 2000 at 07:48:17PM +0200, Guido Guenther wrote:
> On Tue, May 09, 2000 at 11:31:31AM +0200, Guido Guenther wrote:
> > colormap & mouse are still broken. 
> The problem seems to be related to the default visual used. You can use
> the "-cc StaticGray" command line option to get at least a greyscaled
> diplay.
>  -- Guido
> 
> -- 
> GPG-Public Key: http://honk.physik.uni-konstanz.de/~agx/guenther.gpg.asc
> 

-- 
GPG-Public Key: http://honk.physik.uni-konstanz.de/~agx/guenther.gpg.asc
