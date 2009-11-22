Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 22 Nov 2009 14:19:13 +0100 (CET)
Received: from mail-px0-f173.google.com ([209.85.216.173]:41796 "EHLO
	mail-px0-f173.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1492489AbZKVNTG (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sun, 22 Nov 2009 14:19:06 +0100
Received: by pxi3 with SMTP id 3so3406513pxi.22
        for <multiple recipients>; Sun, 22 Nov 2009 05:18:56 -0800 (PST)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:reply-to:to:cc
         :in-reply-to:references:content-type:organization:date:message-id
         :mime-version:x-mailer:content-transfer-encoding;
        bh=nu1SBWJBKuFHt9Asj1acTylD0x6trEpkj/2cSiDX+EU=;
        b=smZmcKiAAZS7v/21x8GxihU8YD0hy/ezdKLXlSNjeD3J/BtO5iLzIjKONY66pGM+9J
         fFyMRB/YCbwsGkwCqfmP46elvIhrRbXadQLLfU+dF2p3jy2CYFNz09aDXzu9kYKwdNrL
         evPCh3TNyqnPKBUxMup/FlQbOwsRLvzLD53N4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:reply-to:to:cc:in-reply-to:references:content-type
         :organization:date:message-id:mime-version:x-mailer
         :content-transfer-encoding;
        b=Neg4wKoHUSvR4JtrI/F0tOIEWJGwjvfkfoh7AXOheryemDut3qV0QemVXxv5E1PZsd
         wDCCauXeuEqaRTjZqRcvWN5dlL4d2bLsmtZDwC5HkIuaL7qhkel8R8V3X446ax2m/f1T
         axZ6NlqjDBi+u096rRnZAThfY6HyfXGJeuyYA=
Received: by 10.114.18.23 with SMTP id 23mr6134959war.171.1258895936631;
        Sun, 22 Nov 2009 05:18:56 -0800 (PST)
Received: from ?172.16.2.101? ([222.92.8.142])
        by mx.google.com with ESMTPS id 22sm2355434pzk.10.2009.11.22.05.18.51
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 22 Nov 2009 05:18:54 -0800 (PST)
Subject: Re: [PATCH v2] MIPS: Add a high resolution sched_clock() via
 cnt32_to_63().
From:	Wu Zhangjin <wuzhangjin@gmail.com>
Reply-To: wuzhangjin@gmail.com
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	Ingo Molnar <mingo@elte.hu>, linux-mips@linux-mips.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Michal Simek <monstr@monstr.eu>, linux-kernel@vger.kernel.org
In-Reply-To: <20091122123509.GA1941@linux-mips.org>
References: <dae45f23b5d34f64fc60a445015e7dfe05aa0d07.1258875717.git.wuzhangjin@gmail.com>
	 <20091122081328.GB24558@elte.hu>
	 <1258888086.4548.52.camel@falcon.domain.org>
	 <20091122123509.GA1941@linux-mips.org>
Content-Type: text/plain; charset="UTF-8"
Organization: DSLab, Lanzhou University, China
Date:	Sun, 22 Nov 2009 21:18:34 +0800
Message-ID: <1258895914.6913.13.camel@falcon.domain.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.28.1 
Content-Transfer-Encoding: 7bit
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25037
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

On Sun, 2009-11-22 at 12:35 +0000, Ralf Baechle wrote:
> On Sun, Nov 22, 2009 at 07:08:05PM +0800, Wu Zhangjin wrote:
> 
> > > > +	data = (0xffffffffUL / tclk / 2 - 2) * HZ;
> > 
> > Because the MIPS c0 count's frequency is half of the cpu frequency(Hi,
> > Ralf, does every MIPS c0 count meet this feature?), so, the above line
> > should be:
> 
> There are processors which have no cp0 counter at all; these are mostly
> very old pre-R4000 era 32-bit MIPS I and MIPS II cores.
> 
> Of those which have a cp0 counter most will clock it at "half the maximum
> instruction issue rate" and a few at the full rate.  Finally for a few
> such as the RM52xx either half or the full count the rate is selectable by
> the reset initialization bitstream fed into the processor.  Too make this
> feature suck nicely there is no way for software to find out which rate
> was selected so software must know that or calibrate against a timer of
> known frequency.
> 
> Platform-specific code does this by setting mips_hpt_frequency to the
> count rate before calling init_r4k_clocksource; it's also the value being
> passed into setup_sched_clock_update() so you don't need to count for the
> half / full clock rate thing there.
> 
> I don't see why you need the -2 in your formula so the whole thing can
> be simplified to:
> 
> 	data = 0x80000000 / tclk * HZ;
> 

Sorry, I have mixed the mips_hpt_frequency with the cpu frequency,
mips_hpt_frequency is exactly the frequency of the timer. so, there is
no need to consider the relation between it and the cpu frequency here.
therefore, my old formula should be okay, that -2 is used to ensure data
is smaller than half of the period of the timer. 

Best Regards,
	Wu Zhangjin
