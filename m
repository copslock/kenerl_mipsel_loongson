Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 07 Dec 2009 07:49:18 +0100 (CET)
Received: from mail-yx0-f204.google.com ([209.85.210.204]:55646 "EHLO
        mail-yx0-f204.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492062AbZLGGtO (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 7 Dec 2009 07:49:14 +0100
Received: by yxe42 with SMTP id 42so4087083yxe.22
        for <multiple recipients>; Sun, 06 Dec 2009 22:49:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=mUdwY+WJZb2/T4IMyl19WROuF0jPy3BxUd8/NmH02fU=;
        b=lnvG4U4maSPP2PcBOF6XHwymgAzX/8Xw//F5nxnIMs6n+EL2BCg7rpVVqyRH0PoDir
         GvnwC1lcMVe3QlaHe75k4A4gTnUkxC6GvaUVXEobg3v6NDG8FXW03qhlvi/CcLT2mfm8
         wulf/gqwz8WswlaoB4gLVN5TuPBmPwGUiCp8Q=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=NsGhP62BIU7rMU77428bagzQeHPYbMPcyPmFUW4n3VBgDGc7KcD/1h5SGc2kzk6vAs
         lj+r/fYtcAAhmWf0YwIr+RIH0GagmV2bQV3gFbTGgm6NIncqIiOvG6bWZmHw6XQGzZch
         uxss7dyC9HqsrHyUoaLzymDQhQaaoZk5LPvFE=
Received: by 10.150.42.30 with SMTP id p30mr10121534ybp.122.1260168542569;
        Sun, 06 Dec 2009 22:49:02 -0800 (PST)
Received: from mailhub.coreip.homeip.net (c-24-6-153-137.hsd1.ca.comcast.net [24.6.153.137])
        by mx.google.com with ESMTPS id 7sm1916826ywc.21.2009.12.06.22.49.00
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 06 Dec 2009 22:49:01 -0800 (PST)
Date:   Sun, 6 Dec 2009 22:48:57 -0800
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Wu Zhangjin <wuzhangjin@gmail.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>, akpm@linux-foundation.org,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        "Rafael J . Wysocki" <rjw@sisk.pl>, zhangfx@lemote.com,
        linux-laptop@vger.kernel.org,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH v8 8/8] Loongson: YeeLoong: add input/hotkey driver
Message-ID: <20091207064857.GG21451@core.coreip.homeip.net>
References: <cover.1260082252.git.wuzhangjin@gmail.com> <b164d5bb79963a57621d024c22e5664de0ff8662.1260082252.git.wuzhangjin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b164d5bb79963a57621d024c22e5664de0ff8662.1260082252.git.wuzhangjin@gmail.com>
User-Agent: Mutt/1.5.19 (2009-01-05)
Return-Path: <dmitry.torokhov@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25341
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dmitry.torokhov@gmail.com
Precedence: bulk
X-list: linux-mips

Hi Wu,

On Sun, Dec 06, 2009 at 03:01:48PM +0800, Wu Zhangjin wrote:
> +
> +#define EC_VER_LEN 64
> +
> +static int black_screen_handler(int status)
> +{
> +	char *p, ec_ver[EC_VER_LEN];
> +
> +	p = strstr(loongson_cmdline, "EC_VER=");
> +	if (!p)
> +		memset(ec_ver, 0, EC_VER_LEN);
> +	else {
> +		strncpy(ec_ver, p, EC_VER_LEN);
> +		p = strstr(ec_ver, " ");
> +		if (p)
> +			*p = '\0';
> +	}
> +

Hmm, why do you copy and parse command lineinstead of using module
param and also doing it just once?

> +	/* Seems EC(>=PQ1D26) does this job for us, we can not do it again,
> +	 * otherwise, the brightness will not resume to the normal level! */
> +	if (strncasecmp(ec_ver, "EC_VER=PQ1D26", 64) < 0)
> +		yeeloong_lcd_vo_set(status);
> +
> +	return status;
> +}

Thanks.

-- 
Dmitry
