Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 08 Jul 2006 17:16:05 +0100 (BST)
Received: from ug-out-1314.google.com ([66.249.92.170]:25482 "EHLO
	ug-out-1314.google.com") by ftp.linux-mips.org with ESMTP
	id S8133553AbWGHQPx (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sat, 8 Jul 2006 17:15:53 +0100
Received: by ug-out-1314.google.com with SMTP id k3so2926443ugf
        for <linux-mips@linux-mips.org>; Sat, 08 Jul 2006 09:15:52 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ATGvwD8yCwQCsxfJhUohckISBKuYuD+QkLZCGBDuduxphHE5FkQIkLiR2vlAerPSFeuGKGIe16cZfkwYR62U7iprL4c9lFoScfGY4jwHs3H1nZsuMBV6f2Ezoq/q4HgbE7NijUjfwsy26WDTB20GaZxhr5ivaSArb8M98mnlGag=
Received: by 10.66.243.2 with SMTP id q2mr3168053ugh;
        Sat, 08 Jul 2006 09:15:52 -0700 (PDT)
Received: by 10.67.100.10 with HTTP; Sat, 8 Jul 2006 09:15:52 -0700 (PDT)
Message-ID: <cda58cb80607080915h59f2fcc0yff605fb4afdf1b8b@mail.gmail.com>
Date:	Sat, 8 Jul 2006 18:15:52 +0200
From:	"Franck Bui-Huu" <vagabon.xyz@gmail.com>
To:	"Atsushi Nemoto" <anemo@mba.ocn.ne.jp>
Subject: Re: [PATCH] do not count pages in holes with sparsemem
Cc:	linux-mips@linux-mips.org, ralf@linux-mips.org
In-Reply-To: <20060709.010316.126574153.anemo@mba.ocn.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <cda58cb80607060805yc656114p53516b904188c20f@mail.gmail.com>
	 <20060707.002602.75184460.anemo@mba.ocn.ne.jp>
	 <cda58cb80607080739i772d439dqc4e06a8b275e03ee@mail.gmail.com>
	 <20060709.010316.126574153.anemo@mba.ocn.ne.jp>
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11947
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vagabon.xyz@gmail.com
Precedence: bulk
X-list: linux-mips

2006/7/8, Atsushi Nemoto <anemo@mba.ocn.ne.jp>:
> On Sat, 8 Jul 2006 16:39:44 +0200, "Franck Bui-Huu" <vagabon.xyz@gmail.com> wrote:
> > Did you check that show_mem() still works ? I'm not sure about that point.
>
> It should work, but this patch would make the output a bit better.
>

well I would say without this patch it should break.

'pfn' takes values between 0 and max_mapnr. This range includes memory
holes, doens't it ? In that case what does
pfn_to_page(pfn_inside_a_hole) ?

-- 
               Franck
