Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 22 Mar 2016 16:38:59 +0100 (CET)
Received: from mail-pf0-f179.google.com ([209.85.192.179]:34056 "EHLO
        mail-pf0-f179.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27024753AbcCVPi6SWUke (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 22 Mar 2016 16:38:58 +0100
Received: by mail-pf0-f179.google.com with SMTP id x3so316206195pfb.1
        for <linux-mips@linux-mips.org>; Tue, 22 Mar 2016 08:38:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=hurleysoftware-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=GOgRCOqL4aMyn473xljwZDAIvLEkxW84LZwg6+Ivt3Y=;
        b=HR1+oHSytx0bobixNUHoAlypHyO2DbbB7hkxZ1X0QX56Ky+XPN8NhnydwKOKWZdJ2V
         bC2TCneMk4cur92WO17t74UQ4AVHTBU8ApoQ57sN6fMtyp3dzCwoGccxwcJQKGpgjRTI
         aDQnc2e26VSMD6e5OPoMbLZXGytogFKtxp5BJ3K10Hrd2hjb0kE7Yjf9Ejxa0+u9Jllp
         OFE1nSKSvJIaw5FJ5im7Ul/NgZaL7/k/knnn+hU6ZXEEEz0+z9ZvE3WS1DpD7DKFnXEh
         eDLcw9SH8JpQW7FrYqFZzTANREca918O5Uk8p0h7LfZgmpb0r20hj81i/NVWfUqhXwbq
         EuCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=GOgRCOqL4aMyn473xljwZDAIvLEkxW84LZwg6+Ivt3Y=;
        b=AxxSQYa1MT+ZZkTacUyA3w8AQWhRBYVqsZLNqv53Ob6VOsRKFlfD+LE+bE469sc4eM
         G6LwgWlQSWigTU0hqfwvx4cRgeUC+SgT3qvy5jdo2CN0sqbP+06T/D0q2q1lJNAjXaFp
         XvDoYnc77yXkuc/t1g9pH6+sWj2zbFtJSr6oG7Qhxs3Mr1FvTkVX1JqrqQ/cI8jl84Bu
         zNUCZx+SnWbsvjKrDPsb+sj9v/tjckrqiGKDXHGL3NecgmRQ4u+4Z/QuZx9YLQ3a5Har
         w3PoLAVDL4q41MNhutG0W0670lfYDb1YP9WEmga/BqPl/f9lpJt0WmEcUshPycMF6oll
         agUA==
X-Gm-Message-State: AD7BkJKmj/QxVczbz6Rl2SKCJrOnDUunjmKx+RAGjfTzYmKaXtaWwoPNuWsYbKEHRQFd2Q==
X-Received: by 10.98.13.130 with SMTP id 2mr54971852pfn.97.1458661132359;
        Tue, 22 Mar 2016 08:38:52 -0700 (PDT)
Received: from [192.168.1.20] (50-1-116-74.dsl.dynamic.fusionbroadband.com. [50.1.116.74])
        by smtp.gmail.com with ESMTPSA id 62sm49201163pfk.83.2016.03.22.08.38.51
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 22 Mar 2016 08:38:51 -0700 (PDT)
Subject: Re: Nonterministic hang during bootconsole/console handover on ath79
To:     Matthias Schiffer <mschiffer@universe-factory.net>
References: <56F07DA1.8080404@universe-factory.net>
 <56F0B189.2080206@hurleysoftware.com> <56F143A8.6020601@universe-factory.net>
Cc:     Ralf Baechle <ralf@linux-mips.org>, gregkh@linuxfoundation.org,
        jslaby@suse.com, linux-mips@linux-mips.org,
        linux-serial@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
From:   Peter Hurley <peter@hurleysoftware.com>
Message-ID: <56F16708.4020109@hurleysoftware.com>
Date:   Tue, 22 Mar 2016 08:38:48 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.6.0
MIME-Version: 1.0
In-Reply-To: <56F143A8.6020601@universe-factory.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-Path: <peter@hurleysoftware.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52677
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: peter@hurleysoftware.com
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

On 03/22/2016 06:07 AM, Matthias Schiffer wrote:
> I've tried your patch and I can't reproduce the issue anymore with it; I
> have no idea if this actually has to do something with the issue, or the
> change of the code path just hid the bug again.
> 
> Regarding your other mail: with "small change", I was not talking about
> adding an additional printk; as mentioned, even changing the numbers in
> UTS_VERSION can hide the issue. I diffed a working and a broken kernel
> image, and the UTS_VERSION is really the only difference. I have no idea
> how to explain this.

If _any_ change may hide the problem, that will make it impossible
to determine if any attempted fix actually works, regardless of what
debugging method you use.

FWIW, you could still use the boot console to debug the problem by
disabling the regular command-line console.

Regards,
Peter Hurley


> (OpenWrt uses an LZMA-compressed kernel image, so
> after compression, the differences are much greater; but how these
> differences would affect the kernel after decompression eludes me)
> 
> I'll continue searching for a board with accessible JTAG which exhibits
> this issue. Given the heisenbuggy nature of the issue, getting to the root
> cause is probably impossible without JTAG unless someone has an obvious
> explanation...
> 
> Thanks,
> Matthias
> 
