Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 05 Feb 2016 02:32:07 +0100 (CET)
Received: from mail-pf0-f195.google.com ([209.85.192.195]:35688 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011746AbcBEBcGLkhEM (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 5 Feb 2016 02:32:06 +0100
Received: by mail-pf0-f195.google.com with SMTP id 66so4537790pfe.2;
        Thu, 04 Feb 2016 17:32:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=938vYcb0TdCZMtG2FgokJaCHbvfibNpFTGnJJ2bNzG8=;
        b=hVaPTCQ3p9i0mpZmOc3A3Ho00zJtULusEz6m0QOxFf3qMCdveKyzxhEF+prCRCtyFm
         tESMG3vK5YVkGazV6Kqwz5JKZ97YEjTjfWbUgB4krYJh3OvkhuSSP8gSMW063MaK10d1
         EwL5hIjXkALEqSuZZu5qvua2Ve3W29Aq6xlnEu0KwWxRGsOavgwciJ+0JXOiREkKyx3H
         cuTkzqgTTkYYN4g+d17VRJ0sLsC4Z7AxA8iQ2DDR2CZTo94nPtCco8CK7IKFFHY3SsEV
         PUyZQp+yW3Lkz0d54Ryv3tdErmhVLo4AQ+wOKVx2hd2N9flUwTw+I4BISGcpDz5A1tvU
         +/yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:date:from:user-agent:mime-version:to
         :cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=938vYcb0TdCZMtG2FgokJaCHbvfibNpFTGnJJ2bNzG8=;
        b=YqUMuriahYsftFFsTI8SNuG2ydjyZpAbnI5zLubtXxCjhlFzA3PweWgisyGwJXzK0U
         MJwlNX7cbtjQeRyjDJd1jxipmzBafRJwsF8V/MrMhVhKmsxvjRUWuIddcgc9UIS/HxvM
         31Ugk/M60kGCoOv0fVbLLYI2a5rcoX84q7iQm2bycbPN/3a9STVwHQ5qeZAsVw4AoZ2D
         ljipX3+ZCjw2HY4FI7Zv9bWvL8z78I/Sa2zgYiQt2Nd16KccFSEbEBGm1Sq8RwWlLOYe
         XxHng/6nT2PFVBlJDcplHUcfZ/y8adBMfaZT9ZBHlMSBYFNv6Mu5wOk4whqMwakUqX0/
         Bg3Q==
X-Gm-Message-State: AG10YOTQhnR0jkPfox205ZhfCQ+zjRK7Zz+VGJ+83tFOU0GlmG/7Xu6dpKMOCgbUaiHGMA==
X-Received: by 10.98.72.77 with SMTP id v74mr15234781pfa.33.1454635918462;
        Thu, 04 Feb 2016 17:31:58 -0800 (PST)
Received: from dl.caveonetworks.com ([64.2.3.194])
        by smtp.googlemail.com with ESMTPSA id ze5sm19941468pac.32.2016.02.04.17.31.56
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 04 Feb 2016 17:31:56 -0800 (PST)
Message-ID: <56B3FB8B.1050001@gmail.com>
Date:   Thu, 04 Feb 2016 17:31:55 -0800
From:   David Daney <ddaney.cavm@gmail.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130625 Thunderbird/17.0.7
MIME-Version: 1.0
To:     Aaro Koskinen <aaro.koskinen@iki.fi>
CC:     linux-mips@linux-mips.org, ralf@linux-mips.org,
        linux-kernel@vger.kernel.org, David Daney <david.daney@cavium.com>,
        Rob Herring <robh+dt@kernel.org>,
        Pawel Moll <pawel.moll@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        Kumar Gala <galak@codeaurora.org>, devicetree@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 0/7] MIPS: Add support for OCTEON cn78xx and cn73xx.
References: <1454632974-7686-1-git-send-email-ddaney.cavm@gmail.com> <20160205012235.GF1620@darkstar.musicnaut.iki.fi>
In-Reply-To: <20160205012235.GF1620@darkstar.musicnaut.iki.fi>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <ddaney.cavm@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51803
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney.cavm@gmail.com
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

On 02/04/2016 05:22 PM, Aaro Koskinen wrote:
> Hi,
>
> On Thu, Feb 04, 2016 at 04:42:47PM -0800, David Daney wrote:
>> From: David Daney <david.daney@cavium.com>
>>
>> The OCTEON III cn78xx and cn73xx family of SoCs has some architectural
>> differences from previous OCTEON processors.
>
> Did you test this series also on older OCTEONs? A lot of common files
> seems to be modified, so it would be good to describe how it was tested.
>

Yes, I tried to be very careful not to break things that already work.

Tested on:

  CN7890 -- OCTEON III
  CN7360 -- OCTEON III
  CN5750 -- OCTEON Plus


In the case of CN5750, I booted a full Debian system from the on-board 
CF with no problem.

In any event, this is code that we have been running internally across 
all OCTEON models for several years.

David.
