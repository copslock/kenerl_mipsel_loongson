Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 07 Oct 2010 03:26:30 +0200 (CEST)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:5081 "EHLO
        mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491159Ab0JGB00 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 7 Oct 2010 03:26:26 +0200
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,7,2,8378)
        id <B4cad21e00000>; Wed, 06 Oct 2010 18:26:56 -0700
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.4675);
         Wed, 6 Oct 2010 18:26:29 -0700
Received: from dd1.caveonetworks.com ([12.108.191.236]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.4675);
         Wed, 6 Oct 2010 18:26:29 -0700
Message-ID: <4CAD21BD.8050203@caviumnetworks.com>
Date:   Wed, 06 Oct 2010 18:26:21 -0700
From:   David Daney <ddaney@caviumnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.12) Gecko/20100907 Fedora/3.0.7-1.fc12 Thunderbird/3.0.7
MIME-Version: 1.0
To:     Ralf Baechle <ralf@linux-mips.org>, rostedt@goodmis.org
CC:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        jbaron@redhat.com
Subject: Re: [PATCH v2 2/2] jump label: Add MIPS support.
References: <1286218615-24011-1-git-send-email-ddaney@caviumnetworks.com> <1286218615-24011-3-git-send-email-ddaney@caviumnetworks.com> <20101006230010.GA6808@linux-mips.org>
In-Reply-To: <20101006230010.GA6808@linux-mips.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 07 Oct 2010 01:26:29.0179 (UTC) FILETIME=[AAAC20B0:01CB65BE]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 27970
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

On 10/06/2010 04:00 PM, Ralf Baechle wrote:
> Acked-by: Ralf Baechle<ralf@linux-mips.org>
>
>    Ralf
>

That should complete the Acked-by prerequisites for this set.  I hope 
Steven and Jason can get them merged for 2.6.37 (hint, hint :-))

Thanks,
David Daney
