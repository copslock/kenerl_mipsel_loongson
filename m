Received:  by oss.sgi.com id <S42240AbQEYPHH>;
	Thu, 25 May 2000 08:07:07 -0700
Received: from pneumatic-tube.sgi.com ([204.94.214.22]:49013 "EHLO
        pneumatic-tube.sgi.com") by oss.sgi.com with ESMTP
	id <S42238AbQEYPGs>; Thu, 25 May 2000 08:06:48 -0700
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by pneumatic-tube.sgi.com (980327.SGI.8.8.8-aspam/980310.SGI-aspam) via ESMTP id JAA09563; Thu, 25 May 2000 09:11:28 -0700 (PDT)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id IAA69754
	for linux-list;
	Thu, 25 May 2000 08:57:12 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id IAA60416
	for <linux@cthulhu.engr.sgi.com>;
	Thu, 25 May 2000 08:57:10 -0700 (PDT)
	mail_from (flo@rfc822.org)
Received: from noose.gt.owl.de (noose.gt.owl.de [62.52.19.4]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id IAA01962
	for <linux@cthulhu.engr.sgi.com>; Thu, 25 May 2000 08:57:07 -0700 (PDT)
	mail_from (flo@rfc822.org)
Received: by noose.gt.owl.de (Postfix, from userid 10)
	id CB33B7F3; Thu, 25 May 2000 17:57:08 +0200 (CEST)
Received: by paradigm.rfc822.org (Postfix, from userid 1000)
	id 5F35E8FA7; Thu, 25 May 2000 17:53:54 +0200 (CEST)
Date:   Thu, 25 May 2000 17:53:54 +0200
From:   Florian Lohoff <flo@rfc822.org>
To:     Dag Bakke <dagb@oslo.sgi.com>
Cc:     nick@ns.snowman.net, linux@cthulhu.engr.sgi.com
Subject: Re: New indy problems
Message-ID: <20000525175354.D4082@paradigm.rfc822.org>
References: <20000525023802.A8339@uni-koblenz.de> <Pine.LNX.4.05.10005242126570.19874-100000@ns.snowman.net> <20000525102527.A4082@paradigm.rfc822.org> <flo@rfc822.org> <10005251252.ZM1368@dagb.oslo.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
User-Agent: Mutt/1.0.1i
In-Reply-To: <10005251252.ZM1368@dagb.oslo.sgi.com>; from dagb@oslo.sgi.com on Thu, May 25, 2000 at 12:52:21PM +0200
Organization: rfc822 - pure communication
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing

On Thu, May 25, 2000 at 12:52:21PM +0200, Dag Bakke wrote:
> > The indigo2 has a jumper onboard to "erase" the nvram setting (I multiple
> > times accidently changes the console setting)
> 
> The nvram pw is unrelated to the root pw on the systemdisk. (Which I am sure
> you are aware of.  :-)

If running linux you will reinstall anyway - So why do you care on the
IRIX rootpw ?

Flo
-- 
Florian Lohoff		flo@rfc822.org		      	+49-waiting-4-telekom
"Technology is a constant battle between manufacturers producing bigger and
more idiot-proof systems and nature producing bigger and better idiots."
