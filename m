Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 26 Jan 2010 03:03:22 +0100 (CET)
Received: from smtp106.sbc.mail.gq1.yahoo.com ([67.195.14.109]:42494 "HELO
        smtp106.sbc.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with SMTP id S1493268Ab0AZCDS (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 26 Jan 2010 03:03:18 +0100
Received: (qmail 47047 invoked from network); 26 Jan 2010 02:03:11 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=pacbell.net;
  h=Received:X-Yahoo-SMTP:X-YMail-OSG:X-Yahoo-Newman-Property:From:To:Subject:Date:User-Agent:Cc:References:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-Disposition:Message-Id;
  b=LgDzKNDoO+3AS3svad7RIIicYFfEuxJtb6jaW1MFnc4uxhfzW5eUz4SWdqv1lABzHAJlkbIbRK4d8pnSCA2gzbWESuPj5AGj55H6gHl+b7M4EOU/Qt372rZUimD5gLEKXn6faRwYkuNr0DnSPcvKct08qNG4wSMFpCYlVZFs1YI=  ;
Received: from adsl-69-226-236-181.dsl.pltn13.pacbell.net (david-b@69.226.236.181 with plain)
        by smtp106.sbc.mail.gq1.yahoo.com with SMTP; 25 Jan 2010 18:03:11 -0800 PST
X-Yahoo-SMTP: 2V1ThQ.swBDh24fWwg9PZFuY7TTwFsTuVtXZ.8DKSgQ-
X-YMail-OSG: wObP4uEVM1ly4VRaPLLkt5q7FFbA3Ib3VlgF3rNCakx2u0dS0DxRgNCj0VJ2c51doolsFWiSepnw9Zp8ph.Wf6Jcbe67GrHyVfbbSCil9uAIv1GinnWpeSiwfWfKeXkjiylIzY0rSkJaSkY8h3wfzHegwm59HGD_zbn4m1cZPmlrCHe1xWFYacm5mlNOfYl09KdSlXgo06PiAKM841nd776KhVKzMdfQcRJP4gWh_0yHywDsYb0h_9tu825n5uMxU2gTiHz6kaYj0qUiu2cZF37eL134ioVkaFU1DDjooF0TzWpLObf7YFRO2v7s3Kh32HKuBg--
X-Yahoo-Newman-Property: ymail-3
From:   David Brownell <david-b@pacbell.net>
To:     wuzhangjin@gmail.com
Subject: Re: [rtc-linux] [PATCH v1 2/3] RTC: rtc-cmos.c: enable RTC_DM_BINARY of RTC_LIB for fuloong2e and fuloong2f
Date:   Mon, 25 Jan 2010 18:03:09 -0800
User-Agent: KMail/1.9.10
Cc:     Alessandro Zummo <a.zummo@towertech.it>,
        rtc-linux@googlegroups.com, Paul Gortmaker <p_gortmaker@yahoo.com>,
        linux-mips@linux-mips.org
References: <cover.1257383766.git.wuzhangjin@gmail.com> <20091203172735.7c934f61@linux.lan.towertech.it> <1259858696.7536.28.camel@falcon.domain.org>
In-Reply-To: <1259858696.7536.28.camel@falcon.domain.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <201001251803.09883.david-b@pacbell.net>
X-archive-position: 25657
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: david-b@pacbell.net
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 16374

On Thursday 03 December 2009, Wu Zhangjin wrote:
> On Thu, 2009-12-03 at 17:27 +0100, Alessandro Zummo wrote:
> > On Thu,  5 Nov 2009 09:22:09 +0800
> > Wu Zhangjin <wuzhangjin@gmail.com> wrote:
> > 
> > >  	 */
> > > -	if (is_valid_irq(rtc_irq) &&
> > > -	    (!(rtc_control & RTC_24H) || (rtc_control & (RTC_DM_BINARY)))) {
> > > -		dev_dbg(dev, "only 24-hr BCD mode supported\n");
> > > +	if (is_valid_irq(rtc_irq) && !(rtc_control & RTC_24H)) {
> > > +		dev_dbg(dev, "only 24-hr supported\n");
> > 
> >  If this check was there it's probably because there are problems
> >  in some other parts of the driver. I'm not keen to add this without
> >  some feedback by the original author or porter.

As *already* noted in the code:  <asm-generic/rtc.h> only handles BCD.
And that's what's used to access most of those registers.
