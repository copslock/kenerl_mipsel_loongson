Received:  by oss.sgi.com id <S305167AbQDDTms>;
	Tue, 4 Apr 2000 12:42:48 -0700
Received: from pneumatic-tube.sgi.com ([204.94.214.22]:20253 "EHLO
        pneumatic-tube.sgi.com") by oss.sgi.com with ESMTP
	id <S305166AbQDDTm3>; Tue, 4 Apr 2000 12:42:29 -0700
Received: from nodin.corp.sgi.com (fddi-nodin.corp.sgi.com [198.29.75.193]) by pneumatic-tube.sgi.com (980327.SGI.8.8.8-aspam/980310.SGI-aspam) via ESMTP id MAA01857; Tue, 4 Apr 2000 12:46:14 -0700 (PDT)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by nodin.corp.sgi.com (980427.SGI.8.8.8/980728.SGI.AUTOCF) via ESMTP id MAA08727; Tue, 4 Apr 2000 12:42:27 -0700 (PDT)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id MAA98541
	for linux-list;
	Tue, 4 Apr 2000 12:32:45 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id MAA34369
	for <linux@cthulhu.engr.sgi.com>;
	Tue, 4 Apr 2000 12:32:43 -0700 (PDT)
	mail_from (flo@rfc822.org)
Received: from noose.gt.owl.de (noose.gt.owl.de [62.52.19.4]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id MAA00843
	for <linux@cthulhu.engr.sgi.com>; Tue, 4 Apr 2000 12:32:41 -0700 (PDT)
	mail_from (flo@rfc822.org)
Received: by noose.gt.owl.de (Postfix, from userid 10)
	id 8344A7F9; Tue,  4 Apr 2000 21:32:41 +0200 (CEST)
Received: by paradigm.rfc822.org (Postfix, from userid 1000)
	id A4F598FC3; Tue,  4 Apr 2000 21:11:17 +0200 (CEST)
Date:   Tue, 4 Apr 2000 21:11:17 +0200
From:   Florian Lohoff <flo@rfc822.org>
To:     Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Cc:     linux@cthulhu.engr.sgi.com
Subject: Re: kernel hang indigo2 current cvs more specific
Message-ID: <20000404211117.C1517@paradigm.rfc822.org>
References: <20000404102252.B276@paradigm.rfc822.org> <Pine.GSO.4.10.10004041057310.24463-100000@dandelion.sonytel.be> <20000404210257.A1517@paradigm.rfc822.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.3i
In-Reply-To: <20000404210257.A1517@paradigm.rfc822.org>; from Florian Lohoff on Tue, Apr 04, 2000 at 09:02:57PM +0200
Organization: rfc822 - pure communication
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing

On Tue, Apr 04, 2000 at 09:02:57PM +0200, Florian Lohoff wrote:
> in the arch/mips/sgi/kernel/ directory ? Could it be that this structure
> is new and has never been implemented for the IP22 ?
> 
> Yep - Thats it - In 2.3.21 this init_bootmem thing doesnt exists - And though
> dec hasnt got it - In 2.3.99pre3 the dec has it - But not the sgi *grrrrr*

Ops - Better look around before writing mails - arc ... 

Flo
-- 
Florian Lohoff		flo@rfc822.org		      	+49-5241-470566
"Technology is a constant battle between manufacturers producing bigger and
more idiot-proof systems and nature producing bigger and better idiots."
