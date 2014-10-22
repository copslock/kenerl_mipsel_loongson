Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 22 Oct 2014 19:37:10 +0200 (CEST)
Received: from mail-pa0-f43.google.com ([209.85.220.43]:55789 "EHLO
        mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27012138AbaJVRhJRKqOE (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 22 Oct 2014 19:37:09 +0200
Received: by mail-pa0-f43.google.com with SMTP id lf10so4136214pab.2
        for <linux-mips@linux-mips.org>; Wed, 22 Oct 2014 10:37:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:subject:references
         :in-reply-to:content-type:content-transfer-encoding;
        bh=ByIGtAXr8RhXIFRuARXg7keaTxrbY7aTavMTSqNmIRg=;
        b=JsJFtXw3sVjSgXfCiUuWs3OuRn2vLPVdDQUC89ykIfaqZn/+QHsJ20yl9/yI31f9Sg
         ru6wO6nWYwjqiMsmbELIDa5KjM/iSDnOW0K3JqkHPgk+dswP1s/p8CJDD8MR7/ZNMT8U
         LAON603incGR38aA9bRpFn6ws3iNwSYRiJKoNCnb3xGu/dgo39ASDkVlbdKB8D15Wf3N
         ccSlNQGdgqq3/dDgZh4JvbC+aS1nHeDkcW9HGgVoM7Jdh+S0SM/Mzs+IZQ4uIY54cGGk
         2CAfKjbXk8ND+s5ymuBlt6GJ0UurpePbQChX+UWEQs070qlAsZiOrMNTwT06w4NHiCOv
         4nfg==
X-Received: by 10.70.88.202 with SMTP id bi10mr24477069pdb.119.1413999422518;
        Wed, 22 Oct 2014 10:37:02 -0700 (PDT)
Received: from [10.12.164.252] (5520-maca-inet1-outside.broadcom.com. [216.31.211.11])
        by mx.google.com with ESMTPSA id jq5sm14696382pbc.32.2014.10.22.10.37.01
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 22 Oct 2014 10:37:01 -0700 (PDT)
Message-ID: <5447EB2A.3030001@gmail.com>
Date:   Wed, 22 Oct 2014 10:36:42 -0700
From:   Florian Fainelli <f.fainelli@gmail.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.2.0
MIME-Version: 1.0
To:     John Crispin <blogic@openwrt.org>, linux-mips@linux-mips.org
Subject: Re: Single MIPS kernel
References: <20141022083437.GB18581@linux-mips.org> <54478C94.4060208@openwrt.org>
In-Reply-To: <54478C94.4060208@openwrt.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43496
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: f.fainelli@gmail.com
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

On 10/22/2014 03:53 AM, John Crispin wrote:
> Hi Ralf,
> 
> On 22/10/2014 10:34, Ralf Baechle wrote:
>> This question comes up every once in a while and I've also been
>> approached during ELCE in Düsseldorf why there is no single MIPS
>> kernel for all platforms, so I thought I should post a writeup on
>> the topic.
>>
> 
> for the SoCs supported by OpenWrt this is a no-go. we are already
> having a hard time fighting bloat. to get the images to fit we need to
> already build device specific images that only hold the DT, drivers,
> ... that a specific board needs. having a kernel that can boot on X
> devices wont even fit into flash and if it does there is not space
> left for the userland.

A multi-platform kernel should allow to compile in/out specific
platforms (like what ARM does), such that we can still achieve a small
kernel goal in OpenWrt.

> 
> I think this feature is only interesting for the older platforms and
> the upcoming mobile SoC based in MIPS. i.e. the users are debian and
> android type device.

You mean, older systems such as Sibyte, the SGI's IPxx and similar?
Those may have memory architecture requirements (spaces.h) that make it
difficult if possible to support.
--
Florian
