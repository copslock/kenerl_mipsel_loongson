Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 13 May 2011 20:57:38 +0200 (CEST)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:1191 "EHLO
        mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491870Ab1EMS5d (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 13 May 2011 20:57:33 +0200
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,7,2,8378)
        id <B4dcd7f590000>; Fri, 13 May 2011 11:58:33 -0700
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.4675);
         Fri, 13 May 2011 11:57:30 -0700
Received: from dd1.caveonetworks.com ([12.108.191.236]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.4675);
         Fri, 13 May 2011 11:57:30 -0700
Message-ID: <4DCD7F1A.3040904@caviumnetworks.com>
Date:   Fri, 13 May 2011 11:57:30 -0700
From:   David Daney <ddaney@caviumnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.15) Gecko/20101027 Fedora/3.0.10-1.fc12 Thunderbird/3.0.10
MIME-Version: 1.0
To:     "Jayachandran C." <jayachandranc@netlogicmicro.com>
CC:     Kevin Cernekee <cernekee@gmail.com>,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] MIPS: Replace _PAGE_READ with _PAGE_NO_READ
References: <7aa38c32b7748a95e814e5bb0583f967@localhost> <20110513150707.GA26389@linux-mips.org> <BANLkTikcyEzjOWt9pWToE=89dySSEYbw_g@mail.gmail.com> <20110513155605.GA30674@linux-mips.org> <BANLkTinnALQV6dXkJ0AjaQ1=bTawYMMkuQ@mail.gmail.com> <20110513173633.GA14607@jayachandranc.netlogicmicro.com> <BANLkTim+z7TSCvNA2duA6LsUzNsiu9OQaQ@mail.gmail.com> <20110513184532.GC14607@jayachandranc.netlogicmicro.com>
In-Reply-To: <20110513184532.GC14607@jayachandranc.netlogicmicro.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 13 May 2011 18:57:30.0519 (UTC) FILETIME=[9C367A70:01CC119F]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 30017
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

On 05/13/2011 11:45 AM, Jayachandran C. wrote:
> On Fri, May 13, 2011 at 10:51:44AM -0700, Kevin Cernekee wrote:
>> On Fri, May 13, 2011 at 10:36 AM, Jayachandran C.
>> <jayachandranc@netlogicmicro.com>  wrote:
>>> For 32-bit the config is nlm_xlr_defconfig in the source tree. Let me know if
>>> you need any further info.
>>
>> Would you be able to dump out the TLB handlers in this configuration,
>> per David's suggestion?
>
> The current linux-mips queue works for me, and I don't have the old source
> or binaries with me anymore. You surely should be able build with
> nlm_xlr_defconfig and see if the rixi is enabled in the build, if you want
> any config register dump on the CPU, please let me know.

The problem is that we don't have your hardware to test anything on.

Kevin's patches are a good cleanup, but we cannot use them if they break 
things.  So the ideal situation would be for people maintaining the 
failing ports to help figure out where they fail.

David Daney
