Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 17 Dec 2002 02:25:56 +0000 (GMT)
Received: from rj.SGI.COM ([IPv6:::ffff:192.82.208.96]:65214 "EHLO rj.sgi.com")
	by linux-mips.org with ESMTP id <S8225256AbSLQCZz>;
	Tue, 17 Dec 2002 02:25:55 +0000
Received: from larry.melbourne.sgi.com (larry.melbourne.sgi.com [134.14.52.130])
	by rj.sgi.com (8.12.2/8.12.2/linux-outbound_gateway-1.2) with SMTP id gBH0PnG8032176;
	Mon, 16 Dec 2002 16:25:49 -0800
Received: from kao2.melbourne.sgi.com (kao2.melbourne.sgi.com [134.14.55.180]) by larry.melbourne.sgi.com (950413.SGI.8.6.12/950213.SGI.AUTOCF) via ESMTP id NAA07390; Tue, 17 Dec 2002 13:25:41 +1100
Received: by kao2.melbourne.sgi.com (Postfix, from userid 16331)
	id 7DE773000B8; Tue, 17 Dec 2002 13:25:40 +1100 (EST)
Received: from kao2.melbourne.sgi.com (localhost [127.0.0.1])
	by kao2.melbourne.sgi.com (Postfix) with ESMTP
	id 3F12D85; Tue, 17 Dec 2002 13:25:40 +1100 (EST)
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Jun Sun <jsun@mvista.com>
Cc: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>,
	linux-mips@linux-mips.org
Subject: Re: IDE module problem 
In-reply-to: Your message of "Mon, 16 Dec 2002 18:20:50 -0800."
             <20021216182050.D11575@mvista.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 17 Dec 2002 13:25:35 +1100
Message-ID: <24616.1040091935@kao2.melbourne.sgi.com>
Return-Path: <kaos@ocs.com.au>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 900
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kaos@ocs.com.au
Precedence: bulk
X-list: linux-mips

On Mon, 16 Dec 2002 18:20:50 -0800, 
Jun Sun <jsun@mvista.com> wrote:
>On Thu, Dec 12, 2002 at 01:56:37PM +1100, Keith Owens wrote:
>> obj-$(subst m,y,$(CONFIG_IDE)) += ide-std.o ide-no.o
>
>This is the most clean solution so far.  Anybody would object
>this change?
>
>See the attached patch.

Add a comment to the end of the line, any nonstandard build entries
should have comments :)

obj-$(subst m,y,$(CONFIG_IDE))	+= ide-std.o ide-no.o	# must be builtin if ide is builtin or a module
