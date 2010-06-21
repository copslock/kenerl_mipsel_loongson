Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 21 Jun 2010 04:56:48 +0200 (CEST)
Received: from mail-pz0-f49.google.com ([209.85.210.49]:64238 "EHLO
        mail-pz0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491045Ab0FUC4p (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 21 Jun 2010 04:56:45 +0200
Received: by pzk28 with SMTP id 28so137015pzk.36
        for <multiple recipients>; Sun, 20 Jun 2010 19:56:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :organization:user-agent:mime-version:to:cc:subject:references
         :in-reply-to:content-type:content-transfer-encoding;
        bh=0d0EvagroPbxhIgrngdUJRf+ysRfank7RDBUY4vmQSE=;
        b=m9bYoMe2dKK6lOcnhD5hCEHCJHT+Pg88Y7S8gVkqPNiCIRB4Saywr/J3V/pAFFSf+R
         /+qMO0R68PwZ0QCMOtJrUHlVh1B4tOjyhqRUO0wD1uktmEpv2dRu1StUJKC3UO0WAGfH
         wS2mcm6RSyiJaJWR3bz85dq2MlaEmEWlttnDM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:organization:user-agent:mime-version:to:cc
         :subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        b=CJUyXj0/5ly5ZtbSQBXV1jm/fnoQvXpEHj0iiy4ScwCZr9Dkn3ZMZCqtBYxdAeXODc
         PeSKgUt7YTjzp8HU2fRX149Xj+vYnzfXYss8LKJ2NSvNR2ODbBgXo18ey0UF0Hvl8X+X
         Q4ExKGSEf5Q0+BmQljDN1qtnK8nmW3fU9+Av8=
Received: by 10.115.80.7 with SMTP id h7mr3309619wal.159.1277088995120;
        Sun, 20 Jun 2010 19:56:35 -0700 (PDT)
Received: from openmobilefree.net ([124.207.145.157])
        by mx.google.com with ESMTPS id h9sm9733452wal.12.2010.06.20.19.56.15
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 20 Jun 2010 19:56:33 -0700 (PDT)
Message-ID: <4C1ED4CA.9030906@gmail.com>
Date:   Mon, 21 Jun 2010 10:56:10 +0800
From:   Xiangfu Liu <xiangfu.z@gmail.com>
Organization: www.openmobilefree.net
User-Agent: Mozilla/5.0 (X11; U; Linux i686 (x86_64); en-US; rv:1.9.1.10) Gecko/20100512 Thunderbird/3.0.5
MIME-Version: 1.0
To:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>
CC:     Lars-Peter Clausen <lars@metafoo.de>,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org,
        Alessandro Zummo <a.zummo@towertech.it>,
        Andrew Morton <akpm@linux-foundation.org>,
        Anton Vorontsov <cbouatmailru@gmail.com>,
        David Brownell <dbrownell@users.sourceforge.net>,
        David Woodhouse <dwmw2@infradead.org>,
        Greg Kroah-Hartman <gregkh@suse.de>,
        Liam Girdwood <lrg@slimlogic.co.uk>,
        Mark Brown <broonie@opensource.wolfsonmicro.com>,
        Paul Gortmaker <p_gortmaker@yahoo.com>,
        Samuel Ortiz <sameo@linux.intel.com>,
        alsa-devel@alsa-project.org, linux-fbdev@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-mtd@lists.infradead.org,
        linux-usb@vger.kernel.org, lm-sensors@lm-sensors.org,
        rtc-linux@googlegroups.com
Subject: Re: [PATCH v2 00/26] Add support for the Ingenic JZ4740 System-on-a-Chip
References: <1276924111-11158-1-git-send-email-lars@metafoo.de> <20100620092610.GA4950@alpha.franken.de>
In-Reply-To: <20100620092610.GA4950@alpha.franken.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-archive-position: 27236
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: xiangfu.z@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 14069

On 06/20/2010 05:26 PM, Thomas Bogendoerfer wrote:
> great stuff. I have a JZ4730 based netbook, for which I started magling
> the provided sources quite some time ago, but I didn't reach the
> point of submitting patches... there are a lot of common stuff between
> JZ4730 and JZ4740 so IMHO it would be a good thing not to nail
> everthing to JZ4740 namewise. It might also a good idea to select
> something like arch/mips/jzrisc as base directory, put the

Hi Thomas

I would advice "xburst" instead jzrisc. because the Ingenic call
their cpu "XBurst" series. like: XBurst JZ4740, XBurst JZ4750 ...


> factored out code there and add JZ4730/JZ4740 in either seperate
> files or directories.


-- 
Best Regards
Xiangfu Liu
http://www.openmobilefree.net
