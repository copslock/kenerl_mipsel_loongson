Received:  by oss.sgi.com id <S305156AbQCHKEk>;
	Wed, 8 Mar 2000 02:04:40 -0800
Received: from pneumatic-tube.sgi.com ([204.94.214.22]:1796 "EHLO
        pneumatic-tube.sgi.com") by oss.sgi.com with ESMTP
	id <S305154AbQCHKEL>; Wed, 8 Mar 2000 02:04:11 -0800
Received: from nodin.corp.sgi.com (nodin.corp.sgi.com [192.26.51.193]) by pneumatic-tube.sgi.com (980327.SGI.8.8.8-aspam/980310.SGI-aspam) via ESMTP id CAA02564; Wed, 8 Mar 2000 02:07:27 -0800 (PST)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by nodin.corp.sgi.com (980427.SGI.8.8.8/980728.SGI.AUTOCF) via ESMTP id CAA14604; Wed, 8 Mar 2000 02:03:40 -0800 (PST)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id BAA71390
	for linux-list;
	Wed, 8 Mar 2000 01:47:31 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from deliverator.sgi.com (deliverator.sgi.com [150.166.91.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id BAA63510
	for <linux@cthulhu.engr.sgi.com>;
	Wed, 8 Mar 2000 01:47:28 -0800 (PST)
	mail_from (kevink@mips.com)
Received: from mx.mips.com (mx.mips.com [206.31.31.226]) by deliverator.sgi.com (980309.SGI.8.8.8-aspam-6.2/980310.SGI-aspam) via ESMTP id BAA24975
	for <linux@cthulhu.engr.sgi.com>; Wed, 8 Mar 2000 01:42:52 -0800 (PST)
	mail_from (kevink@mips.com)
Received: from newman.mips.com (newman [206.31.31.8])
	by mx.mips.com (8.9.3/8.9.0) with ESMTP id BAA23029;
	Wed, 8 Mar 2000 01:40:38 -0800 (PST)
Received: from satanas (satanas [192.168.236.12])
	by newman.mips.com (8.9.3/8.9.0) with SMTP id BAA27977;
	Wed, 8 Mar 2000 01:40:26 -0800 (PST)
Message-ID: <025701bf88e2$c648a7e0$0ceca8c0@satanas.mips.com>
From:   "Kevin D. Kissell" <kevink@mips.com>
To:     "Harald Koerfgen" <Harald.Koerfgen@home.ivm.de>,
        "Andrew R. Baker" <andrewb@uab.edu>
Cc:     <linux-mips@vger.rutgers.edu>, <linux-mips@fnet.fr>,
        "Linux SGI" <linux@cthulhu.engr.sgi.com>,
        "Gleb O. Raiko" <raiko@niisi.msk.ru>
Subject: Re: FP emulation patch available
Date:   Wed, 8 Mar 2000 10:43:23 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 4.72.3110.5
X-MimeOLE: Produced By Microsoft MimeOLE V4.72.3110.3
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing

Hearald Koerfgen wrote:
>
>On 07-Mar-00 Andrew R. Baker wrote:
>> 
>> 
>> On Tue, 7 Mar 2000, Gleb O. Raiko wrote:
>>> "Bradley D. LaRonde" wrote:
>>> > 
>>> > I would jump right on this but I really need it for 2.3.47+.
>>> > 
>>> > Regards,
>>> > Brad
>>> 
>>> I vote for 2.3 too. It seems 2.2 will vanish soon anyway.
>> 
>> Working on it.
>
>Me too. Compiles and links but doesn't work. I guess the cpu detection doesn't
>work properly for my Mobilon yet. I am actually compiling it for a DECstation
>:-)


It's odd - I'm on at least one of the mailing lists in question, but I missed
part of this thread yesterday - such as Bradley's message, and another
that must have come from someone (Dom?) at Algorithmics.  

Anyway, the my CPU detection would certainly not have worked for
a Mobilon.   But it ought to have worked for a DECstation.  What
CPU does it have?   In addition to the cpu_probe() routine itself,
arch/mips/kernel/cpu_probe.c contains a table that describes the
CPU's that are recognized, and in principle it "knows" all the CPUs
that were recognized by the old assembler code in head.S, plus
a couple more (R4300 and MIPS 4Kc/5Kc).   The problem may
be a CPU that is mis-identified, or it may be that the options in the
table associated with that CPU are incorrectly defined.  Please
let me know what CPU and "PrID" the system has.

            Regards,

            Kevin K.
