Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 11 Oct 2011 18:36:59 +0200 (CEST)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:5801 "EHLO
        mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491773Ab1JKQgy (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 11 Oct 2011 18:36:54 +0200
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,7,2,8378)
        id <B4e9470f20000>; Tue, 11 Oct 2011 09:38:10 -0700
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.4675);
         Tue, 11 Oct 2011 09:36:51 -0700
Received: from dd1.caveonetworks.com ([64.2.3.195]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.4675);
         Tue, 11 Oct 2011 09:36:51 -0700
Message-ID: <4E9470A1.8020309@cavium.com>
Date:   Tue, 11 Oct 2011 09:36:49 -0700
From:   David Daney <david.daney@cavium.com>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.15) Gecko/20101027 Fedora/3.0.10-1.fc12 Thunderbird/3.0.10
MIME-Version: 1.0
To:     Joe Buehler <aspam@cox.net>
CC:     linux-mips@linux-mips.org
Subject: Re: using mprotect to write to .text
References: <loom.20111010T215444-70@post.gmane.org>
In-Reply-To: <loom.20111010T215444-70@post.gmane.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 11 Oct 2011 16:36:51.0911 (UTC) FILETIME=[FAC95570:01CC8833]
X-archive-position: 31221
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: david.daney@cavium.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 7319

On 10/10/2011 01:02 PM, Joe Buehler wrote:
> I intend to use mprotect in a running binary to allow it to modify its .text
> section.  The detailed behavior of mprotect for a multithreaded program on SMP
> hardware is not documented as far as I can tell.

It is well documented.  What is not well defined is what happens if you 
modify the code and then try to execute it.

>
> Can I depend on the LINUX mprotect call to take care of icache flushing,
> handling of hazards, etc.?

No, it does nothing of the sort.  You need cacheflush() for that.

>  I am using Octeon CN5650 on 2.6.21.7 and 2.6.27.7 if
> it matters.

It doesn't really matter.

What you need is something like:

#include <sys/cachectl.h>
.
.
.


cacheflush(location, size, ICACHE);
.
.
.

David Daney
