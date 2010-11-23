Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 23 Nov 2010 08:06:31 +0100 (CET)
Received: from mail-wy0-f177.google.com ([74.125.82.177]:59699 "EHLO
        mail-wy0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491121Ab0KWHGX convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 23 Nov 2010 08:06:23 +0100
Received: by wyf22 with SMTP id 22so8113344wyf.36
        for <multiple recipients>; Mon, 22 Nov 2010 23:06:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=fa5+JN7Vnmc6ILXELWRTUdO/QRPi0Gj7o3hFjuTtmfE=;
        b=VvYd4tAeqogKcz7zwMu42/sc8MaL/oSzCk1I+Y8rClJCH+5c7j6qlAmX9IvsItVS2/
         u3nSFAXnDSgS/KBRajdpspue+bb4FK5bKxu+EOtjg6B3w1PKQRYq9U9vSk0O/iwKmvua
         OYGYT3hHPgowktWNcLgPJfLOYoua0W/e4T4iU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=OojGxKHTZeDKqf/CzjWgh/rE0Sj7lkQBpo+Zx7pWsiUv3wWCJNnQ6PqiiKIAudyfWS
         F1pG1pw3+hQYbuqUZeJT6anzQuyUXr/qpNkAST/3USXRuVPDopO2loodZQHAwDmwDdxL
         Kw5U4VKTajnmKR9HyASrrVr0dAg9IYra0R+6o=
MIME-Version: 1.0
Received: by 10.216.54.147 with SMTP id i19mr544641wec.59.1290495977373; Mon,
 22 Nov 2010 23:06:17 -0800 (PST)
Received: by 10.216.236.138 with HTTP; Mon, 22 Nov 2010 23:06:17 -0800 (PST)
In-Reply-To: <20101119143416.GA5558@nowhere>
References: <1290063401-25440-1-git-send-email-dengcheng.zhu@gmail.com>
        <1290063401-25440-5-git-send-email-dengcheng.zhu@gmail.com>
        <20101119143416.GA5558@nowhere>
Date:   Tue, 23 Nov 2010 15:06:17 +0800
Message-ID: <AANLkTi=xZZMGdS62tdY62ifgEEV8Jpo5y5=MrCb5HvaK@mail.gmail.com>
Subject: Re: [PATCH 4/5] MIPS/Perf-events: Work with the new callchain interface
From:   Deng-Cheng Zhu <dengcheng.zhu@gmail.com>
To:     Frederic Weisbecker <fweisbec@gmail.com>
Cc:     ralf@linux-mips.org, a.p.zijlstra@chello.nl, will.deacon@arm.com,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        wuzhangjin@gmail.com, paulus@samba.org, mingo@elte.hu,
        acme@redhat.com
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Return-Path: <dengcheng.zhu@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28459
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dengcheng.zhu@gmail.com
Precedence: bulk
X-list: linux-mips

Yes, MIPS Perf-events got added in recently and missed some important
commits.


Thanks!

Deng-Cheng


2010/11/19 Frederic Weisbecker <fweisbec@gmail.com>:
> On Thu, Nov 18, 2010 at 02:56:40PM +0800, Deng-Cheng Zhu wrote:
>> This is the MIPS part of the following commits by Frederic Weisbecker:
>>
>> f72c1a931e311bb7780fee19e41a89ac42cab50e
>>       perf: Factorize callchain context handling
>> 56962b4449af34070bb1994621ef4f0265eed4d8
>>       perf: Generalize some arch callchain code
>> 70791ce9ba68a5921c9905ef05d23f62a90bc10c
>>       perf: Generalize callchain_store()
>> c1a65932fd7216fdc9a0db8bbffe1d47842f862c
>>       perf: Drop unappropriate tests on arch callchains
>>
>> Signed-off-by: Deng-Cheng Zhu <dengcheng.zhu@gmail.com>
>> ---
>
>
> Acked-by: Frederic Weisbecker <fweisbec@gmail.com>
>
> Why did I miss this arch? I did a grep on HAVE_PERF_EVENT or something,
> may be it hadn't it at that time?
>
> Thanks!
>
>
