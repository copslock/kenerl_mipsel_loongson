Received:  by oss.sgi.com id <S42207AbQJLC2L>;
	Wed, 11 Oct 2000 19:28:11 -0700
Received: from pneumatic-tube.sgi.com ([204.94.214.22]:41798 "EHLO
        pneumatic-tube.sgi.com") by oss.sgi.com with ESMTP
	id <S42180AbQJLC1c>; Wed, 11 Oct 2000 19:27:32 -0700
Received: from larry.melbourne.sgi.com (larry.melbourne.sgi.com [134.14.52.130]) by pneumatic-tube.sgi.com (980327.SGI.8.8.8-aspam/980310.SGI-aspam) via SMTP id TAA03506; Wed, 11 Oct 2000 19:34:00 -0700 (PDT)
	mail_from (kaos@melbourne.sgi.com)
Received: from kao2.melbourne.sgi.com (kao2.melbourne.sgi.com [134.14.55.180]) by larry.melbourne.sgi.com (950413.SGI.8.6.12/950213.SGI.AUTOCF) via ESMTP id NAA20942; Thu, 12 Oct 2000 13:25:31 +1100
X-Mailer: exmh version 2.1.1 10/15/1999
From:   Keith Owens <kaos@melbourne.sgi.com>
To:     Ralf Baechle <ralf@oss.sgi.com>
cc:     Cort Dougan <cort@fsmlabs.com>, linux-mips@oss.sgi.com,
        linux-mips@fnet.fr, Ralf Baechle <ralf@uni-koblenz.de>
Subject: Re: modutils bug? 'if' clause executes incorrectly 
In-reply-to: Your message of "Wed, 11 Oct 2000 17:14:49 +0200."
             <20001011171449.A19344@bacchus.dhis.org> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date:   Thu, 12 Oct 2000 13:25:31 +1100
Message-ID: <3897.971317531@kao2.melbourne.sgi.com>
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Wed, 11 Oct 2000 17:14:49 +0200, 
Ralf Baechle <ralf@oss.sgi.com> wrote:
>For such occassions I would like to see some debugging functionality in
>modutils which allows dumping the relocated disk image as it would be
>loaded into the kernel into a disk image which then could be examined
>with objdump etc. for potencial problems.

By the time insmod has finished with the module, the rest is a binary
blob.  No ELF headers, no symbols, all the sections run together with a
struct module at the start.  I can dump that easily enough but I
question how much use it would be.  Outputing anything more complicated
such as ELF headers and symbols would be a significant addition to
insmod.
