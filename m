Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 01 Feb 2007 16:00:55 +0000 (GMT)
Received: from qb-out-0506.google.com ([72.14.204.229]:20638 "EHLO
	qb-out-0506.google.com") by ftp.linux-mips.org with ESMTP
	id S20038951AbXBAQAv (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 1 Feb 2007 16:00:51 +0000
Received: by qb-out-0506.google.com with SMTP id e12so57305qba
        for <linux-mips@linux-mips.org>; Thu, 01 Feb 2007 07:59:50 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=CLdcfHwFCg+x8WpPOBm/F7ptKjybQFQ68I+WJBxTiRpNwCDrjb8Dx2heVe1ibXhrI0y7uacHL313AYLthdefEjRxiOtvhuHIQw4+5fyfotBXfDT3sdFoY0yQpYO6FQW4Mx2WK19yI9W3shb7MWBdaT3ze+Hg9iT6cI3cheknRlE=
Received: by 10.114.75.1 with SMTP id x1mr173064waa.1170345589383;
        Thu, 01 Feb 2007 07:59:49 -0800 (PST)
Received: by 10.114.134.16 with HTTP; Thu, 1 Feb 2007 07:59:49 -0800 (PST)
Message-ID: <cda58cb80702010759w505b4b8br44fb75be28cc8ff0@mail.gmail.com>
Date:	Thu, 1 Feb 2007 16:59:49 +0100
From:	"Franck Bui-Huu" <vagabon.xyz@gmail.com>
To:	"Maciej W. Rozycki" <macro@linux-mips.org>
Subject: Re: RFC: Sentosa boot fix
Cc:	"Atsushi Nemoto" <anemo@mba.ocn.ne.jp>, dan@debian.org,
	linux-mips@linux-mips.org, ralf@linux-mips.org
In-Reply-To: <Pine.LNX.4.64N.0702011233240.7161@blysk.ds.pg.gda.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <cda58cb80701290806p5d68ba5ck5e3e3b2b3490126f@mail.gmail.com>
	 <20070129161450.GA3384@nevyn.them.org>
	 <Pine.LNX.4.64N.0701291833480.26916@blysk.ds.pg.gda.pl>
	 <20070130.234537.126574565.anemo@mba.ocn.ne.jp>
	 <Pine.LNX.4.64N.0701301713350.9231@blysk.ds.pg.gda.pl>
	 <cda58cb80702010151x62e3b92ap18c63110f7fd4f0c@mail.gmail.com>
	 <Pine.LNX.4.64N.0702011233240.7161@blysk.ds.pg.gda.pl>
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13883
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vagabon.xyz@gmail.com
Precedence: bulk
X-list: linux-mips

Maciej W. Rozycki wrote:
> On Thu, 1 Feb 2007, Franck Bui-Huu wrote:
>
>>> Checking for code correctness and validation of the toolchain (Linux is
>>> one of the few non-PIC users of (n)64) without having to chase hardware
>>> that would support running from XPHYS without serious pain (the firmware
>>> being the usual offender).
>> This use case was unknown by the time we introduced __pa_page_offset().
>
>  Well, I am afraid it was known well before.  I introduced it first to 2.4

sorry I meant it wasn't for _me_.

>
>  It hurts performance a little bit, so if you can assure the macro shall

Well __pa() is only used in a few places. Futhermore it's used
only during boot mem init so it really shouldn't hurt.

>
>> BTW, maybe we can simply remove BUILD_ELF64 at all, since it's only
>> used to add '-msym32' switch in the makefile. This switch could be
>> automatically be added by the makefile instead thanks the following
>> condition:
>>
>> if CONFIG_64BITS and ${load-y} in CKSEG0
>>    cflags-y += -msym32
>> endif
>>
>> what do you think ?
>
>  I do not see enough of justification for -msym32 to be forced.
>

It gives good default behaviours without both user's intervention or
configuration:

	if CONFIG_64BITS
		ifndef sym32
			if load-y in XKPHYS
				sym32 = ''		[1]
			elif load-y in CKSEG0
				sym32 = '-msym32'	[2]
		else
			if sym32 eq 'yes'
				sym32 = '-msym32'	[3]
		endef
	fi
	cflags-y += $(sym32)

[1] since there is no reason to add '-msym32' and it would generate
    wrong code anyways.
[2] since it's used by all platforms to generate smaller code.
    Warn if this option is not supported by the tool chains.
[3] if you really want to generate code loaded in CKSEG0 without
    -msym32 switch you could always do:

		$ make sym32=no

    IMHO, for normal users, this case is probably a configuration
    bug and that's the reason we should request for a user to ask for
    it explicitly.

-- 
               Franck
