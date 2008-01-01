Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 01 Jan 2008 13:45:03 +0000 (GMT)
Received: from cantor.suse.de ([195.135.220.2]:53679 "EHLO mx1.suse.de")
	by ftp.linux-mips.org with ESMTP id S20029190AbYAANoz (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 1 Jan 2008 13:44:55 +0000
Received: from Relay2.suse.de (relay-ext.suse.de [195.135.221.8])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.suse.de (Postfix) with ESMTP id A8FDB260B1;
	Tue,  1 Jan 2008 14:44:49 +0100 (CET)
From:	Andreas Schwab <schwab@suse.de>
To:	Sam Ravnborg <sam@ravnborg.org>
Cc:	WANG Cong <xiyou.wangcong@gmail.com>,
	Ralf Baechle <ralf@linux-mips.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-kbuild@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
	linux-mips@linux-mips.org
Subject: Re: [Patch 2/8] MIPS: Remove 'TOPDIR' from Makefiles
References: <20080101071311.GA2496@hacking> <20080101072238.GC2496@hacking>
	<20080101101540.GB28913@uranus.ravnborg.org>
X-Yow:	BI-BI-BI-BI-BI-BI-BI-BI-BI-BI-BI-BI-BI-BI-BI-BI-BI-BI-BI-BI-BI-BI-BI-BI-BI-BI-
Date:	Tue, 01 Jan 2008 14:44:48 +0100
In-Reply-To: <20080101101540.GB28913@uranus.ravnborg.org> (Sam Ravnborg's
	message of "Tue\, 1 Jan 2008 11\:15\:40 +0100")
Message-ID: <jefxxhlkxb.fsf@sykes.suse.de>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/22.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-Path: <schwab@suse.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17903
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: schwab@suse.de
Precedence: bulk
X-list: linux-mips

Sam Ravnborg <sam@ravnborg.org> writes:

>> @@ -24,7 +24,7 @@ HEAD_DEFINES := -D_kernel_start=0x$(KERNEL_START) \
>>  		-D TIMESTAMP=$(shell date +%s)
>>  
>>  $(obj)/head.o: $(obj)/head.S $(KERNEL_IMAGE)
>> -	$(CC) -fno-pic $(HEAD_DEFINES) -I$(TOPDIR)/include -c -o $@ $<
>> +	$(CC) -fno-pic $(HEAD_DEFINES) -I$(objtree)/include -c -o $@ $<
> This has never worked with O=.. builds.
> The correct fix here is to use:
>> +	$(CC) -fno-pic $(HEAD_DEFINES) -Iinclude -Iinclude2 -c -o $@ $<
>
> The -Iinclude2 is only for O=... builds so to keep current
> behaviour removing $(TOPDIR)/ would do it.

Shouldn't that use $(LINUXINCLUDE), or $(KBUILD_CPPFLAGS)?

Andreas.

-- 
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE Linux Products GmbH, Maxfeldstraße 5, 90409 Nürnberg, Germany
PGP key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
