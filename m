Received:  by oss.sgi.com id <S42287AbQEXTWz>;
	Wed, 24 May 2000 12:22:55 -0700
Received: from deliverator.sgi.com ([204.94.214.10]:64372 "EHLO
        deliverator.sgi.com") by oss.sgi.com with ESMTP id <S42277AbQEXTWb>;
	Wed, 24 May 2000 12:22:31 -0700
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by deliverator.sgi.com (980309.SGI.8.8.8-aspam-6.2/980310.SGI-aspam) via ESMTP id MAA11669; Wed, 24 May 2000 12:17:39 -0700 (PDT)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id MAA27754
	for linux-list;
	Wed, 24 May 2000 12:12:35 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id MAA31675
	for <linux@cthulhu.engr.sgi.com>;
	Wed, 24 May 2000 12:12:12 -0700 (PDT)
	mail_from (wesolows@rotor.chem.unr.edu)
Received: from rotor.chem.unr.edu (rotor.chem.unr.edu [134.197.32.176]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id MAA08632
	for <linux@cthulhu.engr.sgi.com>; Wed, 24 May 2000 12:12:11 -0700 (PDT)
	mail_from (wesolows@rotor.chem.unr.edu)
Received: (from wesolows@localhost)
	by rotor.chem.unr.edu (8.9.3/8.9.3) id MAA17493;
	Wed, 24 May 2000 12:11:59 -0700
Date:   Wed, 24 May 2000 12:11:59 -0700
From:   Keith M Wesolowski <wesolows@chem.unr.edu>
To:     Eric Watkins <watkinse@attens.com>
Cc:     linux@cthulhu.engr.sgi.com
Subject: Re: New mini-distribution/indigo2 monitor support
Message-ID: <20000524121159.A17430@chem.unr.edu>
References: <20000519154511.B21086@chem.unr.edu> <003001bfc5a5$9be16960$540ed7c0@hq.sd.cerf.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <003001bfc5a5$9be16960$540ed7c0@hq.sd.cerf.net>; from watkinse@attens.com on Wed, May 24, 2000 at 10:29:26AM -0700
X-Complaints-To: postmaster@chem.unr.edu
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing

On Wed, May 24, 2000 at 10:29:26AM -0700, Eric Watkins wrote:

> Are you suggesting that I remove the vid card?

Yes. I needed to and it's mentioned at
http://reality.sgi.com/raju/SGI-Linux-mini-HOWTO.html.

> I'm trying to get my indigo2 to boot linux. Can you go into more detail on
> how to remove the framebuffer?

Pop the cover off and hinge the left rear panel to the left. Unscrew
the two graphics boards from the case (just like peecee boards) and
take the thing out.

> When can I see X in all of it's glory on an indigo2?

Guido just got X on XL working. No idea what the timetable for XZ
might be.

-- 
Keith M Wesolowski			wesolows@chem.unr.edu
University of Nevada			http://www.chem.unr.edu
Chemistry Department Systems and Network Administrator
