Received:  by oss.sgi.com id <S305155AbQEMNws>;
	Sat, 13 May 2000 13:52:48 +0000
Received: from deliverator.sgi.com ([204.94.214.10]:59716 "EHLO
        deliverator.sgi.com") by oss.sgi.com with ESMTP id <S305154AbQEMNwR>;
	Sat, 13 May 2000 13:52:17 +0000
Received: from nodin.corp.sgi.com (nodin.corp.sgi.com [192.26.51.193]) by deliverator.sgi.com (980309.SGI.8.8.8-aspam-6.2/980310.SGI-aspam) via ESMTP id GAA00256; Sat, 13 May 2000 06:47:27 -0700 (PDT)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by nodin.corp.sgi.com (980427.SGI.8.8.8/980728.SGI.AUTOCF) via ESMTP id GAA45643; Sat, 13 May 2000 06:51:47 -0700 (PDT)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id GAA88122
	for linux-list;
	Sat, 13 May 2000 06:47:05 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id GAA08676;
	Sat, 13 May 2000 06:47:03 -0700 (PDT)
	mail_from (agx@bert.physik.uni-konstanz.de)
Received: from gandalf.physik.uni-konstanz.de (gandalf.physik.uni-konstanz.de [134.34.144.30]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id GAA06924; Sat, 13 May 2000 06:47:01 -0700 (PDT)
	mail_from (agx@bert.physik.uni-konstanz.de)
Received: from bert.physik.uni-konstanz.de [134.34.144.20] 
	by gandalf.physik.uni-konstanz.de with smtp (Exim 2.05 #1 (Debian))
	id 12qcFz-0000Xr-00; Sat, 13 May 2000 15:47:03 +0200
Received: by bert.physik.uni-konstanz.de (sSMTP sendmail emulation); Sat, 13 May 2000 15:42:33 +0200
Date:   Sat, 13 May 2000 15:42:33 +0200
From:   Guido Guenther <agx@bert.physik.uni-konstanz.de>
To:     Ulf Carlsson <ulfc@calypso.engr.sgi.com>
Cc:     linux@cthulhu.engr.sgi.com
Subject: Re: Indy Documentation
Message-ID: <20000513154233.A15019@bert.physik.uni-konstanz.de>
References: <Pine.LNX.4.21.0005130609590.1061-100000@calypso.engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.1.9i
In-Reply-To: <Pine.LNX.4.21.0005130609590.1061-100000@calypso.engr.sgi.com>; from ulfc@calypso.engr.sgi.com on Sat, May 13, 2000 at 06:21:56AM -0700
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing

This looks very promising. Hopefully you'll be allowed to open the
X files to non sgi people ;)
 -- Guido

On Sat, May 13, 2000 at 06:21:56AM -0700, Ulf Carlsson wrote:
> Hi,
> 
> I have some happy news.  After writing up a 47-lines bash script that would
> search every IRIX machine at SGI in parallel I managed to find most of the
> Indy documentation in electronic form.  I tried about 6000 machines before I
> found anything, and it took me almost 9 hours of hard work.  The biggest
> problem I had was that I ran into the open file limit in Linux so I could only
> search 250 machines at the same time.  Why is it so?
> 
> This is the contents of the directory:
> 
> -r--r--r--    1 guest    guest     427532 Sep 23  1998 dmux1.showcase
> dr--r--r--    2 guest    guest       4096 Sep 23  1998 gio64
> -r--r--r--    1 guest    guest     413144 Sep 23  1998 hpc3.showcase
> -r--r--r--    1 guest    guest     260096 Sep 23  1998 ioc.spec.frame
> -r--r--r--    1 guest    guest     411688 Sep 23  1998 mc.showcase
> -r--r--r--    1 guest    guest     217662 Sep 23  1998 pbus.doc
> -r--r--r--    1 guest    guest     197632 Sep 23  1998 rb2.spec.frame
> -r--r--r--    1 guest    guest     852059 Sep 23  1998 rex3.spec.ps
> -r--r--r--    1 guest    guest     169984 Sep 23  1998 ro1.spec.frame
> -r--r--r--    1 guest    guest     552960 Sep 23  1998 vc2.spec.frame
> dr--r--r--    2 guest    guest       4096 Sep 23  1998 vino
> -r--r--r--    1 guest    guest     414720 Sep 23  1998 xmap9.spec.frame
> -r--r--r--    1 guest    guest     176437 Sep 23  1998 xmap9.spec.ps
> 
> I don't know if I will be allowed to distribute this, but it's at least a huge
> step from the paper documentation that we have now.  I'll convert it to
> postscript so that we can read it..
> 
> Cheers,
> Ulf
> 

-- 
GPG-Public Key: http://honk.physik.uni-konstanz.de/~agx/guenther.gpg.asc
