Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 21 Nov 2011 00:28:08 +0100 (CET)
Received: from terminus.zytor.com ([198.137.202.10]:38559 "EHLO mail.zytor.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1903681Ab1KTX2A (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 21 Nov 2011 00:28:00 +0100
Received: from tazenda.hos.anvin.org ([IPv6:2001:470:861f::feed:face:f00d])
        (authenticated bits=0)
        by mail.zytor.com (8.14.5/8.14.5) with ESMTP id pAKNRsTb029512
        (version=TLSv1/SSLv3 cipher=DHE-RSA-CAMELLIA256-SHA bits=256 verify=NO);
        Sun, 20 Nov 2011 15:27:55 -0800
Message-ID: <4EC98CF5.3070500@kernel.org>
Date:   Sun, 20 Nov 2011 15:27:49 -0800
From:   "H. Peter Anvin" <hpa@kernel.org>
Organization: Linux Kernel Organization, Inc.
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:7.0.1) Gecko/20110930 Thunderbird/7.0.1
MIME-Version: 1.0
To:     David Daney <ddaney.cavm@gmail.com>
CC:     linux-mips@linux-mips.org, ralf@linux-mips.org,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-embedded@vger.kernel.org, x86@kernel.org,
        David Daney <david.daney@cavium.com>
Subject: Re: [PATCH RFC 1/5] scripts: Add sortextable to sort the kernel's
 exception table.
References: <1321645068-20475-1-git-send-email-ddaney.cavm@gmail.com> <1321645068-20475-2-git-send-email-ddaney.cavm@gmail.com> <4EC98C97.50604@kernel.org>
In-Reply-To: <4EC98C97.50604@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-archive-position: 31832
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hpa@kernel.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 16807

On 11/20/2011 03:26 PM, H. Peter Anvin wrote:
> On 11/18/2011 11:37 AM, David Daney wrote:
>> From: David Daney <david.daney@cavium.com>
>>
>> Using this build-time sort saves time booting as we don't have to burn
>> cycles sorting the exception table.
>>
> 
> If we're going to do this at build time, I would suggest using a
> collisionless hash instead.  The lookup time for those are O(1), but
> they definitely need to be done at build time.
> 

I have some code for generating these kinds of tables, they just need to
be hooked up.  I will dig it up later today or tomorrow.

	-hpa
