Received:  by oss.sgi.com id <S305155AbQCGUPG>;
	Tue, 7 Mar 2000 12:15:06 -0800
Received: from deliverator.sgi.com ([204.94.214.10]:32830 "EHLO
        deliverator.sgi.com") by oss.sgi.com with ESMTP id <S305154AbQCGUOn>;
	Tue, 7 Mar 2000 12:14:43 -0800
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by deliverator.sgi.com (980309.SGI.8.8.8-aspam-6.2/980310.SGI-aspam) via ESMTP id MAA19319; Tue, 7 Mar 2000 12:10:07 -0800 (PST)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id LAA33527
	for linux-list;
	Tue, 7 Mar 2000 11:44:05 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id LAA57008
	for <linux@cthulhu.engr.sgi.com>;
	Tue, 7 Mar 2000 11:43:28 -0800 (PST)
	mail_from (Harald.Koerfgen@home.ivm.de)
Received: from mail.ivm.net (mail.ivm.net [62.204.1.4]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id LAA08353
	for <linux@cthulhu.engr.sgi.com>; Tue, 7 Mar 2000 11:43:20 -0800 (PST)
	mail_from (Harald.Koerfgen@home.ivm.de)
Received: from franz.no.dom (port207.duesseldorf.ivm.de [195.247.65.207])
	by mail.ivm.net (8.8.8/8.8.8) with ESMTP id UAA21172;
	Tue, 7 Mar 2000 20:42:56 +0100
X-To:   linux@cthulhu.engr.sgi.com
Message-ID: <XFMail.000307204343.Harald.Koerfgen@home.ivm.de>
X-Mailer: XFMail 1.4.0 on Linux
X-Priority: 3 (Normal)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
In-Reply-To: <Pine.LNX.3.96.1000307125403.13309E-100000@lithium>
Date:   Tue, 07 Mar 2000 20:43:43 +0100 (MET)
Reply-To: "Harald Koerfgen" <Harald.Koerfgen@home.ivm.de>
Organization: none
From:   Harald Koerfgen <Harald.Koerfgen@home.ivm.de>
To:     "Andrew R. Baker" <andrewb@uab.edu>
Subject: Re: FP emulation patch available
Cc:     linux-mips@vger.rutgers.edu, linux-mips@fnet.fr,
        Linux SGI <linux@cthulhu.engr.sgi.com>,
        "Gleb O. Raiko" <raiko@niisi.msk.ru>
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing


On 07-Mar-00 Andrew R. Baker wrote:
> 
> 
> On Tue, 7 Mar 2000, Gleb O. Raiko wrote:
>> "Bradley D. LaRonde" wrote:
>> > 
>> > I would jump right on this but I really need it for 2.3.47+.
>> > 
>> > Regards,
>> > Brad
>> 
>> I vote for 2.3 too. It seems 2.2 will vanish soon anyway.
> 
> Working on it.

Me too. Compiles and links but doesn't work. I guess the cpu detection doesn't
work properly for my Mobilon yet. I am actually compiling it for a DECstation
:-)

-- 
Regards,
Harald
