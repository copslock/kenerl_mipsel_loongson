Received:  by oss.sgi.com id <S42240AbQEYP4q>;
	Thu, 25 May 2000 08:56:46 -0700
Received: from pneumatic-tube.sgi.com ([204.94.214.22]:53882 "EHLO
        pneumatic-tube.sgi.com") by oss.sgi.com with ESMTP
	id <S42238AbQEYP42>; Thu, 25 May 2000 08:56:28 -0700
Received: from nodin.corp.sgi.com (nodin.corp.sgi.com [192.26.51.193]) by pneumatic-tube.sgi.com (980327.SGI.8.8.8-aspam/980310.SGI-aspam) via ESMTP id KAA02359; Thu, 25 May 2000 10:01:08 -0700 (PDT)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by nodin.corp.sgi.com (980427.SGI.8.8.8/980728.SGI.AUTOCF) via ESMTP id JAA00310; Thu, 25 May 2000 09:55:57 -0700 (PDT)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id JAA78510
	for linux-list;
	Thu, 25 May 2000 09:47:48 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id JAA85105
	for <linux@cthulhu.engr.sgi.com>;
	Thu, 25 May 2000 09:47:42 -0700 (PDT)
	mail_from (wesolows@rotor.chem.unr.edu)
Received: from rotor.chem.unr.edu (rotor.chem.unr.edu [134.197.32.176]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id JAA08532
	for <linux@cthulhu.engr.sgi.com>; Thu, 25 May 2000 09:47:36 -0700 (PDT)
	mail_from (wesolows@rotor.chem.unr.edu)
Received: (from wesolows@localhost)
	by rotor.chem.unr.edu (8.9.3/8.9.3) id JAA30793;
	Thu, 25 May 2000 09:47:36 -0700
Date:   Thu, 25 May 2000 09:47:36 -0700
From:   Keith M Wesolowski <wesolows@chem.unr.edu>
To:     Eric Watkins <watkinse@attens.com>
Cc:     Philippe Chauvat <philippe.chauvat@exfo.com>,
        Linux Mips <linux@cthulhu.engr.sgi.com>
Subject: Re: [DHCP]
Message-ID: <20000525094735.A30683@chem.unr.edu>
References: <392D4F76.9B06C235@exfo.com> <001801bfc665$feabed20$540ed7c0@hq.sd.cerf.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <001801bfc665$feabed20$540ed7c0@hq.sd.cerf.net>; from watkinse@attens.com on Thu, May 25, 2000 at 09:26:35AM -0700
X-Complaints-To: postmaster@chem.unr.edu
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing

On Thu, May 25, 2000 at 09:26:35AM -0700, Eric Watkins wrote:

> Either the isc.org dhcpd sends things the SGIs aren't prepared to get or it
> just not implementing bootpd the right way. I think it's just a config issue
> but I've yet to get things right with the dhcpd.conf. You'll notice there
> are 4 get requests in the log files before the SGI times out.

I also had difficulty using ISC dhcpd to boot SGIs until I did an
unsetenv netaddr before booting. I don't yet know why this works.

-- 
Keith M Wesolowski			wesolows@chem.unr.edu
University of Nevada			http://www.chem.unr.edu
Chemistry Department Systems and Network Administrator
