Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 03 Apr 2008 02:19:36 +0200 (CEST)
Received: from smtp-out112.alice.it ([85.37.17.112]:8966 "EHLO
	smtp-out112.alice.it") by lappi.linux-mips.net with ESMTP
	id S526274AbYDCAT3 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 3 Apr 2008 02:19:29 +0200
Received: from FBCMMO01.fbc.local ([192.168.68.195]) by smtp-out112.alice.it with Microsoft SMTPSVC(6.0.3790.1830);
	 Thu, 3 Apr 2008 02:19:05 +0200
Received: from FBCMCL01B02.fbc.local ([192.168.69.83]) by FBCMMO01.fbc.local with Microsoft SMTPSVC(6.0.3790.1830);
	 Thu, 3 Apr 2008 02:19:04 +0200
Received: from [192.168.1.3] ([87.7.112.40]) by FBCMCL01B02.fbc.local with Microsoft SMTPSVC(6.0.3790.1830);
	 Thu, 3 Apr 2008 02:19:04 +0200
From:	Matteo Croce <technoboy85@gmail.com>
To:	Florian Lohoff <flo@rfc822.org>
Subject: Re: [PATCH][MIPS][3/6]: AR7: VLYNQ bus
Date:	Thu, 3 Apr 2008 02:19:03 +0200
User-Agent: KMail/1.9.9
Cc:	linux-mips@linux-mips.org, Eugene Konev <ejka@imfi.kspu.ru>,
	Andrew Morton <akpm@linux-foundation.org>
References: <200803120221.25044.technoboy85@gmail.com> <200804021456.44472.technoboy85@gmail.com> <20080402183114.GA371@paradigm.rfc822.org>
In-Reply-To: <20080402183114.GA371@paradigm.rfc822.org>
X-Face:	0AUq?,0sKh2O65+R5#[nTCS'~}"m)9|g3Tsi=g7A9q69S+=M!BY)=?utf-8?q?Zdmwo2u!i=5CUylx=26=27D+=0A=09=5B7u=26z1=27s=7E=5B=3F+=24=27w?=
 =?utf-8?q?O6+?="'WWcr5Jy,]}8namg8NP:9<E,o^21xGB~/HRhB(u^@
 =?utf-8?q?ZB=2EXLP0swe=0A=09r9M=7EL?=<b1=^'4cv*_N1tNJ$`9Ot*KL/;8oXFdrT@r|-Ki2wCQI"R(X(
 =?utf-8?q?73r=3A=3BmnNPoA2a=5D=7EZ=0A=092n2sUh?=,B|bt;ys*hv.QR>a]{m
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200804030219.03335.technoboy85@gmail.com>
X-OriginalArrivalTime: 03 Apr 2008 00:19:04.0633 (UTC) FILETIME=[5322A290:01C89520]
Return-Path: <technoboy85@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18783
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: technoboy85@gmail.com
Precedence: bulk
X-list: linux-mips

Il Wednesday 02 April 2008 20:31:14 Florian Lohoff ha scritto:
> On Wed, Apr 02, 2008 at 02:56:44PM +0200, Matteo Croce wrote:
> > 
> > Works fine for my AR7 which has an interlan clock.
> > 
> 
> Its doesnt for me with an external clock - thats what i mean - Auto
> probing should first try to listen for an external clock before letting
> clocks run against each other. This is the hunk of a patch on top of
> yours ...
> 
> @@ -371,12 +371,20 @@ static int __vlynq_enable_device(struct 
>  
>         switch (dev->divisor) {
>         case vlynq_div_auto:
> -               /* Only try locally supplied clock, others cause problems */
> +       
> +               vlynq_reg_write(dev->local->control, 0);
>                 vlynq_reg_write(dev->remote->control, 0);
> +               if (vlynq_linked(dev)) {
> +                       printk(KERN_DEBUG "%s: using external clock\n",
> +                              dev->dev.bus_id);
> +                       return 0;
> +               }
> +
>                 for (i = vlynq_ldiv2; i <= vlynq_ldiv8; i++) {
>                         vlynq_reg_write(dev->local->control,
>                                         VLYNQ_CTRL_CLOCK_INT |
>                                         VLYNQ_CTRL_CLOCK_DIV(i - vlynq_ldiv1));
> +                       vlynq_reg_write(dev->remote->control, 0);
>                         if (vlynq_linked(dev)) {
>                                 printk(KERN_DEBUG
>                                        "%s: using local clock divisor %d\n",
> 
> Flo

isn't this what I do in my last patch?
