Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 26 Apr 2010 19:06:56 +0200 (CEST)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:11686 "EHLO
        mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492649Ab0DZRGs (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 26 Apr 2010 19:06:48 +0200
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,7,2,8378)
        id <B4bd5c8330001>; Mon, 26 Apr 2010 10:06:59 -0700
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
         Mon, 26 Apr 2010 10:06:05 -0700
Received: from dd1.caveonetworks.com ([12.108.191.236]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
         Mon, 26 Apr 2010 10:06:05 -0700
Message-ID: <4BD5C7F8.6050406@caviumnetworks.com>
Date:   Mon, 26 Apr 2010 10:06:00 -0700
From:   David Daney <ddaney@caviumnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.9) Gecko/20100330 Fedora/3.0.4-1.fc12 Thunderbird/3.0.4
MIME-Version: 1.0
To:     Giant Sand Fan's <rampxxxx@gmail.com>
CC:     linux-mips@linux-mips.org
Subject: Re: Cavium mips64 perf counters
References: <l2p417f50831004260640o684d0f8fgf6a3aa60450e329c@mail.gmail.com>
In-Reply-To: <l2p417f50831004260640o684d0f8fgf6a3aa60450e329c@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 26 Apr 2010 17:06:05.0573 (UTC) FILETIME=[C1E02B50:01CAE562]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26474
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

On 04/26/2010 06:40 AM, Giant Sand Fan's wrote:
> Hi,
>
> I'm trying to calculate de CPU load by access the performance counters
> in mips and I haved reading in the cp0 but my problem is that I cannot
> find documentation about the real meaning of these counters :
>
> 1.-LOG_PERF_CNT_NISSUE : ¿means cycle with no issue?
>
> 2.-LOG_PERF_CNT_SISSUE : ¿means cycle with     issue?

Single issue.

>
> 3.-LOG_PERF_CNT_DISSUE: ¿means cycle with double issue?
>

That's right.  And PERF_CNT_CLK is the number of cycles.

David Daney
