Return-Path: <SRS0=ixen=ZG=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97EFEC432C3
	for <linux-mips@archiver.kernel.org>; Thu, 14 Nov 2019 13:37:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BBFA206E1
	for <linux-mips@archiver.kernel.org>; Thu, 14 Nov 2019 13:37:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=zoho.com header.i=zhouyanjie@zoho.com header.b="jtcTtrw1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726678AbfKNNhk (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Thu, 14 Nov 2019 08:37:40 -0500
Received: from sender4-pp-o98.zoho.com ([136.143.188.98]:25871 "EHLO
        sender4-pp-o98.zoho.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726330AbfKNNhk (ORCPT
        <rfc822;linux-mips@vger.kernel.org>); Thu, 14 Nov 2019 08:37:40 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1573738644; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=FdOQiHFeC6aCmfyGmWisw36xuQYXQa4bK3Z1I6RlF0HbjWtTTPQmbVyaYTw7Jij1ZsTraydwLJ9Oioul/Uk23mX2pJZ8nw9gprNvxdNodtexjh473P3FSH6VhXmXvmX6o1TSpWNpjuWrPuy7a2f66SXC541tmyzho/eqJchnQQA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1573738644; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=NfiC+cinjSWRt41jD5jXQ2ueHOhgmVAdrHkxzjmGKlo=; 
        b=Tpo7W7Pf/wO3m8cUa+1PW0oe7gHnV9eIsgkHTdmYOABxxuZ3Cm77pZeFr8okldtBDEFa+aSBn5jT1HH130Hv3RHin/U2aZC/sBvePcLHoT7BnmHfRYIPCwPVueEZ2KIvvr5SYFD8ReU7wj3QCcTrF6OoFjRvNaZ4JOtkk9gGZWc=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=zoho.com;
        spf=pass  smtp.mailfrom=zhouyanjie@zoho.com;
        dmarc=pass header.from=<zhouyanjie@zoho.com> header.from=<zhouyanjie@zoho.com>
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; 
  s=zapps768; d=zoho.com; 
  h=subject:to:references:cc:from:message-id:date:user-agent:mime-version:in-reply-to:content-type; 
  b=er0q6KMsXWMJx/9NDexN/JHCN4w07a93L/INEGkUfisGFkd5a3rnxXM6dDDB0Ues5385ZXxO5yGX
    h7XxGVXuZZ7AF4ZsdJ1+jVk4Df7rqZDFvA7Jo+xolZ1+/tsxY7al  
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1573738644;
        s=zm2019; d=zoho.com; i=zhouyanjie@zoho.com;
        h=Subject:To:References:Cc:From:Message-ID:Date:MIME-Version:In-Reply-To:Content-Type:Content-Transfer-Encoding;
        l=1056; bh=NfiC+cinjSWRt41jD5jXQ2ueHOhgmVAdrHkxzjmGKlo=;
        b=jtcTtrw1onsboQFcintNiPlH2M8TzlpO6/Fuz7E0WVXcnxjOupxuYC4XojhVtISq
        wvovWpBafiQQsjrm0jsgtimzF6OrElCGXNa397kUjmxc04wPLMwDMGDywWwxaxG0IMf
        0VYkGfbE1Qr+Nldbcsg5rYJpEjnbm2JJfth17TIk=
Received: from [192.168.10.218] (171.221.112.167 [171.221.112.167]) by mx.zohomail.com
        with SMTPS id 15737386427141007.0962792641557; Thu, 14 Nov 2019 05:37:22 -0800 (PST)
Subject: Re: [PATCH 1/2 v3] dt-bindings: clock: Add X1000 bindings.
To:     Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>
References: <1571421006-12771-1-git-send-email-zhouyanjie@zoho.com>
 <1573378102-72380-1-git-send-email-zhouyanjie@zoho.com>
 <1573378102-72380-2-git-send-email-zhouyanjie@zoho.com>
 <20191112005544.GB7038@bogus> <20191113235955.927B6206EE@mail.kernel.org>
Cc:     linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        mturquette@baylibre.com, paul.burton@mips.com, robh+dt@kernel.org,
        syq@debian.org, mark.rutland@arm.com, paul@crapouillou.net
From:   Zhou Yanjie <zhouyanjie@zoho.com>
Message-ID: <5DCD5880.9090504@zoho.com>
Date:   Thu, 14 Nov 2019 21:37:04 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.8.0
MIME-Version: 1.0
In-Reply-To: <20191113235955.927B6206EE@mail.kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ZohoMailClient: External
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

Hi Stephen,

On 2019=E5=B9=B411=E6=9C=8814=E6=97=A5 07:59, Stephen Boyd wrote:
> Quoting Rob Herring (2019-11-11 16:55:44)
>> On Sun, 10 Nov 2019 17:28:21 +0800, Zhou Yanjie wrote:
>>> Add the clock bindings for the X1000 Soc from Ingenic.
>>>
>>> Signed-off-by: Zhou Yanjie <zhouyanjie@zoho.com>
>>> ---
>>>   .../devicetree/bindings/clock/ingenic,cgu.txt      |  1 +
>>>   include/dt-bindings/clock/x1000-cgu.h              | 44 +++++++++++++=
+++++++++
>>>   2 files changed, 45 insertions(+)
>>>   create mode 100644 include/dt-bindings/clock/x1000-cgu.h
>>>
>> Please add Acked-by/Reviewed-by tags when posting new versions. However,
>> there's no need to repost patches *only* to add the tags. The upstream
>> maintainer will do that for acks received on the version they apply.
>>
>> If a tag was not added on purpose, please state why and what changed.
> It looks like some extra defines were added. I carried forward your
> review tag.
>

I'm sorry that my mistake has caused you extra work,
I'll be careful to add tags next time.

Best regards!


