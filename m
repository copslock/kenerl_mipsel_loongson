Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 11 Nov 2009 14:41:36 +0100 (CET)
Received: from mail-px0-f176.google.com ([209.85.216.176]:45381 "EHLO
	mail-px0-f176.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1492763AbZKKNl3 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 11 Nov 2009 14:41:29 +0100
Received: by pxi6 with SMTP id 6so1064923pxi.0
        for <multiple recipients>; Wed, 11 Nov 2009 05:41:23 -0800 (PST)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:reply-to:to:cc
         :in-reply-to:references:content-type:organization:date:message-id
         :mime-version:x-mailer:content-transfer-encoding;
        bh=MVKEIWqHlwQbxvuJHuJVuaHBXxoKlAmZf+TXgvatg6Q=;
        b=tuesl8BD599Pjom4vnRvmf6CvJWsaVS4F4pfZMhpw3w/3EdUnAZ9aIItCIZ9+YRFlA
         /ItcXtdjI/JB/Ua9woaVB9prKFQ807Kb16sA2q829tufkESkSK5GS0+F3CZK2XzoP+64
         YQv70joitf2cPRflOdXPVw0qZ+pkevazrZqZk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:reply-to:to:cc:in-reply-to:references:content-type
         :organization:date:message-id:mime-version:x-mailer
         :content-transfer-encoding;
        b=nhGZxUVvsRa3an0FeJMP9WeokUZu/AT2D53v6PniqbelCsueGbJkvZU/LyfWyJnXiT
         NbTXs75BMAfBzty3HZ8+trcjGVI0f412me61Z0d8nKwL/fIwmfsou4QFgTxJC6PnSgA8
         wZ1LM189aFKMAPSSvi3Tnhx8Od71cCctgv2YI=
Received: by 10.114.188.21 with SMTP id l21mr3225001waf.138.1257946882899;
        Wed, 11 Nov 2009 05:41:22 -0800 (PST)
Received: from ?172.16.2.101? ([222.92.8.142])
        by mx.google.com with ESMTPS id 21sm1084421pxi.12.2009.11.11.05.41.17
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 11 Nov 2009 05:41:22 -0800 (PST)
Subject: Re: [PATCH -queue 1/3] [loongson] lemote-2f: add cs5536 MFGPT
 timer support
From:	Wu Zhangjin <wuzhangjin@gmail.com>
Reply-To: wuzhangjin@gmail.com
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	linux-mips@linux-mips.org, cpufreq@vger.kernel.org,
	Dave Jones <davej@redhat.com>, yanh@lemote.com, huhb@lemote.com
In-Reply-To: <de82733902e9549883b840f082a67b9edaa32c45.1257923011.git.wuzhangjin@gmail.com>
References: <cover.1257923011.git.wuzhangjin@gmail.com>
	 <de82733902e9549883b840f082a67b9edaa32c45.1257923011.git.wuzhangjin@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Organization: DSLab, Lanzhou University, China
Date:	Wed, 11 Nov 2009 21:41:02 +0800
Message-ID: <1257946862.7308.1.camel@falcon.domain.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.28.1 
Content-Transfer-Encoding: 7bit
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24859
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

Hi,

On Wed, 2009-11-11 at 15:09 +0800, Wu Zhangjin wrote:
[...]
> diff --git a/arch/mips/include/asm/mach-loongson/cs5536/cs5536_mfgpt.h b/arch/mips/include/asm/mach-loongson/cs5536/cs5536_mfgpt.h
[...]
> +
> +#ifdef CONFIG_CS5536_MFGPT
> +extern void setup_mfgpt_timer(void);
> +extern void disable_mfgpt0_counter(void);
> +extern void enable_mfgpt0_counter(void);
> +#else
> +static inline void __maybe_unused setup_mfgpt0_timer(void)

Sorry, the above line should be:

+static inline void __maybe_unused setup_mfgpt_timer(void)

No 0 there.

Regards,
	Wu Zhangjin
