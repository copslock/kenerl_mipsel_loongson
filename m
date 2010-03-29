Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 29 Mar 2010 18:54:22 +0200 (CEST)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:3856 "EHLO
        mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492236Ab0C2QyS (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 29 Mar 2010 18:54:18 +0200
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,7,2,8378)
        id <B4bb0db430000>; Mon, 29 Mar 2010 09:54:27 -0700
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
         Mon, 29 Mar 2010 09:54:07 -0700
Received: from dd1.caveonetworks.com ([12.108.191.236]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
         Mon, 29 Mar 2010 09:54:07 -0700
Message-ID: <4BB0DB2A.9080405@caviumnetworks.com>
Date:   Mon, 29 Mar 2010 09:54:02 -0700
From:   David Daney <ddaney@caviumnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.8) Gecko/20100301 Fedora/3.0.3-1.fc12 Thunderbird/3.0.3
MIME-Version: 1.0
To:     Andreas Barth <aba@not.so.argh.org>
CC:     Peter 'p2' De Schrijver <p2@debian.org>, linux-mips@linux-mips.org
Subject: Re: movidis x16 hard lockup using 2.6.33
References: <20100326184132.GU2437@apfelkorn> <4BAD03A5.9070701@caviumnetworks.com> <20100327230744.GG27216@mails.so.argh.org>
In-Reply-To: <20100327230744.GG27216@mails.so.argh.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 29 Mar 2010 16:54:07.0435 (UTC) FILETIME=[724401B0:01CACF60]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26332
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

On 03/27/2010 04:07 PM, Andreas Barth wrote:
> * David Daney (ddaney@caviumnetworks.com) [100326 19:57]:
>> Also you could try running with the attached patch.  It is not the best
>> watchdog, but it will print the register state for each core when things
>> get stuck.  Occasionally that is enough to see where the problem is.
>
> Thanks.
>
> As our logging has only limited buffer size, I'd be happy about an
> variant of the patch which doesn't reboot but just let the machine
> hang after the third occurence.
>
> Any chances for it?
>

You could just sit in a loop kicking the watchdog timer after you get to 
the NMI handler.  That should prevent a reset, but still print the 
machine state.

David Daney
