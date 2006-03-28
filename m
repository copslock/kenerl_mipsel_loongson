Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 28 Mar 2006 19:59:10 +0100 (BST)
Received: from w099.z064220152.sjc-ca.dsl.cnc.net ([64.220.152.99]:7634 "EHLO
	duck.specifix.com") by ftp.linux-mips.org with ESMTP
	id S8133559AbWC1S7A (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 28 Mar 2006 19:59:00 +0100
Received: from [127.0.0.1] (duck.corp.specifix.com [192.168.1.1])
	by duck.specifix.com (Postfix) with ESMTP
	id E34E7FA8B; Tue, 28 Mar 2006 11:09:22 -0800 (PST)
Subject: Re: compilation problem with kernel 2.6.15
From:	James E Wilson <wilson@specifix.com>
To:	dhunjukrishna@gmail.com
Cc:	linux-mips@linux-mips.org
In-Reply-To: <20060328143708.57991.qmail@web53507.mail.yahoo.com>
References: <20060328143708.57991.qmail@web53507.mail.yahoo.com>
Content-Type: text/plain; charset=UTF-8
Message-Id: <1143572962.13954.8.camel@aretha.corp.specifix.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date:	Tue, 28 Mar 2006 11:09:22 -0800
Content-Transfer-Encoding: 8bit
Return-Path: <wilson@specifix.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10964
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wilson@specifix.com
Precedence: bulk
X-list: linux-mips

On Tue, 2006-03-28 at 06:37, Krishna wrote:
>  err
> or: read-only variable ΓÇÿ__gu_valΓÇÖ used as ΓÇÿasmΓÇÖ output

This means a new error check in gcc has found a latent kernel bug.

It is also sometimes the case that a new linux kernel finds a latent gcc
bug.

Note, in general, key parts of linux such as the kernel, glibc, and gcc,
often have such heavy dependencies on each other that you can not pick
and choose random versions.  If you want to use a particular kernel
version, then there are often particular glibc and gcc versions you
should use with it, otherwise you are likely to run into trouble.

This link:
    http://www.linux-mips.org/wiki/Toolchains#Prologue
recommends gcc-3.4.  And if you follow the "recommended" link to
    http://www.linux-mips.org/wiki/GCC
it specifically recommends against use of gcc-4.1 for compiling the
linux kernel, as this hasn't been well tested yet.
-- 
Jim Wilson, GNU Tools Support, http://www.specifix.com
