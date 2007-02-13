Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 13 Feb 2007 17:03:51 +0000 (GMT)
Received: from qb-out-0506.google.com ([72.14.204.234]:10911 "EHLO
	qb-out-0506.google.com") by ftp.linux-mips.org with ESMTP
	id S20039297AbXBMRDr (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 13 Feb 2007 17:03:47 +0000
Received: by qb-out-0506.google.com with SMTP id z8so950803qbc
        for <linux-mips@linux-mips.org>; Tue, 13 Feb 2007 09:02:46 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=gdDNRRR2KKwbke4AngDaAcFvb/+ji3Yrnr1OohitNdjBjd9ebJCfZYkiMTu0M2S+EMSRzIPdWZH0rgsn9T1fVc5Nh3J74JBLcY1y1SUhep0VwHOSfH0dVSsOi3v9+ZsYzKQrJ5m9I2KpWZwFEVwSBHCULCrd7XUW1KRjRkMbWxs=
Received: by 10.114.202.15 with SMTP id z15mr7885059waf.1171386166175;
        Tue, 13 Feb 2007 09:02:46 -0800 (PST)
Received: by 10.114.136.11 with HTTP; Tue, 13 Feb 2007 09:02:46 -0800 (PST)
Message-ID: <cda58cb80702130902s521043abk8ed7aafdceb070ef@mail.gmail.com>
Date:	Tue, 13 Feb 2007 18:02:46 +0100
From:	"Franck Bui-Huu" <vagabon.xyz@gmail.com>
To:	"Atsushi Nemoto" <anemo@mba.ocn.ne.jp>
Subject: Re: [PATCH 2/3] Automatically set CONFIG_BUILD_ELF64
Cc:	ralf@linux-mips.org, linux-mips@linux-mips.org,
	macro@linux-mips.org
In-Reply-To: <20070214.011202.27778033.anemo@mba.ocn.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <1171358289786-git-send-email-fbuihuu@gmail.com>
	 <11713582901742-git-send-email-fbuihuu@gmail.com>
	 <20070214.011202.27778033.anemo@mba.ocn.ne.jp>
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14079
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vagabon.xyz@gmail.com
Precedence: bulk
X-list: linux-mips

On 2/13/07, Atsushi Nemoto <anemo@mba.ocn.ne.jp> wrote:
> On Tue, 13 Feb 2007 10:18:08 +0100, Franck Bui-Huu <vagabon.xyz@gmail.com> wrote:
> > +  ifeq ("$(BUILD_ELF32)", "y")
> > +    cflags-y += -msym32
>
> ifeq ($(BUILD_ELF32),y)
>
> is enough, isn't it?

yes it is, I'll change it.

thanks
-- 
               Franck
