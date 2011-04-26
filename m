Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 26 Apr 2011 14:42:33 +0200 (CEST)
Received: from mailrelay003.isp.belgacom.be ([195.238.6.53]:35408 "EHLO
        mailrelay003.isp.belgacom.be" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1490992Ab1DZMm1 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 26 Apr 2011 14:42:27 +0200
X-Belgacom-Dynamic: yes
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AvsEAEK9tk1R8BPE/2dsb2JhbAClRHjEHg6FaAScYQ
Received: from 196.19-240-81.adsl-dyn.isp.belgacom.be (HELO infomag) ([81.240.19.196])
  by relay.skynet.be with ESMTP; 26 Apr 2011 14:42:12 +0200
Received: from wim by infomag with local (Exim 4.69)
        (envelope-from <wim@infomag.iguana.be>)
        id 1QEham-0007bK-8L; Tue, 26 Apr 2011 14:42:12 +0200
Date:   Tue, 26 Apr 2011 14:42:12 +0200
From:   Wim Van Sebroeck <wim@iguana.be>
To:     John Crispin <blogic@openwrt.org>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Ralph Hempel <ralph.hempel@lantiq.com>,
        linux-mips@linux-mips.org, linux-watchdog@vger.kernel.org
Subject: Re: [PATCH V6] MIPS: lantiq: add watchdog support
Message-ID: <20110426124212.GA17580@infomag.iguana.be>
References: <1303817863-19526-1-git-send-email-blogic@openwrt.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1303817863-19526-1-git-send-email-blogic@openwrt.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <wim@iguana.be>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29801
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wim@iguana.be
Precedence: bulk
X-list: linux-mips

Hi John,

> +static int
> +ltq_wdt_open(struct inode *inode, struct file *file)
> +{
> +	if (ltq_wdt_in_use)
> +		return -EBUSY;
> +	ltq_wdt_in_use = 1;
> +	ltq_wdt_enable();
> +
> +	return nonseekable_open(inode, file);
> +}

I prefer to see a test_and_set_bit(ltq_wdt_in_use) and a ...

> +static int
> +ltq_wdt_release(struct inode *inode, struct file *file)
> +{
> +	if (ltq_wdt_ok_to_close)
> +		ltq_wdt_disable();
> +	else
> +		pr_err("ltq_wdt: watchdog closed without warning\n");
> +	ltq_wdt_ok_to_close = 0;
> +	ltq_wdt_in_use = 0;
> +
> +	return 0;
> +}

... clear_bit(ltq_wdt_in_use);

For the rest is looks ok for me. So Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

Kind regards,
Wim.
