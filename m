Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 16 Dec 2009 23:08:26 +0100 (CET)
Received: from mail-bw0-f221.google.com ([209.85.218.221]:49025 "EHLO
        mail-bw0-f221.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1494504AbZLPWIT convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 16 Dec 2009 23:08:19 +0100
Received: by bwz21 with SMTP id 21so1128105bwz.24
        for <linux-mips@linux-mips.org>; Wed, 16 Dec 2009 14:08:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=ZQN8IX6nCa2CjaR9ADBOQ+dR7E/+uEvqhj+tbiYmdro=;
        b=rFG1uWLLQLCDgv8RYGCAhNs2FU3oEAkefeD/dwNyWuOhqh4gp5hxsWtIRQfBIKQ2q2
         ptdWcS2R4+SVv2XlpEptZ/vdpXkQnQWa1++kYfFdwFJEqFWk8KgLysniAgpPDtI5dKnU
         YXmWoUJ80Vk17qQp5AFU0b82MFaDgNoXyB7no=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=Z4jEvrsyzxiwE88BEoxPsbhc48j+7PMb9M5XlSu2XLzoI9lRZjAS4Cc626dH4HkZkd
         H3ct0hYLzGDRF7tn307vThM5IBBM5oVrF7dNlCFXQTs+TObX5MAQeLvX/NaSo0RLHkUb
         1sOWCUJtmVh6EsuC+D17nYq98WnUAUYvPvsBY=
MIME-Version: 1.0
Received: by 10.204.5.75 with SMTP id 11mr901919bku.20.1261001292237; Wed, 16 
        Dec 2009 14:08:12 -0800 (PST)
In-Reply-To: <4AE0DB98.1000101@caviumnetworks.com>
References: <4AE0D14B.1070307@caviumnetworks.com> <4AE0D72A.4090607@nortel.com>
         <4AE0DB98.1000101@caviumnetworks.com>
Date:   Wed, 16 Dec 2009 17:08:11 -0500
Message-ID: <b2f3590f0912161408u73947f6fx6902ebef927caf94@mail.gmail.com>
Subject: Re: Irq architecture for multi-core network driver.
From:   Chetan Loke <chetanloke@gmail.com>
To:     David Daney <ddaney@caviumnetworks.com>
Cc:     Chris Friesen <cfriesen@nortel.com>, netdev@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-mips <linux-mips@linux-mips.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-Path: <chetanloke@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25409
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: chetanloke@gmail.com
Precedence: bulk
X-list: linux-mips

>>
>> Does your hardware do flow-based queues?  In this model you have
>> multiple rx queues and the hardware hashes incoming packets to a single
>> queue based on the addresses, ports, etc. This ensures that all the
>> packets of a single connection always get processed in the order they
>> arrived at the net device.
>>
>
> Indeed, this is exactly what we have.
>
>
>> Typically in this model you have as many interrupts as queues
>> (presumably 16 in your case).  Each queue is assigned an interrupt and
>> that interrupt is affined to a single core.
>

> Certainly this is one mode of operation that should be supported, but I
> would also like to be able to go for raw throughput and have as many cores
> as possible reading from a single queue (like I currently have).
>
Well, you could let the NIC firmware(f/w) handle this. The f/w would
know which interrupt was just injected recently.In other words it
would have a history of which CPU's would be available. So if some
previously interrupted CPU isn't making good progress then the
firmware should route the incoming response packets to a different
queue. This way some other CPU will pick it up.


> David Daney
> --
Chetan Loke
