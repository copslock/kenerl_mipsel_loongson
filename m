Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 07 Jan 2015 20:33:14 +0100 (CET)
Received: from mail-ie0-f176.google.com ([209.85.223.176]:40848 "EHLO
        mail-ie0-f176.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27010714AbbAGTdMiKS3W (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 7 Jan 2015 20:33:12 +0100
Received: by mail-ie0-f176.google.com with SMTP id tr6so5577841ieb.7;
        Wed, 07 Jan 2015 11:33:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=kMFShzA1FZtvOifLo2WnG617pvR53GMQrmia10gmpvE=;
        b=FGcpBWWfex6AOJLZedLa47EzJ64OqE0lmtFpbSC60vyAJBZFs7DB6o0nwcP74e9ZB+
         V37dq/nvbNmzUyj78YciDmmcoXkMmoLmCHK6NjAj4XzRhPyls5tnmyRuXXKxvnPIUvsA
         ra4xq0lztllP7393RrKSn15H7YJYEwA9B4oecVMAkhkTj0ZIh5ahNDbrWzqTo+7yoO6H
         3estYM4bera7lRfqVZmaW5TD6vkW/YoB7rI/mVo0TWpCgs62Odky85dP0Z0NyOy+RR8Q
         TRDGA9f+lWNY0qkYZEkf/mcl+/l2KFEEU3ZOXaq2cGwzuaId1Inr1k6O1Zs82N0bWeY7
         y1Rg==
X-Received: by 10.50.62.104 with SMTP id x8mr23933635igr.2.1420659186152;
        Wed, 07 Jan 2015 11:33:06 -0800 (PST)
Received: from dl.caveonetworks.com (64.2.3.194.ptr.us.xo.net. [64.2.3.194])
        by mx.google.com with ESMTPSA id n4sm6857695igr.15.2015.01.07.11.33.05
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Wed, 07 Jan 2015 11:33:05 -0800 (PST)
Message-ID: <54AD89F0.2020709@gmail.com>
Date:   Wed, 07 Jan 2015 11:33:04 -0800
From:   David Daney <ddaney.cavm@gmail.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130625 Thunderbird/17.0.7
MIME-Version: 1.0
To:     Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
CC:     Jayachandran C <jchandra@broadcom.com>, linux-mips@linux-mips.org,
        ralf@linux-mips.org
Subject: Re: [PATCH 13/17] MIPS: Netlogic: Handle XLP hardware errata
References: <1420630118-17198-1-git-send-email-jchandra@broadcom.com> <1420630118-17198-14-git-send-email-jchandra@broadcom.com> <54AD6B19.3020007@cogentembedded.com>
In-Reply-To: <54AD6B19.3020007@cogentembedded.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <ddaney.cavm@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45008
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

On 01/07/2015 09:21 AM, Sergei Shtylyov wrote:
> Hello.
>
> On 01/07/2015 02:28 PM, Jayachandran C wrote:
[...]
>> +
>> +    /* thread 0 of each core. */
>> +    li    t0, CKSEG1ADDR(RESET_DATA_PHYS)
>
>     Hm, does this get auto-expanded into several instructions?
>

Of course, it is a standard magic MIPS assembler macro that expands to 
the instructions necessary to load a 32-bit integer constant into the 
register.  It is perfectly normal and acceptable code.

David Daney
