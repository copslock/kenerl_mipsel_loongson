Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 14 Jan 2008 13:59:13 +0000 (GMT)
Received: from fg-out-1718.google.com ([72.14.220.156]:22403 "EHLO
	fg-out-1718.google.com") by ftp.linux-mips.org with ESMTP
	id S20029935AbYANN7D (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 14 Jan 2008 13:59:03 +0000
Received: by fg-out-1718.google.com with SMTP id d23so2146474fga.32
        for <linux-mips@linux-mips.org>; Mon, 14 Jan 2008 05:59:03 -0800 (PST)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:organization:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        bh=YQejBTUlkPOV+1TR5PyMRReEREXixp/NyIEsUMUyXFE=;
        b=JhSvYdGHbuoXk/onfTjIBtRzErQPUCb7lEcOleaNdbYuw11HguTk2Ou5ifb5JY/+3Hfmmho6X30rENrTiCwIwvfrmyoOsBDlYn/ZMTAkm131uUoaHtPmbl0azHErPUxfYnWvWTZCEixF2dc8g9LLM3cPDV1oGKB4ZUY/DT4JdzE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:organization:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=du8mPNmWUGHyobZuEdDXwEMkmUNUOjVg+P7me35y1JcS5YOuh0vHrx4ulqcWQp6br8iZA66G/dLhCbQ0fOrD2AoxubgzV74WvlE1VzKIQmS/7LGfRfHSGO+p0slchVeeoIlwcCvIGTMe8IeJP/c/w+HOs4uIK9VsZRtf8xb2rf0=
Received: by 10.86.97.7 with SMTP id u7mr6238621fgb.54.1200319143420;
        Mon, 14 Jan 2008 05:59:03 -0800 (PST)
Received: from ?192.168.1.3? ( [91.76.31.112])
        by mx.google.com with ESMTPS id d4sm5047105fga.2.2008.01.14.05.59.01
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 14 Jan 2008 05:59:01 -0800 (PST)
Message-ID: <478B6AA3.2070402@gmail.com>
Date:	Mon, 14 Jan 2008 16:58:59 +0300
From:	Dmitri Vorobiev <dmitri.vorobiev@gmail.com>
Organization: DmVo Home
User-Agent: Thunderbird 1.5.0.14pre (X11/20071022)
MIME-Version: 1.0
To:	Ralf Baechle <ralf@linux-mips.org>
CC:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>, linux-mips@linux-mips.org
Subject: Re: [PATCH] prom_free_prom_memory for QEMU
References: <20080114.212253.126142719.anemo@mba.ocn.ne.jp> <20080114133701.GA16555@linux-mips.org>
In-Reply-To: <20080114133701.GA16555@linux-mips.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-Path: <dmitri.vorobiev@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18022
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dmitri.vorobiev@gmail.com
Precedence: bulk
X-list: linux-mips

Ralf Baechle wrote:
> On Mon, Jan 14, 2008 at 09:22:53PM +0900, Atsushi Nemoto wrote:
> 
>> You can get 60kb more memory by this patch.  Note that this patch
>> might cause segfault on some intermediate version of qemu 0.9.0 and
>> 0.9.1 (For example Debian qemu-0.9.0+20070816-1).
> 
> I was actually planning to remove the Qemu platform for 2.6.25.  The
> Malta emulation has become so good that there is no more point in having
> the underfeatured synthetic platform that CONFIG_QEMU is.

I wholeheartedly agree with that. It is a godsend to me that I can use
identical configs to build the kernels for QEMU and for a physical Malta.
Emulation is more convenient to me because QEMU boots and runs faster
than the board I'm working with. Many thanks for that to QEMU developers.

Off the topic, how about the plans to remove Atlas support?

Dmitri

> 
> Objections?
> 
>   Ralf
> 
> 
