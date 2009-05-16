Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 16 May 2009 01:39:52 +0100 (BST)
Received: from yw-out-1718.google.com ([74.125.46.156]:11967 "EHLO
	yw-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org
	with ESMTP id S20022859AbZEPAjp convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sat, 16 May 2009 01:39:45 +0100
Received: by yw-out-1718.google.com with SMTP id 9so1221697ywk.24
        for <multiple recipients>; Fri, 15 May 2009 17:39:44 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:received:in-reply-to
         :references:date:x-google-sender-auth:message-id:subject:from:to:cc
         :content-type:content-transfer-encoding;
        bh=/hcIxAFUd7coO4N13EL2e5zXG5j+D0sKtLtqbu4gS6c=;
        b=km2ryQ6NieBjf7sLanvv+pfuPaPCLe+nLoUBtSTyJJUvc6dQee39UMtOKJMOssxoc8
         mdDjXx6hSYAa7u70SgA36bT06YFz5yaVfGuq2WshRyh8vjxoWlywRmETNk7PNW2Gt4En
         2DbN3Tzmq/mL0ywOTUsWuIlwz4V/517lPJ4yY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        b=UuNShpY6o9Eox2jKk5YXl5Lr0qE0QbEDVOOyCchfF/m9hFx7d19bJRuhsQHRJ0r4De
         L+oKZPEENt6zUcWKlcp0xULjy/kzbWupOl2MmAmwAqfUckq3lPY8PmAS6Gm/IhwneSZf
         P2jkVyzueWQD32G4Pt60pqdYo820EtJlzlpMY=
MIME-Version: 1.0
Received: by 10.231.34.66 with SMTP id k2mr2255215ibd.19.1242434383930; Fri, 
	15 May 2009 17:39:43 -0700 (PDT)
In-Reply-To: <1242426182.10164.168.camel@falcon>
References: <1242426182.10164.168.camel@falcon>
Date:	Fri, 15 May 2009 17:39:43 -0700
X-Google-Sender-Auth: 16a1414bae845d50
Message-ID: <1f1b08da0905151739v6bc2e5f6t57cb8e06cdda2673@mail.gmail.com>
Subject: Re: [PATCH 23/30] loongson: CS5536 MFGPT as system clock source 
	support
From:	john stultz <johnstul@us.ibm.com>
To:	wuzhangjin@gmail.com
Cc:	linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>,
	linux-kernel@vger.kernel.org, Arnaud Patard <apatard@mandriva.com>,
	loongson-dev@googlegroups.com, zhangfx@lemote.com, yanh@lemote.com,
	Philippe Vachon <philippe@cowpig.ca>,
	Zhang Le <r0bertz@gentoo.org>, Erwan Lerale <erwan@thiscow.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Return-Path: <johnstul.lkml@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22770
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: johnstul@us.ibm.com
Precedence: bulk
X-list: linux-mips

On Fri, May 15, 2009 at 3:23 PM, Wu Zhangjin <wuzhangjin@gmail.com> wrote:
> +static struct clocksource clocksource_mfgpt = {
> +       .name = "mfgpt",
> +       .rating = 1200,

Minor nit. Please read the comment over the struct clocksource
definition in include/linux/clocksource.h for a guide to setting the
rating value for your clocksource.

thanks
-john
