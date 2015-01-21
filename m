Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 21 Jan 2015 07:47:42 +0100 (CET)
Received: from mail-lb0-f179.google.com ([209.85.217.179]:64983 "EHLO
        mail-lb0-f179.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27010042AbbAUGrjvKT0u convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 21 Jan 2015 07:47:39 +0100
Received: by mail-lb0-f179.google.com with SMTP id z11so37657894lbi.10;
        Tue, 20 Jan 2015 22:47:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=z2xrB6tevWv2EX/iwB0xrP9xj5TjM7u4bDPKbmbxMgI=;
        b=l4hmVsg5C4/9VaPr/RptPyfFTsjEfpSH52RU/0x6mmVYZjRCRtUJ+MVtsLpURFNJaH
         UNbfuqns0umtOHrwVPO8nUaps59ozL65q2YyA5EofZrmlNs3cRn8eDNHScKSYFLon1uY
         4+FYLmy0bRI8Np0n2M34deQ3g++2MfX+Uu+4O4WFP62P4TgsG5L0ClOvSwDT53QxSzli
         /eseHl/TQM9g2GKvacv1LwlfHrc52TpHALGE5yihT8nlnx9KVE041youF+QEvWGewq6H
         E3Zh31lOcKCVpszW8DVbx0Z/gDdCXpI3hzi7ltPKPefoD6cGgMqaoNWwp2dre0X4NOu6
         IbNw==
X-Received: by 10.112.156.169 with SMTP id wf9mr42349461lbb.85.1421822854469;
        Tue, 20 Jan 2015 22:47:34 -0800 (PST)
Received: from flare (t35.niisi.ras.ru. [193.232.173.35])
        by mx.google.com with ESMTPSA id q9sm4640991lbo.29.2015.01.20.22.47.33
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 20 Jan 2015 22:47:33 -0800 (PST)
Date:   Wed, 21 Jan 2015 10:50:15 +0400
From:   Antony Pavlov <antonynpavlov@gmail.com>
To:     David Daney <ddaney.cavm@gmail.com>
Cc:     Joshua Kinard <kumba@gentoo.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Linux MIPS List <linux-mips@linux-mips.org>
Subject: Re: [PATCH] MIPS: Display CPU byteorder in /proc/cpuinfo
Message-Id: <20150121105015.94e2448a20847aa2eac738db@gmail.com>
In-Reply-To: <54BEDF3C.6040105@gmail.com>
References: <54BCC827.3020806@gentoo.org>
        <54BEDF3C.6040105@gmail.com>
X-Mailer: Sylpheed 3.4.0beta7 (GTK+ 2.24.22; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Return-Path: <antonynpavlov@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45390
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: antonynpavlov@gmail.com
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

On Tue, 20 Jan 2015 15:05:32 -0800
David Daney <ddaney.cavm@gmail.com> wrote:

> On 01/19/2015 01:02 AM, Joshua Kinard wrote:
> > From: Joshua Kinard <kumba@gentoo.org>
> >
> > This is a small patch to display the CPU byteorder that the kernel was compiled
> > with in /proc/cpuinfo.
> 
> What would use this?  Or in other words, why is this needed?

If you run some test software (e.g. in particular benchmarking software)
on a linux system then you are interisting in a log file with system information.
It's very likely that your log file keeps /proc/cpuinfo content.
So if your /proc/cpuinfo has byteorder information then your have system
byteorder information in your log file for free :)

If you write a bugreport and your attach /proc/cpuinfo content to it
then a bugreport reader have no question on byteorder.

> 
> Userspace C code doesn't need this as it has its own standard ways of 
> determining endianness.
> 
> If you need to know as a user you can do:
> 
>     readelf -h /bin/sh | grep Data | cut -d, -f2

Does this line really show your current CPU byteorder?

IMHO this 'readelf' method is not very reliable :)

> 
> 
> >
> > Signed-off-by: Joshua Kinard <kumba@gentoo.org>
> > ---
> >   arch/mips/kernel/proc.c |    5 +++++
> >   1 file changed, 5 insertions(+)
> >
> > This patch has been submitted several times prior over the years (I think), but
> > I don't recall what, if any, objections there were to it.
> >
> > linux-mips-proc-cpuinfo-byteorder.patch
> > diff --git a/arch/mips/kernel/proc.c b/arch/mips/kernel/proc.c
> > index 097fc8d..75e6a62 100644
> > --- a/arch/mips/kernel/proc.c
> > +++ b/arch/mips/kernel/proc.c
> > @@ -65,6 +65,11 @@ static int show_cpuinfo(struct seq_file *m, void *v)
> >   	seq_printf(m, "BogoMIPS\t\t: %u.%02u\n",
> >   		      cpu_data[n].udelay_val / (500000/HZ),
> >   		      (cpu_data[n].udelay_val / (5000/HZ)) % 100);
> > +#ifdef __MIPSEB__
> > +	seq_printf(m, "byteorder\t\t: big endian\n");
> > +#else
> > +	seq_printf(m, "byteorder\t\t: little endian\n");
> > +#endif
> >   	seq_printf(m, "wait instruction\t: %s\n", cpu_wait ? "yes" : "no");
> >   	seq_printf(m, "microsecond timers\t: %s\n",
> >   		      cpu_has_counter ? "yes" : "no");
> >
> >
> >
> 
> 


-- 
-- 
Best regards,
  Antony Pavlov
