Received:  by oss.sgi.com id <S42294AbQEXNon>;
	Wed, 24 May 2000 06:44:43 -0700
Received: from deliverator.sgi.com ([204.94.214.10]:6415 "EHLO
        deliverator.sgi.com") by oss.sgi.com with ESMTP id <S42293AbQEXNoe>;
	Wed, 24 May 2000 06:44:34 -0700
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by deliverator.sgi.com (980309.SGI.8.8.8-aspam-6.2/980310.SGI-aspam) via ESMTP id GAA24100; Wed, 24 May 2000 06:39:42 -0700 (PDT)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id GAA68190
	for linux-list;
	Wed, 24 May 2000 06:36:06 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id GAA27995
	for <linux@cthulhu.engr.sgi.com>;
	Wed, 24 May 2000 06:36:05 -0700 (PDT)
	mail_from (agx@bert.physik.uni-konstanz.de)
Received: from gandalf.physik.uni-konstanz.de (gandalf.physik.uni-konstanz.de [134.34.144.30]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id GAA03185
	for <linux@cthulhu.engr.sgi.com>; Wed, 24 May 2000 06:36:03 -0700 (PDT)
	mail_from (agx@bert.physik.uni-konstanz.de)
Received: from bert.physik.uni-konstanz.de [134.34.144.20] 
	by gandalf.physik.uni-konstanz.de with smtp (Exim 2.05 #1 (Debian))
	id 12ubKM-0008Lb-00; Wed, 24 May 2000 15:36:02 +0200
Received: by bert.physik.uni-konstanz.de (sSMTP sendmail emulation); Wed, 24 May 2000 15:34:45 +0200
Date:   Wed, 24 May 2000 15:34:45 +0200
From:   Guido Guenther <agx@bert.physik.uni-konstanz.de>
To:     Mitja Bezget <gw@sers.s-sers.mb.edus.si>
Cc:     linux@cthulhu.engr.sgi.com
Subject: Re: newport driver for XFree
Message-ID: <20000524153444.A3802@bert.physik.uni-konstanz.de>
Mail-Followup-To: Guido Guenther <guido.guenther@uni-konstanz.de>,
	Mitja Bezget <gw@sers.s-sers.mb.edus.si>,
	linux@cthulhu.engr.sgi.com
References: <Pine.LNX.3.95.1000524093350.6454A-200000@sers.s-sers.mb.edus.si> <20000524134215.A3748@bert.physik.uni-konstanz.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.1.9i
In-Reply-To: <20000524134215.A3748@bert.physik.uni-konstanz.de>; from agx@bert.physik.uni-konstanz.de on Wed, May 24, 2000 at 01:42:15PM +0200
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing

On Wed, May 24, 2000 at 01:42:15PM +0200, Guido Guenther wrote:
> On Wed, May 24, 2000 at 12:31:49PM +0200, Mitja Bezget wrote:
> > hi!
> > 
> > I'm having problems running xfree on an old Indy
> > so i tought i should report&ask for help..
> > 
> > First I applyed the patch (is it recent??):
> There's a newer patch available on that site but this one should work
> also.
I checked the patch and 000514 doesn't create the correct host.def,
I messed up some filenames. Fetch instead:
 http://honk.physik.uni-konstanz.de/~agx/mipslinux/x/source/newport_000524.diff
then:
 tar zxvf X400src-1.tgz
 patch -p1 < newport_000524.diff

[..snip..] 
> > i'm running glibc-2.0.6-4 (+devel) and egcs-1.0.2-9..
I had numerous problems with egcs 1.0.2. I'd recommend to use egcs
1.0.3.
 -- Guido

[..snip..] 

-- 
GPG-Public Key: http://honk.physik.uni-konstanz.de/~agx/guenther.gpg.asc
