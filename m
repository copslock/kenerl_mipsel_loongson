Received:  by oss.sgi.com id <S305159AbQCIUe7>;
	Thu, 9 Mar 2000 12:34:59 -0800
Received: from pneumatic-tube.sgi.com ([204.94.214.22]:2361 "EHLO
        pneumatic-tube.sgi.com") by oss.sgi.com with ESMTP
	id <S305154AbQCIUej>; Thu, 9 Mar 2000 12:34:39 -0800
Received: from nodin.corp.sgi.com (nodin.corp.sgi.com [192.26.51.193]) by pneumatic-tube.sgi.com (980327.SGI.8.8.8-aspam/980310.SGI-aspam) via ESMTP id MAA09710; Thu, 9 Mar 2000 12:37:50 -0800 (PST)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by nodin.corp.sgi.com (980427.SGI.8.8.8/980728.SGI.AUTOCF) via ESMTP id MAA42610; Thu, 9 Mar 2000 12:34:31 -0800 (PST)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id MAA22746
	for linux-list;
	Thu, 9 Mar 2000 12:20:05 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id MAA40408
	for <linux@cthulhu.engr.sgi.com>;
	Thu, 9 Mar 2000 12:20:02 -0800 (PST)
	mail_from (Harald.Koerfgen@home.ivm.de)
Received: from mail.ivm.net (mail.ivm.net [62.204.1.4]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id MAA09183
	for <linux@cthulhu.engr.sgi.com>; Thu, 9 Mar 2000 12:19:59 -0800 (PST)
	mail_from (Harald.Koerfgen@home.ivm.de)
Received: from franz.no.dom (port223.duesseldorf.ivm.de [195.247.65.223])
	by mail.ivm.net (8.8.8/8.8.8) with ESMTP id VAA19972;
	Thu, 9 Mar 2000 21:19:26 +0100
X-To:   linux@cthulhu.engr.sgi.com
Message-ID: <XFMail.000309212015.Harald.Koerfgen@home.ivm.de>
X-Mailer: XFMail 1.4.0 on Linux
X-Priority: 3 (Normal)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
In-Reply-To: <042401bf893a$b15465b0$0ceca8c0@satanas.mips.com>
Date:   Thu, 09 Mar 2000 21:20:15 +0100 (MET)
Reply-To: "Harald Koerfgen" <Harald.Koerfgen@home.ivm.de>
Organization: none
From:   Harald Koerfgen <Harald.Koerfgen@home.ivm.de>
To:     "Kevin D. Kissell" <kevink@mips.com>
Subject: Re: FP emulation patch available
Cc:     linux-mips@vger.rutgers.edu, linux-mips@fnet.fr,
        Linux SGI <linux@cthulhu.engr.sgi.com>
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing

Hi Kevin,

On 08-Mar-00 Kevin D. Kissell wrote:
[...]
> FWIW, the current version of the emulator presumably might not have
> paniced on you - I recently put the trampoline code on the user stack
> where it belongs, so it can execute in user mode.

Yes, but it would not have been so easy to find ;-)

> I haven't got around
> to mentioning it on the web page, but you can find the patch on
> ftp.paralogos.com in /pub/linux/mips/kernel with a fairly self-evident file
> name.

Thanks, Kevin. I'll have a look at it.

-- 
Regards,
Harald
