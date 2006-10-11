Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 11 Oct 2006 10:37:41 +0100 (BST)
Received: from nf-out-0910.google.com ([64.233.182.190]:57005 "EHLO
	nf-out-0910.google.com") by ftp.linux-mips.org with ESMTP
	id S20037576AbWJKJhk (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 11 Oct 2006 10:37:40 +0100
Received: by nf-out-0910.google.com with SMTP id a25so126037nfc
        for <linux-mips@linux-mips.org>; Wed, 11 Oct 2006 02:37:39 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:reply-to:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding:from;
        b=fTYRWNpLe6Lp9aRr4hiqSYRWu+qmpN1yCuCnRY8Mc+OYiWRLnyfwFYFmyqKWogNiKxak/SCVGx4oe/9qKkPQvYBsFse9pnInju4MVpJABNEaoOvviqrRDLRNdyoaBIjtBxU0vjJj8BrCWOzKuI80duabf8edt4zUzRtik54MiBY=
Received: by 10.48.48.18 with SMTP id v18mr2882268nfv;
        Wed, 11 Oct 2006 02:37:39 -0700 (PDT)
Received: from ?192.168.0.24? ( [81.252.61.1])
        by mx.google.com with ESMTP id l21sm3961388nfc.2006.10.11.02.37.38;
        Wed, 11 Oct 2006 02:37:38 -0700 (PDT)
Message-ID: <452CBB57.4050107@innova-card.com>
Date:	Wed, 11 Oct 2006 11:37:27 +0200
Reply-To: Franck <vagabon.xyz@gmail.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To:	Ralf Baechle <ralf@linux-mips.org>
CC:	Franck Bui-Huu <vagabon.xyz@gmail.com>,
	Atsushi Nemoto <anemo@mba.ocn.ne.jp>, ths@networkno.de,
	linux-mips@linux-mips.org
Subject: Re: [PATCH] setup.c: introduce __pa_symbol() and get ride of CPHYSADDR()
References: <452BA4E7.30901@innova-card.com> <20061010.231944.42203018.anemo@mba.ocn.ne.jp> <452BB5E1.5090308@innova-card.com> <20061011.002914.76462350.anemo@mba.ocn.ne.jp> <452BC4A5.3080706@innova-card.com> <20061010215124.GA21012@linux-mips.org>
In-Reply-To: <20061010215124.GA21012@linux-mips.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
From:	Franck Bui-Huu <vagabon.xyz@gmail.com>
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12897
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vagabon.xyz@gmail.com
Precedence: bulk
X-list: linux-mips

Ralf Baechle wrote:
> On Tue, Oct 10, 2006 at 06:04:53PM +0200, Franck Bui-Huu wrote:
> 
>> ok, and does the trick on KSEG0/XKPHYS really worth ? I mean what is
>> the size code gain ?
> 
> Gcc / gas generate a 6 instruction sequence to load something from a
> 64-bit address, basically lui, add, dsll16, add, dsll16, add.  It's
> just 2 instructions for 32-bit addresses.  This boils down to space
> savings in the hundred of kilobytes for a kernel.
> 

ok, the hack seems to worth it...

		Franck
