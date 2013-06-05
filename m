Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 05 Jun 2013 23:30:55 +0200 (CEST)
Received: from mail-la0-f44.google.com ([209.85.215.44]:50281 "EHLO
        mail-la0-f44.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6835054Ab3FEVauOmRVY (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 5 Jun 2013 23:30:50 +0200
Received: by mail-la0-f44.google.com with SMTP id er20so1933944lab.31
        for <linux-mips@linux-mips.org>; Wed, 05 Jun 2013 14:30:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=message-id:date:from:organization:user-agent:mime-version:to:cc
         :subject:references:in-reply-to:content-type
         :content-transfer-encoding:x-gm-message-state;
        bh=Wr99FJEW/9Gb4IgSXtJjF/fpgTF7SrY7G4YbixoQyGI=;
        b=EFQPSBqRP1SOpfSlWIjxcYmMVpHsBnhZwG3rzexd+txm3lFD6lAWESZpq0bOLtVtLq
         tdLt6RyBpPcsX4lWtSMJ4z7WGOwXW+l4ErXmFSHv4K3SOUXpDEqh5K8r3x4zSXEgmtWX
         2+40M4aqi0ojXiOW0kSElmjgoOSM+p5wgZdNHVhoPiEiIHH74ojkZLCiHKfZoFeOfzyS
         /7EGrDJeqFKtZZ1tmt/IBxwiKxJtbPKt78QdUNOuv/F8WWpTlooZtL6+85CpoHFvfC2Q
         ur2Cr1RZOflHL/hAgJ5S7vA2aN4zrmTxGZ/FRtLAWtlej8D/FSxdMs1U/cueJxDyi/zC
         EDfQ==
X-Received: by 10.112.11.137 with SMTP id q9mr16078474lbb.24.1370467844494;
        Wed, 05 Jun 2013 14:30:44 -0700 (PDT)
Received: from wasted.dev.rtsoft.ru (ppp91-76-88-205.pppoe.mtu-net.ru. [91.76.88.205])
        by mx.google.com with ESMTPSA id i2sm6593727lah.5.2013.06.05.14.30.42
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 05 Jun 2013 14:30:43 -0700 (PDT)
Message-ID: <51AFAE0A.8000308@cogentembedded.com>
Date:   Thu, 06 Jun 2013 01:30:50 +0400
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Organization: Cogent Embedded
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:17.0) Gecko/20130509 Thunderbird/17.0.6
MIME-Version: 1.0
To:     David Daney <ddaney.cavm@gmail.com>
CC:     "Steven J. Hill" <Steven.Hill@imgtec.com>,
        linux-mips@linux-mips.org, ralf@linux-mips.org
Subject: Re: [PATCH v6] MIPS: micromips: Fix improper definition of ISA exception
 bit.
References: <1370461798-20296-1-git-send-email-Steven.Hill@imgtec.com> <51AF9923.7000606@cogentembedded.com> <51AFA879.1010009@gmail.com>
In-Reply-To: <51AFA879.1010009@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Gm-Message-State: ALoCoQk8vJuiZ+SBPdrAn0KUTtgyGAvFes2ZTFv56HJMNuLA6VnQ5qFQwyqZkl0WnNzEf9mLzDDK
Return-Path: <sergei.shtylyov@cogentembedded.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36713
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sergei.shtylyov@cogentembedded.com
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

On 06/06/2013 01:07 AM, David Daney wrote:
> On 06/05/2013 01:01 PM, Sergei Shtylyov wrote:
>> Hello.
>>
>> On 06/05/2013 11:49 PM, Steven J. Hill wrote:
>>
>>> The ISA exception bit selects whether exceptions are taken in classic
>>> or microMIPS mode. This bit is Config3.ISAOnExc and was improperly
>>> defined as bits 16 and 17 instead of just bit 16. A new function was
>>> added so that platforms could set this bit when running a kernel
>>> compiled with only microMIPS instructions.
>>
>>      Ahem, isn't that function a material for another patch?
>
>
> I think you might be going overboard.  The entire patch relates to 
> exactly one bit a config register, can't you let it be a single patch?

    The purpose of the patch declared in its subject is just to fix the 
bit itself.
Instead the patch does zillion other things, which IMHO not even always 
can be
considered fixes, so no, I'm not feeling like I'm going overboard with this.

> David Daney

WBR, Sergei
