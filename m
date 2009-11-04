Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 04 Nov 2009 12:36:20 +0100 (CET)
Received: from mx1.moondrake.net ([212.85.150.166]:37399 "EHLO
	mx1.mandriva.com" rhost-flags-OK-OK-OK-FAIL) by ftp.linux-mips.org
	with ESMTP id S1493191AbZKDLgL (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 4 Nov 2009 12:36:11 +0100
Received: by mx1.mandriva.com (Postfix, from userid 501)
	id A5709274004; Wed,  4 Nov 2009 12:36:10 +0100 (CET)
Received: from office-abk.mandriva.com (unknown [195.7.104.248])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.mandriva.com (Postfix) with ESMTP id 1C119274003;
	Wed,  4 Nov 2009 12:36:09 +0100 (CET)
Received: from anduin.mandriva.com (fw2.mandriva.com [192.168.2.3])
	by office-abk.mandriva.com (Postfix) with ESMTP id AFAE382919;
	Wed,  4 Nov 2009 12:47:36 +0100 (CET)
Received: from anduin.mandriva.com (localhost [127.0.0.1])
	by anduin.mandriva.com (Postfix) with ESMTP id B5170FF855;
	Wed,  4 Nov 2009 12:36:23 +0100 (CET)
From:	Arnaud Patard <apatard@mandriva.com>
To:	wuzhangjin@gmail.com
Cc:	Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
	LKML <linux-kernel@vger.kernel.org>, huhb@lemote.com,
	yanh@lemote.com, Zhang Le <r0bertz@gentoo.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Nicholas Mc Guire <der.herr@hofr.at>, zhangfx@lemote.com,
	liujl@lemote.com
Subject: Re: [PATCH -queue v0 1/6] [loongson] add basic loongson-2f support
References: <cover.1257325319.git.wuzhangjin@gmail.com>
	<a1bd2470bc465e505281c761adca8c2287d102b3.1257325319.git.wuzhangjin@gmail.com>
	<m3iqdqtwgk.fsf@anduin.mandriva.com>
	<1257332652.8716.5.camel@falcon.domain.org>
Organization: Mandriva
Date:	Wed, 04 Nov 2009 12:36:23 +0100
In-Reply-To: <1257332652.8716.5.camel@falcon.domain.org> (Wu Zhangjin's message of "Wed, 04 Nov 2009 19:04:12 +0800")
Message-ID: <m3639qttc8.fsf@anduin.mandriva.com>
User-Agent: Gnus/5.1008 (Gnus v5.10.8) Emacs/22.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-Path: <arnaud.patard@mandriva.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24672
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: apatard@mandriva.com
Precedence: bulk
X-list: linux-mips

Wu Zhangjin <wuzhangjin@gmail.com> writes:

> Hi,
>
> On Wed, 2009-11-04 at 11:28 +0100, Arnaud Patard wrote:
> [...]
>> > +
>> > +config CPU_LOONGSON2F
>> > +	bool "Loongson 2F"
>> > +	depends on SYS_HAS_CPU_LOONGSON2F
>> > +	select CPU_LOONGSON2
>> > +	help
>> > +	  The Loongson 2F processor implements the MIPS III instruction set
>> > +	  with many extensions.
>> > +
>> > +	  Loongson2F have built-in DDR2 and PCIX controller. The PCIX controller
>> > +	  have a similar programming interface with FPGA northbridge used in
>> > +	  Loongson2E.
>> > +
>> 
>> Small question : Why don't you restrict to 64bit kernels only ? From
>> what I remember from some discussions with ST, trying to use a 32-bit
>> kernel on 2f is a nice way to get troubles. It would be better imho to
>> forbid such a configuration. As a side effect, this will remove all
>> 'defined(CONFIG_64BIT)' parts of your #ifdef tests. 
>> 
>
> It's hard to make such a decision ;) Perhaps some guys want to play with
> the 32bit version.

It's a matter of taste : using 32 bit and getting an more or less broken
machine or using 64bit and getting a working machine. I don't think a
lot of people will choose the first option :)

Arnaud
