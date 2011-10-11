Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 11 Oct 2011 20:43:29 +0200 (CEST)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:12859 "EHLO
        mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491771Ab1JKSnY (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 11 Oct 2011 20:43:24 +0200
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,7,2,8378)
        id <B4e948e980000>; Tue, 11 Oct 2011 11:44:40 -0700
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.4675);
         Tue, 11 Oct 2011 11:43:22 -0700
Received: from dd1.caveonetworks.com ([64.2.3.195]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.4675);
         Tue, 11 Oct 2011 11:43:22 -0700
Message-ID: <4E948E48.60205@cavium.com>
Date:   Tue, 11 Oct 2011 11:43:20 -0700
From:   David Daney <david.daney@cavium.com>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.15) Gecko/20101027 Fedora/3.0.10-1.fc12 Thunderbird/3.0.10
MIME-Version: 1.0
To:     Joe Buehler <aspam@cox.net>
CC:     linux-mips@linux-mips.org
Subject: Re: using mprotect to write to .text
References: <loom.20111010T215444-70@post.gmane.org> <4E9470A1.8020309@cavium.com> <4E947D8A.9090409@cox.net> <4E948593.6030604@cavium.com> <4E948C62.3000802@cox.net>
In-Reply-To: <4E948C62.3000802@cox.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 11 Oct 2011 18:43:22.0166 (UTC) FILETIME=[A6EE5560:01CC8845]
X-archive-position: 31225
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: david.daney@cavium.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 7473

Two points you may not be aware of:

1) cacheflush() clears all hazards.

2) There are no hazards on Octeon.


On 10/11/2011 11:35 AM, Joe Buehler wrote:
> David Daney wrote:
>
>> I cannot parse the meaning out of these last two sentences.  The
>> cacheflush() system call both exists and works.  You want to change it?
>
> Let me rewind a bit.  I have a multithreaded binary running on multiple
> physical CPUs.  As part of a debugging mechanism, I want to make changes
> to .text from a thread dedicated to the purpose.  This requires at the
> least icache flushes on all CPUs but also hazard avoidance measures on
> all CPUs.  So I understand anyway.
>
> The cacheflush call will do the flush but not the hazard avoidance.  In
> order to solve my particular issue I am thinking about adding the hazard
> avoidance into cacheflush for my particular application.  It is not a
> question of cacheflush being wrong, but of extending it to meet my
> needs.  In fact, it seems like a useful change -- it will allow an
> application to do exactly what I want to do, and easily so, and would
> seem a logical place for the functionality to reside.
>
> Sorry if I seem a bit muddled -- this is extremely low level and not
> what I deal with day to day.
>
> Joe Buehler
>
