Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 07 Dec 2009 08:27:45 +0100 (CET)
Received: from mail-yw0-f203.google.com ([209.85.211.203]:46047 "EHLO
        mail-yw0-f203.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492223AbZLGH1l (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 7 Dec 2009 08:27:41 +0100
Received: by ywh41 with SMTP id 41so6387460ywh.0
        for <multiple recipients>; Sun, 06 Dec 2009 23:27:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:reply-to:to:cc
         :in-reply-to:references:content-type:organization:date:message-id
         :mime-version:x-mailer:content-transfer-encoding;
        bh=gY10Y5P5PtTxoMnu3fNKCuILSNmTRPAyXe2y8bCMHAQ=;
        b=d1nG2gCN2s9rbTYKbV5TewhwPRSRc2stjE2l7gLM1bB+Jgt7aXajwYpPl164lNbgOE
         fpXo0fgJK6pVK6Qfd44Kp3pv+jBonfWRM9u+O3Gx7VNpMKLo90j/A28aoIwJWR3HPEBC
         3fMY5ccsYHhf+YMRBLYwuX8YRRCkeM1WSnVqE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:reply-to:to:cc:in-reply-to:references:content-type
         :organization:date:message-id:mime-version:x-mailer
         :content-transfer-encoding;
        b=Ct70tVd3UzdW56B5DOxNjcdSIVOB0HQEjBUNC/JV5ufYgR9CZiVIWT/nWzkDHS6ztn
         OdhyFrMZ/NGZf97c1HRe84Cl1xYi8FGQrwzRFFr1Zt1lxctdPxcrLEvz80tkxzlFdqiM
         WgGGg40MKHaKDriw+tbm8A29XVVRybm6hZ4Bo=
Received: by 10.91.157.1 with SMTP id j1mr3111648ago.21.1260170853585;
        Sun, 06 Dec 2009 23:27:33 -0800 (PST)
Received: from ?172.16.2.101? ([222.92.8.142])
        by mx.google.com with ESMTPS id 22sm3466185iwn.12.2009.12.06.23.27.27
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 06 Dec 2009 23:27:32 -0800 (PST)
Subject: Re: [PATCH v8 8/8] Loongson: YeeLoong: add input/hotkey driver
From:   Wu Zhangjin <wuzhangjin@gmail.com>
Reply-To: wuzhangjin@gmail.com
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>, akpm@linux-foundation.org,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        "Rafael J . Wysocki" <rjw@sisk.pl>, zhangfx@lemote.com,
        linux-laptop@vger.kernel.org,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Pavel Machek <pavel@ucw.cz>
In-Reply-To: <20091207064857.GG21451@core.coreip.homeip.net>
References: <cover.1260082252.git.wuzhangjin@gmail.com>
         <b164d5bb79963a57621d024c22e5664de0ff8662.1260082252.git.wuzhangjin@gmail.com>
         <20091207064857.GG21451@core.coreip.homeip.net>
Content-Type: text/plain; charset="UTF-8"
Organization: DSLab, Lanzhou University, China
Date:   Mon, 07 Dec 2009 15:26:47 +0800
Message-ID: <1260170807.9092.9.camel@falcon.domain.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.28.1 
Content-Transfer-Encoding: 7bit
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25342
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

On Sun, 2009-12-06 at 22:48 -0800, Dmitry Torokhov wrote:
> Hi Wu,
> 
> On Sun, Dec 06, 2009 at 03:01:48PM +0800, Wu Zhangjin wrote:
> > +
> > +#define EC_VER_LEN 64
> > +
> > +static int black_screen_handler(int status)
> > +{
> > +	char *p, ec_ver[EC_VER_LEN];
> > +
> > +	p = strstr(loongson_cmdline, "EC_VER=");
> > +	if (!p)
> > +		memset(ec_ver, 0, EC_VER_LEN);
> > +	else {
> > +		strncpy(ec_ver, p, EC_VER_LEN);
> > +		p = strstr(ec_ver, " ");
> > +		if (p)
> > +			*p = '\0';
> > +	}
> > +
> 
> Hmm, why do you copy and parse command lineinstead of using module
> param and also doing it just once?
> 

The kernel command line (EC_VER=blabla) is passed by bootloader(PMON)
automatically, so, I think it's better to use it.

Using an extra module param is good, but may make the users confused and
will also add extra jobs to the distribution developers ;) in the
future, the information of the EC and the other information of the
devices will be passed to kernel from BIOS via something like
FDT(Flattened Device Tree, used on PowerPC machines) as Ralf introduced,
so, the above method is a temp solution.

Thanks & Regards,
	Wu Zhangjin

> > +	/* Seems EC(>=PQ1D26) does this job for us, we can not do it again,
> > +	 * otherwise, the brightness will not resume to the normal level! */
> > +	if (strncasecmp(ec_ver, "EC_VER=PQ1D26", 64) < 0)
> > +		yeeloong_lcd_vo_set(status);
> > +
> > +	return status;
> > +}
> 
> Thanks.
> 
