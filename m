Received:  by oss.sgi.com id <S305160AbQCNS1H>;
	Tue, 14 Mar 2000 10:27:07 -0800
Received: from deliverator.sgi.com ([204.94.214.10]:19776 "EHLO
        deliverator.sgi.com") by oss.sgi.com with ESMTP id <S305156AbQCNS0t>;
	Tue, 14 Mar 2000 10:26:49 -0800
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by deliverator.sgi.com (980309.SGI.8.8.8-aspam-6.2/980310.SGI-aspam) via ESMTP id KAA06489; Tue, 14 Mar 2000 10:22:12 -0800 (PST)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id KAA56437
	for linux-list;
	Tue, 14 Mar 2000 10:15:16 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id KAA35131
	for <linux@cthulhu.engr.sgi.com>;
	Tue, 14 Mar 2000 10:15:05 -0800 (PST)
	mail_from (Harald.Koerfgen@home.ivm.de)
Received: from mail.ivm.net (mail.ivm.net [62.204.1.4]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id KAA06191
	for <linux@cthulhu.engr.sgi.com>; Tue, 14 Mar 2000 10:15:02 -0800 (PST)
	mail_from (Harald.Koerfgen@home.ivm.de)
Received: from franz.no.dom (port80.duesseldorf.ivm.de [195.247.65.80])
	by mail.ivm.net (8.8.8/8.8.8) with ESMTP id TAA07588;
	Tue, 14 Mar 2000 19:14:36 +0100
X-To:   linux@cthulhu.engr.sgi.com
Message-ID: <XFMail.000314191529.Harald.Koerfgen@home.ivm.de>
X-Mailer: XFMail 1.4.0 on Linux
X-Priority: 3 (Normal)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
In-Reply-To: <2472.000314@praim.com>
Date:   Tue, 14 Mar 2000 19:15:29 +0100 (MET)
Reply-To: "Harald Koerfgen" <Harald.Koerfgen@home.ivm.de>
Organization: none
From:   Harald Koerfgen <Harald.Koerfgen@home.ivm.de>
To:     < (Andrea Endrizzi) andreae@praim.com>
Subject: RE: Help mips-tx39-elf-{tool}
Cc:     Andy <andy@wldorf-gmbh.de>, Cygnus Developers <rth@cygnus.com>,
        Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>,
        Dominic Sweetman <dom@algor.co.uk>,
        Linux SGI <linux@cthulhu.engr.sgi.com>,
        "linux-mips@vger.rutgers.edu" <linux-mips@vger.rutgers.edu>,
        "Kevin D. Kissel" <kevink@mips.com>,
        "linux-mips@fnet.f" <linux-mips@fnet.fr>
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing

Hi,

On 14-Mar-00 Andrea Endrizzi wrote:
>   Excuse me, i have found your address in my long search in Mips
>   Developers Group. I make my apologies if i have wrong the address.
> 
>   I use a TX3927 Board , i try to write some little program ( led on/off )
> and
>   work fine. I try to compile Mips Linux Kernel ( R3000 ) with mips-tx39-elf
>   compiler and i have some problem ...
> 
>   Is There anyone that have some experiences with Cygnus 98r2 for
>   Linux with target mips-tx39-elf-{tool} ???

No, not with that toolchain. Using the "standard" Linux/MIPS toolchain, on the
other hand, I have been able to make Linux running on my Sharp Mobilon
(PR31700/TX3912). See http://linux-vr.org for more details or feel free to ask
me directly.

-- 
Regards,
Harald
