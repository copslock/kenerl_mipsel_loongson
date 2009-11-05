Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 05 Nov 2009 01:44:43 +0100 (CET)
Received: from mail-yx0-f204.google.com ([209.85.210.204]:60674 "EHLO
	mail-yx0-f204.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1494102AbZKEAoh (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 5 Nov 2009 01:44:37 +0100
Received: by yxe42 with SMTP id 42so8034300yxe.22
        for <multiple recipients>; Wed, 04 Nov 2009 16:44:30 -0800 (PST)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:reply-to:to:cc
         :in-reply-to:references:content-type:organization:date:message-id
         :mime-version:x-mailer:content-transfer-encoding;
        bh=Lp5eXAxVRv60txsFWkTY0kwpcIkaDT7HlIECJ9CANYo=;
        b=tdJSAEPCjYfGuD2oeSCOer0HshZSv8TkKQ//SRsoguH8c06sGN/e/NjEeeHRg6Orfe
         zscsKQCAlAGYQU3r07abMUJi6O/nMrSWv4h5rJTa9r3NCRjbtKNbsTtiaJsWzZEkbxpE
         vnQTdyGenCDnG0lggqjXDyL7R82WoidWhaKoY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:reply-to:to:cc:in-reply-to:references:content-type
         :organization:date:message-id:mime-version:x-mailer
         :content-transfer-encoding;
        b=TCwXkorIiHw4wnWG1dGT8XM26SwVaICc3Lxp500nUWaWZL/Ag1J0bOMh+ZveL6JVzs
         oGQaMwaxN95TzT26/qMZ1qad5+U3SZ0bUHAEJBs+KnGoQ88afi8569dwML7rbH32fE4a
         QdNC6eILFHO1aBOQYDcPt3Dejp3WMXst0Du18=
Received: by 10.90.18.33 with SMTP id 33mr4212705agr.113.1257381869953;
        Wed, 04 Nov 2009 16:44:29 -0800 (PST)
Received: from ?172.16.2.101? ([222.92.8.142])
        by mx.google.com with ESMTPS id 5sm710230yxg.64.2009.11.04.16.44.26
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 04 Nov 2009 16:44:29 -0800 (PST)
Subject: Re: [PATCH 1/2] RTC: enable RTC_LIB for fuloong2e and fuloong2f
From:	Wu Zhangjin <wuzhangjin@gmail.com>
Reply-To: wuzhangjin@gmail.com
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	Arnaud Patard <apatard@mandriva.com>, linux-mips@linux-mips.org,
	rtc-linux@googlegroups.com
In-Reply-To: <20091104162650.GB18408@linux-mips.org>
References: <1257349762-21407-1-git-send-email-wuzhangjin@gmail.com>
	 <20091104162650.GB18408@linux-mips.org>
Content-Type: text/plain; charset="UTF-8"
Organization: DSLab, Lanzhou University, China
Date:	Thu, 05 Nov 2009 08:44:30 +0800
Message-ID: <1257381870.16033.7.camel@falcon.domain.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.28.1 
Content-Transfer-Encoding: 7bit
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24685
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

On Wed, 2009-11-04 at 17:26 +0100, Ralf Baechle wrote:
> On Wed, Nov 04, 2009 at 11:49:22PM +0800, Wu Zhangjin wrote:
> 
> > diff --git a/drivers/rtc/rtc-cmos.c b/drivers/rtc/rtc-cmos.c
> > index f7a4701..820bdad 100644
> > --- a/drivers/rtc/rtc-cmos.c
> > +++ b/drivers/rtc/rtc-cmos.c
> > @@ -691,7 +691,8 @@ cmos_do_probe(struct device *dev, struct resource *ports, int rtc_irq)
> >  	 */
> >  #if	defined(CONFIG_ATARI)
> >  	address_space = 64;
> > -#elif defined(__i386__) || defined(__x86_64__) || defined(__arm__) || defined(__sparc__)
> > +#elif defined(__i386__) || defined(__x86_64__) || defined(__arm__) \
> > +			|| defined(__sparc__) || defined(__mips__)
> >  	address_space = 128;
> >  #else
> >  #warning Assuming 128 bytes of RTC+NVRAM address space, not 64 bytes.
> 
> I'd like to see at least this first segment included for 2.6.32 already.
> 

Will split it out for 2.6.32.

Regards,
	Wu Zhangjin
