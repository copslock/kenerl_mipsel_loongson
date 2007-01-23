Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 23 Jan 2007 15:00:53 +0000 (GMT)
Received: from wx-out-0506.google.com ([66.249.82.235]:12927 "EHLO
	wx-out-0506.google.com") by ftp.linux-mips.org with ESMTP
	id S28579153AbXAWPAs (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 23 Jan 2007 15:00:48 +0000
Received: by wx-out-0506.google.com with SMTP id t14so1726638wxc
        for <linux-mips@linux-mips.org>; Tue, 23 Jan 2007 07:00:42 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=WxOvmcwnXucv4a+bSaUVc0fxuvLVm0t7wh4nFyFxd0erFvGIcHgcoVfRsOLYR+Mnx72m6Ev65bxUqn6PXS8Ng9PQGXEqVrbd+5w2H7GHhUoxY3ANWNqCqh7cJ3NhUMNNamx9clhCXg7n9u8+CLGIBogpyrGtZWwDRnR4jsNX8eM=
Received: by 10.90.72.10 with SMTP id u10mr7981655aga.1169564442262;
        Tue, 23 Jan 2007 07:00:42 -0800 (PST)
Received: by 10.90.104.20 with HTTP; Tue, 23 Jan 2007 07:00:42 -0800 (PST)
Message-ID: <cda58cb80701230700j70f8e447o27f64091be9d57f5@mail.gmail.com>
Date:	Tue, 23 Jan 2007 16:00:42 +0100
From:	"Franck Bui-Huu" <vagabon.xyz@gmail.com>
To:	"Ralf Baechle" <ralf@linux-mips.org>
Subject: Re: [PATCH 3/7] signal: clean up sigframe structure
Cc:	linux-mips@linux-mips.org, "Franck Bui-Huu" <fbuihuu@gmail.com>
In-Reply-To: <20070123143541.GD18083@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <1169561903878-git-send-email-fbuihuu@gmail.com>
	 <11695619031474-git-send-email-fbuihuu@gmail.com>
	 <20070123143541.GD18083@linux-mips.org>
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13762
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vagabon.xyz@gmail.com
Precedence: bulk
X-list: linux-mips

On 1/23/07, Ralf Baechle <ralf@linux-mips.org> wrote:
> On Tue, Jan 23, 2007 at 03:18:19PM +0100, Franck Bui-Huu wrote:
>
> > +#ifndef ICACHE_REFILLS_WORKAROUND_WAR
>
> The _WAR symbols are always defined as either 0 or 1 so this #ifndef
> will never be true.
>

oops, true. I didn't notice that. I just look at:

#if defined(CONFIG_MOMENCO_JAGUAR_ATX) || defined(CONFIG_MOMENCO_OCELOT_3) || \
    defined(CONFIG_PMC_YOSEMITE) || defined(CONFIG_BASLER_EXCITE)
#define ICACHE_REFILLS_WORKAROUND_WAR	1
#endif

and didn't notice that the symbol could be defined to 0 below. I'll
fix it but just for my information what the point to do this ?
-- 
               Franck
