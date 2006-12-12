Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 12 Dec 2006 08:55:52 +0000 (GMT)
Received: from ug-out-1314.google.com ([66.249.92.171]:49983 "EHLO
	ug-out-1314.google.com") by ftp.linux-mips.org with ESMTP
	id S20037892AbWLLIzs (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 12 Dec 2006 08:55:48 +0000
Received: by ug-out-1314.google.com with SMTP id 40so1953865uga
        for <linux-mips@linux-mips.org>; Tue, 12 Dec 2006 00:55:47 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=QNvPQYQ07bVRHGzDxpH+1lBweBiEJZvrIawXhaAv0QW7LE6j64Miw7D2WljzngMmfbmteWpzPiZkCzQbu1CpXKSkDEL/qZpOj08hXQYj9hACZ/YIFDQePYP/981ng9/rUs10xevUMlxMl+gLSYmalWPSJf1Mjvjsd4HgDSBg1I8=
Received: by 10.78.21.7 with SMTP id 7mr156756huu.1165913746868;
        Tue, 12 Dec 2006 00:55:46 -0800 (PST)
Received: by 10.78.123.2 with HTTP; Tue, 12 Dec 2006 00:55:41 -0800 (PST)
Message-ID: <cda58cb80612120055j393dbf4bj1a3fe7a464f4a62d@mail.gmail.com>
Date:	Tue, 12 Dec 2006 09:55:41 +0100
From:	"Franck Bui-Huu" <vagabon.xyz@gmail.com>
To:	"Ralf Baechle" <ralf@linux-mips.org>
Subject: Re: [RFC] FLATMEM: allow memory to start at pfn != 0
Cc:	linux-mips@linux-mips.org
In-Reply-To: <20061211184640.GB1308@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <1165420110699-git-send-email-fbuihuu@gmail.com>
	 <20061211184640.GB1308@linux-mips.org>
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13432
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vagabon.xyz@gmail.com
Precedence: bulk
X-list: linux-mips

Hi Ralf,

On 12/11/06, Ralf Baechle <ralf@linux-mips.org> wrote:
> On Wed, Dec 06, 2006 at 04:48:27PM +0100, Franck Bui-Huu wrote:
>
> I just tested this on a Malta.  So patch 2/3 makes Malta die pretty
> spectacularly, so I'm going to remve patches 2/3 and 3/3 again from my
> tree.
>

Thanks for your review ! Could you give me some info about your config
to help me to find out the issue ? For example what's your value of
PHYS_OFFSET ? your memory mapping ?

> Btw, there's spelling mistake in 2/3:
>
> +               panic("Boggus memory mapping !!!");

I'll fix it by "Incorrect memory mapping !!!"

thanks
-- 
               Franck
