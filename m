Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 09 Oct 2003 19:42:29 +0100 (BST)
Received: from mx2.mips.com ([IPv6:::ffff:206.31.31.227]:38297 "EHLO
	mx2.mips.com") by linux-mips.org with ESMTP id <S8225618AbTJISl5>;
	Thu, 9 Oct 2003 19:41:57 +0100
Received: from newman.mips.com (ns-dmz [206.31.31.225])
	by mx2.mips.com (8.12.5/8.12.5) with ESMTP id h99IcndA014839;
	Thu, 9 Oct 2003 11:38:53 -0700 (PDT)
Received: from xchange.mips.com (xchange [192.168.20.31])
	by newman.mips.com (8.9.3/8.9.0) with ESMTP id LAA09463;
	Thu, 9 Oct 2003 11:42:56 -0700 (PDT)
Received: by xchange.mips.com with Internet Mail Service (5.5.2653.19)
	id <43ZYK49B>; Thu, 9 Oct 2003 11:38:39 -0700
Message-ID: <0C5F4C7A1E3ED51194E200508B2CE32A02264E57@xchange.mips.com>
From: "Mitchell, Earl" <earlm@mips.com>
To: "'Jun Sun'" <jsun@mvista.com>, Adeel Malik <AdeelM@avaznet.com>
Cc: linux-mips@linux-mips.org
Subject: RE: YAMON Source code modification
Date: Thu, 9 Oct 2003 11:38:34 -0700 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain
Return-Path: <earlm@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3403
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: earlm@mips.com
Precedence: bulk
X-list: linux-mips


The YAMON license agreement is here which
essentially says its GPL but read this anyway ... 

http://www.mips.com/LicenseMapper/Yamon_license

The YAMON source code is here ... 

http://www.mips.com/content/Products/SoftwareTools/yamon

Last time I read it the YAMON porting guide doc included
with this distribution was kinda weak. That is, it does
not explicitly tell you which files to change and so on
compared to something like Wind River's porting guide
for vxworks which is very explicit and detailed. But
hey vxworks is a commercial product and this is free code. ;-) 

If you've ported a boot loader before you know the
usual things you have to change (e.g. exception
handlers, memory map specific stuff, device drivers,
memory initialization, etc). The porting guide is not 
very explicit about which files each
of these items is located in. So last time I ported
YAMON I simply walked thru the code starting from
./yamon/arch/reset/bootvector/reset.S and modified 
what I needed to as I hit code that needed to change.
You'd end up doing this anyway for bringup debugging.
In most cases a LOT of code will be reusable because
YAMON detects what core you have etc. So the amount of 
code you need to add/change is dependent on how close your
target hardware is to what's already supported. 

There are other boot loaders available you can use
like U-boot, Redboot, PMON, etc. The knock on YAMON
is that its much bigger than these other loaders. That's because
guys who originally wrote it chose not to use 'ifdefs' 
and conditional compiles for all the variants. So you get 
code linked in for all the variations (even though that
code is not used) and it jumps to correct routines
depending on your architecture. Makes the maintenance
easier I guess. Not really meant to be used as a production
bootrom in products but is used for eval boards. 

-earlm


-----Original Message-----
From: Jun Sun [mailto:jsun@mvista.com]
Sent: Thursday, October 09, 2003 11:02 AM
To: Adeel Malik
Cc: linux-mips@linux-mips.org; jsun@mvista.com
Subject: Re: YAMON Source code modification


On Thu, Oct 09, 2003 at 03:46:19PM +0500, Adeel Malik wrote:
> We want to port and 'run' YAMON to our own MIPS-based Development Board.
Can
> someone tell me what changes are necessary in the YAMON source code so
that
> it works on our board ?.
> Regards,
> ADEEL MALIK,
>  

Actually is YAMON code freely available?  Can someone from MIPS confirm
that and perhaps point to the downloading place?  

Many people have asked me about this in the past ...

Jun
