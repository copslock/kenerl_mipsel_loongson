Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 30 Mar 2015 20:16:26 +0200 (CEST)
Received: from mail-ie0-f172.google.com ([209.85.223.172]:34702 "EHLO
        mail-ie0-f172.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27010002AbbC3SQYVvhZ5 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 30 Mar 2015 20:16:24 +0200
Received: by iedfl3 with SMTP id fl3so140826479ied.1
        for <linux-mips@linux-mips.org>; Mon, 30 Mar 2015 11:16:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=Q+8f1Yy674HM054ziy8BF955XbQAIh3atImx0nGyPbg=;
        b=luAImCu8hGhpx2q5uzlm0FkzQnSiF27m706VKnWx9nlBrpD1tnI3G29rnB8FiT/vRV
         opU5ElT/jBtMFp3MeBraPzV93TJP7TmVcyUc2YGEQ4fSNDNHLjrdLIcQ3gQvWlSXca6L
         DIMirPqTdfRQDrNRVItauMib+z6mEAEknaoNpcnKGSpCR6VRgpXxNM6BdWy50KT4+3Yr
         LUqpoYDjm5rRdhYuLS7GQfFauzp0phbtVQBXfcQuU83v/hbMgptfCxZRdMau/kWtwyrm
         n/V/yVncGeGF57T+Cbsj2wCpqN2ceG2Ed3RwyizNWAhz0TCEVWRwNcr44aequ0XmoyEz
         8wdQ==
X-Received: by 10.107.12.96 with SMTP id w93mr16306243ioi.10.1427739379597;
        Mon, 30 Mar 2015 11:16:19 -0700 (PDT)
Received: from dl.caveonetworks.com (64.2.3.194.ptr.us.xo.net. [64.2.3.194])
        by mx.google.com with ESMTPSA id gz4sm8293042igb.19.2015.03.30.11.16.17
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Mon, 30 Mar 2015 11:16:18 -0700 (PDT)
Message-ID: <551992F0.5050809@gmail.com>
Date:   Mon, 30 Mar 2015 11:16:16 -0700
From:   David Daney <ddaney.cavm@gmail.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130625 Thunderbird/17.0.7
MIME-Version: 1.0
To:     Aaro Koskinen <aaro.koskinen@iki.fi>
CC:     Wim Van Sebroeck <wim@iguana.be>,
        David Daney <david.daney@cavium.com>,
        linux-watchdog@vger.kernel.org, linux-mips@linux-mips.org
Subject: Re: [PATCH 1/3] watchdog: octeon: convert to WATCHDOG_CORE API
References: <1427565940-22951-1-git-send-email-aaro.koskinen@iki.fi>
In-Reply-To: <1427565940-22951-1-git-send-email-aaro.koskinen@iki.fi>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <ddaney.cavm@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46606
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

On 03/28/2015 11:05 AM, Aaro Koskinen wrote:
> Convert OCTEON watchdog to WATCHDOG_CORE API. This enables support
> for multiple watchdogs on OCTEON boards.
>
> Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
> ---
>   drivers/watchdog/Kconfig           |   1 +
>   drivers/watchdog/octeon-wdt-main.c | 185 ++++++++-----------------------------
>   2 files changed, 39 insertions(+), 147 deletions(-)
>
[...]

You didn't seem to say how it was tested.

If you have verified that "echo > /dev/watchdog" produces register dumps 
and reboots the board, then the whole series:

Acked-by: David Daney <david.daney@cavium.com>



Thanks for doing this, I had been meaning to make the conversion myself.

David.
