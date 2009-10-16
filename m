Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 16 Oct 2009 12:43:35 +0200 (CEST)
Received: from mail-yx0-f204.google.com ([209.85.210.204]:34557 "EHLO
	mail-yx0-f204.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1493567AbZJPKn2 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 16 Oct 2009 12:43:28 +0200
Received: by yxe42 with SMTP id 42so1685362yxe.22
        for <multiple recipients>; Fri, 16 Oct 2009 03:43:20 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=D72b1dgqmtS+vGA2HW/TAWOB7JJV43GsEFTqXjsCJzg=;
        b=bLUu1L9EEVTZ+1Zj5djjPqZ9xIT60VNiNYYfHNDuhA4foue7hg9JYqeZmrVRY+grVO
         srJ2w1tal7TMwXXP5ODlcbdcpaifx1A4TLCnvGVn6TwUciUubfEAen3oHnJesmPW+1O3
         pGDTHHl+5KKeixhSCAmkFwn2Tt3yHxPEaB4b8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=EyK5gybDF6cNb8G3j5JFjOtOycww8HZHPA/DQeAj5Z5QUfKJuZ/NycQBf9Nd5QOiS0
         uSSICkUUao3uFU4VVuiYm3yqErw7Xti0+PJ6ZkAFCS7mJuHsDEcP9rEpk24yCfo0u4iM
         PwxLdNFZSRjlX6v2yME8aAkQRHojzX9V03c8A=
MIME-Version: 1.0
Received: by 10.150.183.11 with SMTP id g11mr2457606ybf.50.1255689800896; Fri, 
	16 Oct 2009 03:43:20 -0700 (PDT)
In-Reply-To: <20091016092418.GA3686@linux-mips.org>
References: <20091016141719.de606482.minchan.kim@barrios-desktop>
	 <20091016092418.GA3686@linux-mips.org>
Date:	Fri, 16 Oct 2009 19:43:20 +0900
Message-ID: <28c262360910160343m1cf8bbf3g527085f29e0ae868@mail.gmail.com>
Subject: Re: BUG? linux-mips flush_dcache_page
From:	Minchan Kim <minchan.kim@gmail.com>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>,
	lkml <linux-kernel@vger.kernel.org>,
	linux-mips <linux-mips@linux-mips.org>,
	Chungki woo <chungki.woo@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Return-Path: <minchan.kim@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24363
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: minchan.kim@gmail.com
Precedence: bulk
X-list: linux-mips

On Fri, Oct 16, 2009 at 6:24 PM, Ralf Baechle <ralf@linux-mips.org> wrote:
> On Fri, Oct 16, 2009 at 02:17:19PM +0900, Minchan Kim wrote:
>
>> Many code of kernel fs usually allocate high page and flush.
>> But flush_dcache_page of mips checks PageHighMem to avoid flush
>> so that data consistency is broken, I think.
>
> What processor and cache configuration?

Chungki. Could you anwer this question ?

>> I found it's by you and Atsushi-san on 585fa724.
>> Why do we need the check?
>> Could you elaborte please?
>
> The if statement exists because __flush_dcache_page would crash if a page
> is not mapped.  This of course isn't correct but that wasn't a problem
> since highmem still is only supported on machines that don't have aliases.

Thansk for good explanation.
Chungki. Please let us know your machine(processor and cache configuration)

>
>  Ralf
>



-- 
Kind regards,
Minchan Kim
