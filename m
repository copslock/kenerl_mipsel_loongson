Received:  by oss.sgi.com id <S42243AbQEYHiJ>;
	Thu, 25 May 2000 00:38:09 -0700
Received: from pneumatic-tube.sgi.com ([204.94.214.22]:15958 "EHLO
        pneumatic-tube.sgi.com") by oss.sgi.com with ESMTP
	id <S42238AbQEYHhp>; Thu, 25 May 2000 00:37:45 -0700
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by pneumatic-tube.sgi.com (980327.SGI.8.8.8-aspam/980310.SGI-aspam) via ESMTP id BAA08678; Thu, 25 May 2000 01:42:25 -0700 (PDT)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id BAA36763
	for linux-list;
	Thu, 25 May 2000 01:28:23 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id BAA00116
	for <linux@cthulhu.engr.sgi.com>;
	Thu, 25 May 2000 01:28:14 -0700 (PDT)
	mail_from (agx@bert.physik.uni-konstanz.de)
Received: from gandalf.physik.uni-konstanz.de (gandalf.physik.uni-konstanz.de [134.34.144.30]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id BAA05637
	for <linux@cthulhu.engr.sgi.com>; Thu, 25 May 2000 01:27:48 -0700 (PDT)
	mail_from (agx@bert.physik.uni-konstanz.de)
Received: from bert.physik.uni-konstanz.de [134.34.144.20] 
	by gandalf.physik.uni-konstanz.de with smtp (Exim 2.05 #1 (Debian))
	id 12uszd-00021x-00; Thu, 25 May 2000 10:27:49 +0200
Received: by bert.physik.uni-konstanz.de (sSMTP sendmail emulation); Thu, 25 May 2000 10:27:49 +0200
Date:   Thu, 25 May 2000 10:27:48 +0200
From:   Guido Guenther <agx@bert.physik.uni-konstanz.de>
To:     Mitja Bezget <gw@sers.s-sers.mb.edus.si>,
        linux@cthulhu.engr.sgi.com
Subject: Re: Binary XFree
Message-ID: <20000525102748.A401@bert.physik.uni-konstanz.de>
Mail-Followup-To: Guido Guenther <guido.guenther@uni-konstanz.de>,
	Mitja Bezget <gw@sers.s-sers.mb.edus.si>,
	linux@cthulhu.engr.sgi.com
References: <Pine.LNX.3.95.1000524131606.8181B-100000@sers.s-sers.mb.edus.si> <20000524153943.B3802@bert.physik.uni-konstanz.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.1.9i
In-Reply-To: <20000524153943.B3802@bert.physik.uni-konstanz.de>; from agx@bert.physik.uni-konstanz.de on Wed, May 24, 2000 at 03:39:43PM +0200
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing

I finally found the time to check the binaries. I screwed the
permissions. Changing to /usr/X11R6 and "chown -R root. *" should solve
the problem. You also have to set the XFree86 suid root.
 -- Guido

On Wed, May 24, 2000 at 03:39:43PM +0200, Guido Guenther wrote:
> No problem here. Should be a problem with you local setup. Can you
> "touch /var/log/XFree86.0.log" as root?
>  -- Guido
> 
> On Wed, May 24, 2000 at 01:19:45PM +0200, Mitja Bezget wrote:
> > 
> > Hey!
> > 
> > I downloaded the binarys and installed successfuly.. But the 
> > server still wouldn't run.. it displays a senseless message:
> > Couldn't open log file "/var/log/XFree86.0.log" 
> > 
> > although it is run as root and the directory exists.
> > any ideas? thanks!
> > 
> > cya
> > Mitja
> > 
> > 
> > 
> 
> -- 
> GPG-Public Key: http://honk.physik.uni-konstanz.de/~agx/guenther.gpg.asc

-- 
GPG-Public Key: http://honk.physik.uni-konstanz.de/~agx/guenther.gpg.asc
