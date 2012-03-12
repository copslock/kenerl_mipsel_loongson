Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 12 Mar 2012 19:00:17 +0100 (CET)
Received: from mail-ee0-f49.google.com ([74.125.83.49]:43024 "EHLO
        mail-ee0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903607Ab2CLR75 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 12 Mar 2012 18:59:57 +0100
Received: by eekb45 with SMTP id b45so1575926eek.36
        for <multiple recipients>; Mon, 12 Mar 2012 10:59:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:message-id:date:from:organization:user-agent:mime-version:to
         :cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=krrrIeZEoK84wf8W9pCPEJm1+SRSZXAkuPT4wSctbWQ=;
        b=AGZO6QQFRVr7IMH7hF8AoA7XhyI1E3+krzm0B6o0PGQRw48bGSD4yaqcGka2g0I/L/
         TwJOnCX/bSMOg2VlyYmUPxpifpVQ1e5GrygMfGHnNkHDZ6TQVDvSHA1QSWNXi7SmXrMp
         hYQZSUGWWei/pAEN33FNfJfRAhe/09Q4gGjNXCrxBlm/yIrpNNGQfZOp+c4oMPHeSvwa
         L6KAtdj9m52xe2BqEKumxwleglvHKNN04srZE+I5uPQRREaG+qPi/87txFlM1WZy+fTg
         B1RZY6iK8T3PPno0Qsultr+Fez2rWWk2UVAYaFc9wHTmmya4Wm1Y4g4RCiBl8SZvCKZ5
         ZJYw==
Received: by 10.213.114.7 with SMTP id c7mr985680ebq.144.1331575191806;
        Mon, 12 Mar 2012 10:59:51 -0700 (PDT)
Received: from [192.168.108.37] (freebox.vlq16.iliad.fr. [213.36.7.13])
        by mx.google.com with ESMTPS id r44sm14965613eef.2.2012.03.12.10.59.49
        (version=SSLv3 cipher=OTHER);
        Mon, 12 Mar 2012 10:59:49 -0700 (PDT)
Message-ID: <4F5E395F.9020603@openwrt.org>
Date:   Mon, 12 Mar 2012 18:58:55 +0100
From:   Florian Fainelli <florian@openwrt.org>
Organization: OpenWrt
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:10.0.2) Gecko/20120216 Thunderbird/10.0.2
MIME-Version: 1.0
To:     "John W. Linville" <linville@tuxdriver.com>
CC:     Julian Calaby <julian.calaby@gmail.com>,
        Hauke Mehrtens <hauke@hauke-m.de>, gregkh@linuxfoundation.org,
        stern@rowland.harvard.edu, linux-mips@linux-mips.org,
        ralf@linux-mips.org, m@bues.ch, linux-usb@vger.kernel.org,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
        linux-wireless@vger.kernel.org
Subject: Re: [PATCH 3/7] bcma: scan for extra address space
References: <1331496505-18697-1-git-send-email-hauke@hauke-m.de> <1331496505-18697-4-git-send-email-hauke@hauke-m.de> <CAGRGNgX116dRB03NTL_DFZ4b_PYcdY+Un_cVwt6ZUGR1bwZzHA@mail.gmail.com> <4F5D3679.3090900@hauke-m.de> <CAGRGNgWsO9s2rW1pKBFWd_-0oTAGs9_RXNGyn_y7ic=0Zer=qQ@mail.gmail.com> <20120312174113.GC2778@tuxdriver.com>
In-Reply-To: <20120312174113.GC2778@tuxdriver.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-archive-position: 32656
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian@openwrt.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>



Le 03/12/12 18:41, John W. Linville a écrit :
> On Mon, Mar 12, 2012 at 12:30:54PM +1100, Julian Calaby wrote:
>> Hi Hauke,
>>
>> On Mon, Mar 12, 2012 at 10:34, Hauke Mehrtens<hauke@hauke-m.de>  wrote:
>
>>> I will fix this, should I resend the hole series or just this patch?
>>
>> I'm not sure the rest of the series made it to linux-wireless, so
>> maybe you should resend everything.
>
> FWIW, this was the only one I saw...

For some reasons I received it from linux-mips-bounces using another 
email account, but only patch 3 CC'd linux-wireless.
--
Florian
