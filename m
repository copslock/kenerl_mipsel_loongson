Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 11 Nov 2009 19:47:26 +0100 (CET)
Received: from isilmar.linta.de ([213.133.102.198]:33720 "EHLO linta.de"
	rhost-flags-OK-OK-OK-FAIL) by ftp.linux-mips.org with ESMTP
	id S1492977AbZKKSrT (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 11 Nov 2009 19:47:19 +0100
Received: (qmail 12815 invoked from network); 11 Nov 2009 18:47:11 -0000
Received: from p54a07a32.dip.t-dialin.net (HELO comet.dominikbrodowski.net) (brodo@84.160.122.50)
  by isilmar.linta.de with (DHE-RSA-AES256-SHA encrypted) SMTP; 11 Nov 2009 18:47:11 -0000
Received: by comet.dominikbrodowski.net (Postfix, from userid 1000)
	id 9AED858222; Wed, 11 Nov 2009 19:21:13 +0100 (CET)
Date:	Wed, 11 Nov 2009 19:21:13 +0100
From:	Dominik Brodowski <linux@dominikbrodowski.net>
To:	Wu Zhangjin <wuzhangjin@gmail.com>
Cc:	Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
	cpufreq@vger.kernel.org, Dave Jones <davej@redhat.com>,
	yanh@lemote.com, huhb@lemote.com
Subject: Re: [PATCH -queue 3/3] [loongson] 2f: add Cpufreq support
Message-ID: <20091111182113.GB2690@comet.dominikbrodowski.net>
References: <cover.1257923011.git.wuzhangjin@gmail.com> <acbb780de66413230fb14272e6ce3bf12f9c24d3.1257923011.git.wuzhangjin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <acbb780de66413230fb14272e6ce3bf12f9c24d3.1257923011.git.wuzhangjin@gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <linux@dominikbrodowski.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24871
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: linux@dominikbrodowski.net
Precedence: bulk
X-list: linux-mips

Hey,

On Wed, Nov 11, 2009 at 03:09:59PM +0800, Wu Zhangjin wrote:
> +	printk(KERN_INFO "cpufreq: Loongson-2F CPU frequency driver.\n");
> +	result = cpufreq_register_driver(&loongson2_cpufreq_driver);
> +
> +	if (!result && !nowait) {
> +		saved_cpu_wait = cpu_wait;
> +		cpu_wait = loongson2_cpu_wait;
> +	}
> +
> +	cpufreq_register_notifier(&loongson2_cpufreq_notifier_block,
> +				  CPUFREQ_TRANSITION_NOTIFIER);

IMO you should register the transition notifier before register_driver(),
else there's a small window where a change may be initiate which is not
notified...

Best,
	Dominik
