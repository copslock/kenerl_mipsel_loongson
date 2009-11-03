Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 03 Nov 2009 02:21:17 +0100 (CET)
Received: from mail-yw0-f173.google.com ([209.85.211.173]:38813 "EHLO
	mail-yw0-f173.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1493982AbZKCBVL (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 3 Nov 2009 02:21:11 +0100
Received: by ywh3 with SMTP id 3so5662464ywh.22
        for <multiple recipients>; Mon, 02 Nov 2009 17:21:05 -0800 (PST)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:reply-to:to:cc
         :in-reply-to:references:content-type:organization:date:message-id
         :mime-version:x-mailer:content-transfer-encoding;
        bh=box99AfvoufQLyU7WnJ8/mJaH9HuYvEd5Rg7XsHs5nY=;
        b=K8rvN/F8QdiH9N1EqI4EpYBd9UneoaZ2rymv6GjmyadmH94lpWNTyycdeJVm+ypv/g
         rqhmu+YR3QouHaMRM2wrMA+T92o/44h+MN3YesKP6fLlqbIoI3AGNz3BwivwgsZCXHZ9
         huqbghslNDE8g99zHFYK1+8O97BRfbcZTvAuQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:reply-to:to:cc:in-reply-to:references:content-type
         :organization:date:message-id:mime-version:x-mailer
         :content-transfer-encoding;
        b=hRaayET+HF1DcIBLipSqCkWoN9iqFZntNFY620hBUH5Dod2YbabCgIYioVFDCoHKnC
         hWsS1hcgK4G8IppwNIMAZ14hfRzwElm9ULxwmOU3F1bbuFgKvUwmuDn2rF3zHiRokay0
         wjjzfE9FpSQup2hzucj7y7c/GnQ8Xlpyp6Pyg=
Received: by 10.101.74.6 with SMTP id b6mr3129216anl.186.1257211265044;
        Mon, 02 Nov 2009 17:21:05 -0800 (PST)
Received: from ?172.16.2.101? ([222.92.8.142])
        by mx.google.com with ESMTPS id 34sm2775485yxf.29.2009.11.02.17.20.58
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 02 Nov 2009 17:21:03 -0800 (PST)
Subject: Re: [PATCH -queue 2/7] [loongson] mem.c: Register reserved memory
 pages
From:	Wu Zhangjin <wuzhangjin@gmail.com>
Reply-To: wuzhangjin@gmail.com
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	Linux-MIPS <linux-mips@linux-mips.org>, yanh@lemote.com,
	huhb@lemote.com, Zhang Le <r0bertz@gentoo.org>, zhangfx@lemote.com
In-Reply-To: <20091102141459.GG21563@linux-mips.org>
References: <cover.1255673756.git.wuzhangjin@gmail.com>
	 <c709487f102bcd028fd637f5692ff42d94c55b33.1255673756.git.wuzhangjin@gmail.com>
	 <20091102141459.GG21563@linux-mips.org>
Content-Type: text/plain; charset="UTF-8"
Organization: DSLab, Lanzhou University, China
Date:	Tue, 03 Nov 2009 09:21:05 +0800
Message-ID: <1257211265.3528.17.camel@falcon.domain.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.28.1 
Content-Transfer-Encoding: 7bit
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24626
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

On Mon, 2009-11-02 at 15:14 +0100, Ralf Baechle wrote:
> On Fri, Oct 16, 2009 at 02:17:15PM +0800, Wu Zhangjin wrote:
> 
> > This patch registers the reserved pages for loongson family machines.
> 
> Hmm...  After our recent discussion on your hibernation issues I am
> wondering if this patch is actually still required or useful?

It does not help the hibernation issue, but helps to clear the memory
layout to the users(cat /proc/iomem), is this a need?

Seems some of the other architectures, including some MIPS variants have
registed the reserved space, so, could you please apply it?

Thanks & Regards,
	Wu Zhangjin
