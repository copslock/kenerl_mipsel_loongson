Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 19 Oct 2006 08:29:46 +0100 (BST)
Received: from nf-out-0910.google.com ([64.233.182.185]:8333 "EHLO
	nf-out-0910.google.com") by ftp.linux-mips.org with ESMTP
	id S20027700AbWJSH3o (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 19 Oct 2006 08:29:44 +0100
Received: by nf-out-0910.google.com with SMTP id l23so963237nfc
        for <linux-mips@linux-mips.org>; Thu, 19 Oct 2006 00:29:44 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:reply-to:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding:from;
        b=MgFovNKqaH7tIP3pJakx+PwB+vudLeyz64aFVUsHyiVRq2IsQAravvv1Wb+ZQJwY/8+bbiZQF5NOc0914W9DBsjpZgV6m+Pzi+nNlfs+lBjGNyXDnDn0LcoPyrus+4BZE5Sa49R9QU0q8pNwXrN+/eXpXHD9ttVlWeoduhQxPMI=
Received: by 10.49.8.10 with SMTP id l10mr5304694nfi;
        Thu, 19 Oct 2006 00:29:44 -0700 (PDT)
Received: from ?192.168.0.24? ( [81.252.61.1])
        by mx.google.com with ESMTP id v20sm330759nfc.2006.10.19.00.29.43;
        Thu, 19 Oct 2006 00:29:43 -0700 (PDT)
Message-ID: <4537296C.50702@innova-card.com>
Date:	Thu, 19 Oct 2006 09:29:48 +0200
Reply-To: Franck <vagabon.xyz@gmail.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
CC:	vagabon.xyz@gmail.com, ralf@linux-mips.org, ths@networkno.de,
	linux-mips@linux-mips.org
Subject: Re: [PATCH 6/7] setup.c: clean up initrd related code
References: <1160743146503-git-send-email-fbuihuu@gmail.com>	<20061019.131352.41630930.nemoto@toshiba-tops.co.jp>	<cda58cb80610182337h611f1cf0vd489b5828dfd269f@mail.gmail.com> <20061019.155124.96684956.nemoto@toshiba-tops.co.jp>
In-Reply-To: <20061019.155124.96684956.nemoto@toshiba-tops.co.jp>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
From:	Franck Bui-Huu <vagabon.xyz@gmail.com>
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13012
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vagabon.xyz@gmail.com
Precedence: bulk
X-list: linux-mips

Atsushi Nemoto wrote:
> On Thu, 19 Oct 2006 08:37:32 +0200, "Franck Bui-Huu" <vagabon.xyz@gmail.com> wrote:
>> I would rather move this fix into initrd start setup function as it
>> was done by old code. We know that some bootloaders forget sign
>> extension on 64 bits kernel. But if for example the sign extension is
>> forgotten by a board specific code, we shouldn't automatically fix the
>> mistake, but rather fix the board specific code. So I would do instead
>> of your fix:
> 
> But we need sign extension for values comes from the initrd_header
> anyway.  The initrd_header is fixed-size and can not hold 64-bit
> address.
> 

initrd_header gives only 2 numbers: size of initrd, and a magic number,
well it's what I understood when rewriting the code.

the start address of initrd is given by:

	initrd_header = __va(PAGE_ALIGN(__pa_symbol(&_end) + 8)) - 8;
	initrd_start = (unsigned long)&initrd_header[2];

I don't think we need any sign extension here, do we ?

		Franck
