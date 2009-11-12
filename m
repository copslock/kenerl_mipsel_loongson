Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 12 Nov 2009 02:48:07 +0100 (CET)
Received: from mail-pw0-f45.google.com ([209.85.160.45]:45174 "EHLO
	mail-pw0-f45.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1493138AbZKLBsA (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 12 Nov 2009 02:48:00 +0100
Received: by pwi15 with SMTP id 15so1078536pwi.24
        for <multiple recipients>; Wed, 11 Nov 2009 17:47:50 -0800 (PST)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:reply-to:to:cc
         :in-reply-to:references:content-type:organization:date:message-id
         :mime-version:x-mailer:content-transfer-encoding;
        bh=5T1Cx2jI02MtbsgLhuEeazvFfBHAwCv4b4rZKjiz1UA=;
        b=fFuwlGfsta5FBFQfNDwtrheKh2qOzIBGrQUcSbg0NOe1dwlecq0WnW9aQrL8o6IbA/
         ER9+4F/cAU/AZf/C/Gk5al+7v5LKvi8GOoa+RhqSsaQA7KoeVmobloFsg+eeAXen+r9W
         9CEm+USMcOBa4i5PGPAItAkwndLDjDoHDbgk8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:reply-to:to:cc:in-reply-to:references:content-type
         :organization:date:message-id:mime-version:x-mailer
         :content-transfer-encoding;
        b=klIV/WtRk1amXOp4Gcf1ANFSwJW9Ytjfy8KS1lcziNXUaZNUrkYWu3fyw3Ys7rIg6+
         Tg1tcUb6kXQfb1vURSTI3tTEwpmhaJKQaeKbkUGiiHns4ChxHqA9fKT0T0jDl/FbzLQk
         tsQeo2hs7Gkeac2Lxm4weKF7VF/45GmrSz8yI=
Received: by 10.115.133.39 with SMTP id k39mr4816846wan.94.1257990470809;
        Wed, 11 Nov 2009 17:47:50 -0800 (PST)
Received: from ?172.16.2.101? ([222.92.8.142])
        by mx.google.com with ESMTPS id 22sm1334632pzk.14.2009.11.11.17.47.47
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 11 Nov 2009 17:47:50 -0800 (PST)
Subject: Re: [PATCH -queue 3/3] [loongson] 2f: add Cpufreq support
From:	Wu Zhangjin <wuzhangjin@gmail.com>
Reply-To: wuzhangjin@gmail.com
To:	Dominik Brodowski <linux@dominikbrodowski.net>
Cc:	Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
	cpufreq@vger.kernel.org, Dave Jones <davej@redhat.com>,
	yanh@lemote.com, huhb@lemote.com
In-Reply-To: <20091111182113.GB2690@comet.dominikbrodowski.net>
References: <cover.1257923011.git.wuzhangjin@gmail.com>
	 <acbb780de66413230fb14272e6ce3bf12f9c24d3.1257923011.git.wuzhangjin@gmail.com>
	 <20091111182113.GB2690@comet.dominikbrodowski.net>
Content-Type: text/plain; charset="UTF-8"
Organization: DSLab, Lanzhou University, China
Date:	Thu, 12 Nov 2009 09:47:45 +0800
Message-ID: <1257990465.3113.38.camel@falcon.domain.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.28.1 
Content-Transfer-Encoding: 7bit
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24874
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

Hi,

On Wed, 2009-11-11 at 19:21 +0100, Dominik Brodowski wrote:
[...]
> > +	result = cpufreq_register_driver(&loongson2_cpufreq_driver);
> > +
> > +	if (!result && !nowait) {
> > +		saved_cpu_wait = cpu_wait;
> > +		cpu_wait = loongson2_cpu_wait;
> > +	}
> > +
> > +	cpufreq_register_notifier(&loongson2_cpufreq_notifier_block,
> > +				  CPUFREQ_TRANSITION_NOTIFIER);
> 
> IMO you should register the transition notifier before register_driver(),
> else there's a small window where a change may be initiate which is not
> notified...
> 

Will adjust them later, thanks!

Regards,
	Wu Zhangjin
