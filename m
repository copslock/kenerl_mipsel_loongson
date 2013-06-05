Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 05 Jun 2013 20:21:10 +0200 (CEST)
Received: from mail-pa0-f47.google.com ([209.85.220.47]:37260 "EHLO
        mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6827525Ab3FESVIM6k4b (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 5 Jun 2013 20:21:08 +0200
Received: by mail-pa0-f47.google.com with SMTP id kl13so1157584pab.6
        for <multiple recipients>; Wed, 05 Jun 2013 11:21:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=ThZVORba/11h8vXSsNXuALI8mK4t1DCxQE6dWi+8cnY=;
        b=uJz9MS1hY6+0YsbpOAFiflonUN3f+pp86KnO9muJoGvUxFVuWlSrDjVgy6JQqPXJIU
         D7CrpsXLgpbcWk8skMKVF/0VsezVIqzqd29Z19KG/EA+V8WRxFbYYtrFhTYbt6n801ec
         d6FLN6S4yViRCKZU3vQxui024wjxMClprA+bPoCMt6DDjV5crw/e/OEnyTyfmPp85JLt
         Mrf1+yEd8xYcENq0728mJzOWJZY5EIud8SVeZkd8Lf+ccjhHQfvN2QTijkcY8Ue3D/GC
         sfh/194/D1QqjdWqkm7TcEYlPv5jLc72hZvSw+RK27NK1mvchcDnKh88MaoL86MrXXqa
         F+6w==
X-Received: by 10.66.192.7 with SMTP id hc7mr35086942pac.206.1370456460907;
        Wed, 05 Jun 2013 11:21:00 -0700 (PDT)
Received: from dl.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPSA id fn9sm73756395pab.2.2013.06.05.11.20.59
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Wed, 05 Jun 2013 11:21:00 -0700 (PDT)
Message-ID: <51AF818A.6020400@gmail.com>
Date:   Wed, 05 Jun 2013 11:20:58 -0700
From:   David Daney <ddaney.cavm@gmail.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130311 Thunderbird/17.0.4
MIME-Version: 1.0
To:     "Steven J. Hill" <Steven.Hill@imgtec.com>, ralf@linux-mips.org
CC:     linux-mips@linux-mips.org
Subject: Re: [PATCH v4] MIPS: micromips: Fix improper definition of ISA exception
 bit.
References: <1370455529-19621-1-git-send-email-Steven.Hill@imgtec.com>
In-Reply-To: <1370455529-19621-1-git-send-email-Steven.Hill@imgtec.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <ddaney.cavm@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36698
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

On 06/05/2013 11:05 AM, Steven J. Hill wrote:
> The ISA exception bit selects whether exceptions are taken in classic
> or microMIPS mode. This bit is Config3.ISAOnExc and was improperly
> defined as bits 16 and 17 instead of just bit 16. A new function was
> added so that platforms could set this bit when running a kernel
> compiled with only microMIPS instructions.
>
> Signed-off-by: Steven J. Hill <Steven.Hill@imgtec.com>

This looks good now,
Acked-by: David Daney <david.daney@cavium.com>

> ---
> Changes in v4:
> * Removed code from 'cpu-probe.c' and added new inline function to
>    set exception mode.
> * Reworded and simplified commit message.
>
>   arch/mips/include/asm/mipsregs.h |   17 ++++++++++++++++-
>   arch/mips/kernel/cpu-probe.c     |    3 ---
>   arch/mips/mti-malta/malta-init.c |    2 ++
>   arch/mips/mti-sead3/sead3-init.c |    2 ++
>   4 files changed, 20 insertions(+), 4 deletions(-)
>
