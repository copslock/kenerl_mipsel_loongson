Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 14 Jan 2003 23:34:44 +0000 (GMT)
Received: from rj.sgi.com ([IPv6:::ffff:192.82.208.96]:58815 "EHLO rj.sgi.com")
	by linux-mips.org with ESMTP id <S8225198AbTANXeo>;
	Tue, 14 Jan 2003 23:34:44 +0000
Received: from larry.melbourne.sgi.com (larry.melbourne.sgi.com [134.14.52.130])
	by rj.sgi.com (8.12.2/8.12.2/linux-outbound_gateway-1.2) with SMTP id h0ELYnG8008633;
	Tue, 14 Jan 2003 13:34:49 -0800
Received: from kao2.melbourne.sgi.com (kao2.melbourne.sgi.com [134.14.55.180]) by larry.melbourne.sgi.com (950413.SGI.8.6.12/950213.SGI.AUTOCF) via ESMTP id KAA14792; Wed, 15 Jan 2003 10:34:39 +1100
Received: by kao2.melbourne.sgi.com (Postfix, from userid 16331)
	id 71CA83000B8; Wed, 15 Jan 2003 10:34:38 +1100 (EST)
Received: from kao2.melbourne.sgi.com (localhost [127.0.0.1])
	by kao2.melbourne.sgi.com (Postfix) with ESMTP
	id 60D7585; Wed, 15 Jan 2003 10:34:38 +1100 (EST)
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: "Gilad Benjamini" <gilad@riverhead.com>
Cc: linux-mips@linux-mips.org
Subject: Re: insmod failure: "Unhandled relocation" errors 
In-reply-to: Your message of "Tue, 14 Jan 2003 12:06:46 +0200."
             <001801c2bbb4$a6177de0$7100000a@riverhead.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 15 Jan 2003 10:34:33 +1100
Message-ID: <9030.1042587273@kao2.melbourne.sgi.com>
Return-Path: <kaos@ocs.com.au>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1154
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kaos@ocs.com.au
Precedence: bulk
X-list: linux-mips

On Tue, 14 Jan 2003 12:06:46 +0200, 
"Gilad Benjamini" <gilad@riverhead.com> wrote:
>I've built,compiled and ran successfully a 64 bit kernel on my 
>mips64 platform. Kernel was compiled with support for 32 bit binaries.
>
>I am now trying to insert a module, a standard module from
>the kernel tree, and get lots of errors such as:
>"Unhandled relocation of type 18 for"

Type 18 is R_MIPS_64.  modutils does not support 64 bit mips
at all, nobody has sent me any code to handle this architecture.

modutils needs obj/obj_mips64.c.  The config and makefiles have to be
tweaked to handle mips64, including combined 32/64 bit code, as for
sparc32/sparc64.  Does anybody who knows mips64 feel like contributing
the modutils code?
