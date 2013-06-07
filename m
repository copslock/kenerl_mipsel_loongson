Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 10 Jun 2013 13:17:33 +0200 (CEST)
Received: from mail-pb0-f51.google.com ([209.85.160.51]:57274 "EHLO
        mail-pb0-f51.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6824790Ab3FGQZT2M6X3 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 7 Jun 2013 18:25:19 +0200
Received: by mail-pb0-f51.google.com with SMTP id um15so4840252pbc.24
        for <linux-mips@linux-mips.org>; Fri, 07 Jun 2013 09:25:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=N+6iEO6mW5FK9wuvWdzHV0nhtl5hQFSKxrNjpuS3wrY=;
        b=k6k1p8/jLhED0BzDSgzaV2e1+GMttTro8IBVvCCay0kvldEYZVJ5GTTji7dXIsGkAV
         4V8PuVuRxN2Q+NemPFCF8fK0O9oG6ICsX3/xUfVhgs7B1SUXvzBsB1oVhseUm2AeZ1TT
         GGkL/91t5K/4/TsCdwVeqK8Zk7JeUkvQZaJlNfAvH+44NTLZUeB/rBkfMi+GuzPjm6YH
         1JRI/aeqpzKxXRIDQ7E+ZroujfGM6YOZUYah4/QOAl6tEVwn3EClBJgrArLbJLNh/2Ob
         4oXa9Bj2K2IIJ5ZSh5cF6THGIe7TwAmSwRYhdSo7Gf7LMQoLTHzP0gdmK/ERX+hbztrf
         Ypmw==
X-Received: by 10.68.233.98 with SMTP id tv2mr43872018pbc.146.1370622312432;
        Fri, 07 Jun 2013 09:25:12 -0700 (PDT)
Received: from dl.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPSA id kv2sm78200478pbc.28.2013.06.07.09.25.10
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Fri, 07 Jun 2013 09:25:11 -0700 (PDT)
Message-ID: <51B20965.3060903@gmail.com>
Date:   Fri, 07 Jun 2013 09:25:09 -0700
From:   David Daney <ddaney.cavm@gmail.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130311 Thunderbird/17.0.4
MIME-Version: 1.0
To:     Alexis BRENON <abrenon@wyplay.com>
CC:     linux-mips@linux-mips.org
Subject: Re: Immediate branch offset
References: <51B1B739.7080104@wyplay.com>
In-Reply-To: <51B1B739.7080104@wyplay.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <ddaney.cavm@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36797
X-Approved-By: ralf@linux-mips.org
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

On 06/07/2013 03:34 AM, Alexis BRENON wrote:
> Hi everyone,
>
> I'm new on the list, so I'll make a short introduction of me.
> First of all, I'm french, so, please, be indulgent for my english
> mistakes...
> I'm working on the Pypy project, to create a MIPS backend (a MIPS JIT).
>
> To create the JIT, I have to load some MIPS instruction directly in
> memory without passing through a .asm file or else. So, I cannot set
> some labels. So to make some branches, I try to load the equivalent
> instruction of :
>      bne $t0, $t1, -8
> to go back, just before the bne instruction, if $t0 and $t1 are equals.
> But when it run, I've got an illegal instruction error.
> To debug, I write a small program in the MARS MIPS simulator with this
> instruction. But when compiling, assembler says me that -8 is an operand
> of incorrect type.


Dump out your program so you can disassemble it with objdump -d (or 
dissassemble it with gdb)  And verify that the code looks good.

David Daney


> I would like to know if it's possible to make a branch, with an
> immediate offset, or have I to always provide a label ?
>
> I hope my question is clear.
> Thanks for your attention, and for your answer :-p
>
> Alexis BRENON
>
> P.S. I try to go to the IRC channel, but I receive '#mipslinux :Cannot
> send to channel' every time  I send message. Is there any particular
> process to join the channel ?
>
>
>
