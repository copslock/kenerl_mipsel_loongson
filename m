Received:  by oss.sgi.com id <S305161AbQCMVTs>;
	Mon, 13 Mar 2000 13:19:48 -0800
Received: from deliverator.sgi.com ([204.94.214.10]:37174 "EHLO
        deliverator.sgi.com") by oss.sgi.com with ESMTP id <S305156AbQCMVTa>;
	Mon, 13 Mar 2000 13:19:30 -0800
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by deliverator.sgi.com (980309.SGI.8.8.8-aspam-6.2/980310.SGI-aspam) via ESMTP id NAA09135; Mon, 13 Mar 2000 13:14:53 -0800 (PST)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id NAA93574
	for linux-list;
	Mon, 13 Mar 2000 13:10:27 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id NAA13209
	for <linux@cthulhu.engr.sgi.com>;
	Mon, 13 Mar 2000 13:09:39 -0800 (PST)
	mail_from (Harald.Koerfgen@home.ivm.de)
Received: from mail.ivm.net (mail.ivm.net [62.204.1.4]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id MAB05857
	for <linux@cthulhu.engr.sgi.com>; Mon, 13 Mar 2000 12:36:46 -0800 (PST)
	mail_from (Harald.Koerfgen@home.ivm.de)
Received: from franz.no.dom (port38.duesseldorf.ivm.de [195.247.65.38])
	by mail.ivm.net (8.8.8/8.8.8) with ESMTP id UAA21564;
	Mon, 13 Mar 2000 20:04:54 +0100
X-To:   kevink@mips.com
Message-ID: <XFMail.000313200547.Harald.Koerfgen@home.ivm.de>
X-Mailer: XFMail 1.4.0 on Linux
X-Priority: 3 (Normal)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
In-Reply-To: <E12UVAr-0007rR-00@the-village.bc.nu>
Date:   Mon, 13 Mar 2000 20:05:47 +0100 (MET)
Reply-To: "Harald Koerfgen" <Harald.Koerfgen@home.ivm.de>
Organization: none
From:   Harald Koerfgen <Harald.Koerfgen@home.ivm.de>
To:     Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: FP emulation patch available
Cc:     < (Linux SGI) linux@cthulhu.engr.sgi.com>, linux-mips@fnet.fr,
        linux-mips@vger.rutgers.edu, < (Kevin D. Kissell) kevink@mips.com>
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing


On 13-Mar-00 Alan Cox wrote:
>> Does anyone out there actually need/want an SMP
>> version of the emulator?   It's not completely trivial,
>> but it would not be all that difficult to do...
> 
> If you dont do it please add
> 
>#ifdef CONFIG_SMP
>#error "Not on this emulator"
>#endif
> 
> to the emu code - for the person who didnt know 8)

harry:~ > grep CONFIG_SMP linux/arch/mips/config.in
harry:~ > grep CONFIG_SMP linux/arch/mips64/config.in
   bool '  Multi-Processing support (Experimental)' CONFIG_SMP

SCNR :-).
-- 
Regards,
Harald
