Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 12 Dec 2014 02:54:44 +0100 (CET)
Received: from mail-pd0-f177.google.com ([209.85.192.177]:39491 "EHLO
        mail-pd0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27008569AbaLLBymfPldI (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 12 Dec 2014 02:54:42 +0100
Received: by mail-pd0-f177.google.com with SMTP id ft15so6050232pdb.8
        for <multiple recipients>; Thu, 11 Dec 2014 17:54:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=MVpaz6g0BsswlmAKU6RyN//C8FzCGylzmLwice02WkA=;
        b=YnVSp5cviBXQzwG0CPlWZLsD8kS+DQkkoeHQ63h2RFNRf+B6nGrPNagYUi8vcCDvZp
         ii2YQQVEpL6ovX3dvjY7j+XV0gNkLh+tDc4VarD1fdisIxvZKvqo+dJBNOByU2IaFfsm
         O/aWXcz7vTjTKhJqaikdCn9Fy+qSAMWarcPKTjX0Ti3qs/E1Co94dY3xBaaAtRehW8Nl
         y5AiCakIRB4OGr2lKt7KI7dJaxgQQzr6OrYMecMX7v/X5d0mBj+3LcWtcVuqHxDdWfsz
         6EM/jTy42DMBxc66TYPtTmc2odVBetPpFfBaH45aE6Mw59uv/4ogY9PNQgV6PV4rH+DP
         bJaQ==
X-Received: by 10.66.124.136 with SMTP id mi8mr22481941pab.105.1418349276298;
        Thu, 11 Dec 2014 17:54:36 -0800 (PST)
Received: from [10.12.164.252] (5520-maca-inet1-outside.broadcom.com. [216.31.211.11])
        by mx.google.com with ESMTPSA id th7sm2476388pac.47.2014.12.11.17.54.35
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Dec 2014 17:54:35 -0800 (PST)
Message-ID: <548A4ACC.9050106@gmail.com>
Date:   Thu, 11 Dec 2014 17:54:20 -0800
From:   Florian Fainelli <f.fainelli@gmail.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.3.0
MIME-Version: 1.0
To:     Ralf Baechle <ralf@linux-mips.org>,
        Kevin Cernekee <cernekee@gmail.com>
CC:     Linux MIPS Mailing List <linux-mips@linux-mips.org>
Subject: Re: MIPS in 3.19
References: <20141211132746.GF31723@linux-mips.org> <CAJiQ=7C=WTzOKJ4CPGH3zB4hTr=RkF1ywn9bHs2DXpPRmwpCKg@mail.gmail.com> <20141211212240.GA6477@linux-mips.org>
In-Reply-To: <20141211212240.GA6477@linux-mips.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44622
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

On 11/12/14 13:22, Ralf Baechle wrote:
> On Thu, Dec 11, 2014 at 11:19:53AM -0800, Kevin Cernekee wrote:
> 
>> On Thu, Dec 11, 2014 at 5:27 AM, Ralf Baechle <ralf@linux-mips.org> wrote:
>>>
>>> Kevin Cernekee (15):
>>>       Documentation: DT: Add entries for BCM3384 and its peripherals
>>
>>>       MIPS: bcm3384: Initial commit of bcm3384 platform support
>>>       MAINTAINERS: Add entry for BCM33xx cable chips
>>
>> Hi Ralf,
>>
>> Could we drop/revert these three patches for now, and then use the
>> "BMIPS Generic target V4" patch series to support BCM3384?  The BMIPS
>> Generic series incorporates a great deal of helpful feedback from Arnd
>> and others, and it also runs on 5+ other chips.
>>
>> It is OK if it isn't merged until 3.20+.  No rush.
> 
> Too late - the pull request to Linus is out.

Ralf, you applied the patches without email notice, Kevin asked you to
drop them way before sending a pull request while he was posting v2-3-4
of his patch set, and now he has to deal with potential reverts, this is
counter productive.

I do not see the MIPS pull request anywhere in public email archives, so
we could not even say "wait" before this went out to Linus.
--
Florian
