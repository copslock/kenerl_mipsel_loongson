Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 10 Oct 2006 17:03:47 +0100 (BST)
Received: from nf-out-0910.google.com ([64.233.182.186]:22750 "EHLO
	nf-out-0910.google.com") by ftp.linux-mips.org with ESMTP
	id S20039901AbWJJQDp (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 10 Oct 2006 17:03:45 +0100
Received: by nf-out-0910.google.com with SMTP id n29so314981nfc
        for <linux-mips@linux-mips.org>; Tue, 10 Oct 2006 09:03:41 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:reply-to:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding:from;
        b=CGausiY5C/7iUQAHxB2Ck0egOHDQDbCcYiFIbDkrcgMB4iCzIbYHIAm7BMNmcKIX2GN5VCZcqYYx6+vq/X6YtBv3VxfEadJUdLsGOZ9EW7CxhQxqVhtKXDXz4ebymf1YMTj9uPss3gVREMuGQzIAR2TlEq/y5r8kZ7alon3MFog=
Received: by 10.49.8.4 with SMTP id l4mr1618044nfi;
        Tue, 10 Oct 2006 09:03:41 -0700 (PDT)
Received: from ?192.168.0.24? ( [81.252.61.1])
        by mx.google.com with ESMTP id z73sm2202993nfb.2006.10.10.09.03.40;
        Tue, 10 Oct 2006 09:03:40 -0700 (PDT)
Message-ID: <452BC4A5.3080706@innova-card.com>
Date:	Tue, 10 Oct 2006 18:04:53 +0200
Reply-To: Franck <vagabon.xyz@gmail.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
CC:	vagabon.xyz@gmail.com, ths@networkno.de, ralf@linux-mips.org,
	linux-mips@linux-mips.org
Subject: Re: [PATCH] setup.c: introduce __pa_symbol() and get ride of CPHYSADDR()
References: <452BA4E7.30901@innova-card.com>	<20061010.231944.42203018.anemo@mba.ocn.ne.jp>	<452BB5E1.5090308@innova-card.com> <20061011.002914.76462350.anemo@mba.ocn.ne.jp>
In-Reply-To: <20061011.002914.76462350.anemo@mba.ocn.ne.jp>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From:	Franck Bui-Huu <vagabon.xyz@gmail.com>
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12874
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vagabon.xyz@gmail.com
Precedence: bulk
X-list: linux-mips

Atsushi Nemoto wrote:
> On Tue, 10 Oct 2006 17:01:53 +0200, Franck Bui-Huu <vagabon.xyz@gmail.com> wrote:
>>> I think this peice of code is just broken, as you said.  This is bogus
>>> but harmless since we have not checked these resources are
>>> successfully registered or not.
>> what about all other uses of virt_to_phys(x) ? And what the point to set
>> PAGE_OFFSET to 0xa800000000000000 ? I'm really confused...
> 
> For now I have not seen any problem on other usages.
> 

do you know at which point the kernel starts to use XKPHYS addresses ?

> We can use large flat mapping space in XKPHYS.  No TLB conversion, no
> highmem trick.
> 

ok, and does the trick on KSEG0/XKPHYS really worth ? I mean what is
the size code gain ?

Thanks
		Franck
