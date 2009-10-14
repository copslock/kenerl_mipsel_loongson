Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 14 Oct 2009 03:06:35 +0200 (CEST)
Received: from qw-out-1920.google.com ([74.125.92.144]:16741 "EHLO
	qw-out-1920.google.com" rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org
	with ESMTP id S1493708AbZJNBG2 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 14 Oct 2009 03:06:28 +0200
Received: by qw-out-1920.google.com with SMTP id 5so2731053qwc.54
        for <multiple recipients>; Tue, 13 Oct 2009 18:06:25 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:reply-to:to:cc
         :in-reply-to:references:content-type:organization:date:message-id
         :mime-version:x-mailer:content-transfer-encoding;
        bh=LdHpNCBZOkFyFK+lrNheTYFGoEewgdfaMeaW74CL9dI=;
        b=ZrNnAdszgOfiGqVWsYvy7qQiIU1US4v/yT4VtiKGEeT9Dll8drm/f5ifpaKHPllBvV
         F0cxVVdGNFVAVJbAKv5dlo71kBvnitFB0Mb5qFV3yToN8R4Tzbx9b1eRQNjYqqpx43d5
         VtPl9kd2z2uSXtfG7ozyM8MKU8GiJq7hREGes=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:reply-to:to:cc:in-reply-to:references:content-type
         :organization:date:message-id:mime-version:x-mailer
         :content-transfer-encoding;
        b=kLrXOtxH7s8mRuEZli9NKLx2rlwKcCzu4JuX4ciQkJ2fvYzEPelHQwDlrEf4jGX0GQ
         jW3K72WYM0uhlzyL4GgNZDKf9/APdq287XAVTIwujO/1xrnwgMIFX2VFFVujFO7AXrib
         m6WdSa17e8u6SHfoVWNVhztfNkZyHfYZ7rYXY=
Received: by 10.224.102.194 with SMTP id h2mr6606634qao.96.1255482385134;
        Tue, 13 Oct 2009 18:06:25 -0700 (PDT)
Received: from ?172.16.2.101? ([222.92.8.142])
        by mx.google.com with ESMTPS id 4sm528571qwe.34.2009.10.13.18.06.19
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 13 Oct 2009 18:06:24 -0700 (PDT)
Subject: Re: [PATCH -v1] MIPS: fix pfn_valid() for FLATMEM
From:	Wu Zhangjin <wuzhangjin@gmail.com>
Reply-To: wuzhangjin@gmail.com
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	"Rafael J. Wysocki" <rjw@sisk.pl>, linux-mips@linux-mips.org,
	Sergei Shtylyov <sshtylyov@ru.mvista.com>,
	Pavel Machek <pavel@ucw.cz>
In-Reply-To: <20091013220417.GA32099@linux-mips.org>
References: <1255001548-30567-1-git-send-email-wuzhangjin@gmail.com>
	 <200910082221.12649.rjw@sisk.pl> <20091008204447.GA14560@linux-mips.org>
	 <1255054108.5810.74.camel@falcon> <1255104130.3658.122.camel@falcon>
	 <20091013220417.GA32099@linux-mips.org>
Content-Type: text/plain
Organization: DSLab, Lanzhou University, China
Date:	Wed, 14 Oct 2009 09:06:13 +0800
Message-Id: <1255482373.5610.14.camel@falcon>
Mime-Version: 1.0
X-Mailer: Evolution 2.26.1 
Content-Transfer-Encoding: 7bit
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24289
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

On Wed, 2009-10-14 at 00:04 +0200, Ralf Baechle wrote:
> On Sat, Oct 10, 2009 at 12:02:10AM +0800, Wu Zhangjin wrote:
> 
> > The above patch can not fix the problem when enabled FLATMEM in
> > linux-2.6.32-rc3, the real problem should be that we need register the
> > "pci memory space" as nosave pages, and also, the above "reserved"(not
> > memory) pages should be registered as nosave pages. but the simpler
> > solution should be the pfn_valid() I sent out in this E-mail thread, we
> > just need to check whether they are "valid", if they are "System
> > RAM"(BOOT_MEM_RAM or BOOT_MEM_ROM_DATA), they should be valid.
> > 
> > and what's more? should be register "pci memory space" as nosave pages
> > for all architecture?
> 
> No.  You only see this problem because your PCI memory space is between
> the lowest and the highest memory address.  Other systems don't have this
> issue because they either use the discontig or sparse memory models.
> 
> Btw, for systems that actually have memory in the 90000000-bfffffff range
> and are running a 64-bit kernel with 4k ages the flatmem memory model
> will waste 28MB of RAM; with 16k pages it's still 7MB.
> 
> Time to say gooebye to flatmem?

Okay, I will enable SPARSEMEM by default in the defconfig later.

Regards,
	Wu Zhangjin
