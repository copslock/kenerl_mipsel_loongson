Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 22 Nov 2005 22:28:57 +0000 (GMT)
Received: from smtp103.biz.mail.re2.yahoo.com ([68.142.229.217]:33957 "HELO
	smtp103.biz.mail.re2.yahoo.com") by ftp.linux-mips.org with SMTP
	id S8134167AbVKVW2j (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 22 Nov 2005 22:28:39 +0000
Received: (qmail 40186 invoked from network); 22 Nov 2005 22:31:14 -0000
Received: from unknown (HELO ?10.1.7.13?) (dan@embeddedalley.com@12.6.244.2 with plain)
  by smtp103.biz.mail.re2.yahoo.com with SMTP; 22 Nov 2005 22:31:14 -0000
In-Reply-To: <20051122221526.GZ18119@cosmic.amd.com>
References: <20051122221526.GZ18119@cosmic.amd.com>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <6dabaec28e238ccc915f20f51ee28327@embeddedalley.com>
Content-Transfer-Encoding: 7bit
Cc:	linux-mips@linux-mips.org, ralf@linux-mips.org
From:	Dan Malek <dan@embeddedalley.com>
Subject: Re: [PATCH] Fix board type in db1x00
Date:	Tue, 22 Nov 2005 17:31:20 -0500
To:	"Jordan Crouse" <jordan.crouse@amd.com>
X-Mailer: Apple Mail (2.623)
Return-Path: <dan@embeddedalley.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9542
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dan@embeddedalley.com
Precedence: bulk
X-list: linux-mips


On Nov 22, 2005, at 5:15 PM, Jordan Crouse wrote:

> +	/* Set the platform # */
> +#if	defined (CONFIG_MIPS_DB1550)
> +	mips_machtype = MACH_DB1550;
> +#elif	defined (CONFIG_MIPS_DB1500)
> +	mips_machtype = MACH_DB1500;
> +#elif	defined (CONFIG_MIPS_DB1100)
> +	mips_machtype = MACH_DB1100;
> +#else
> +	mips_machtype = MACH_DB1000;
> +#endif

Can't we just do something like
	#define MACH_ALCHEMY_TYPE  xxxxx

in the include files and not have this mess in the
actual code?  Then, all we have to do here is:

	mips_machtype = MACH_ALCHEMY_TYPE;


Thanks.

	-- Dan
