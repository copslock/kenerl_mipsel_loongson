Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 20 Jan 2015 10:52:48 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:18283 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27011100AbbATJwqp3ghV (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 20 Jan 2015 10:52:46 +0100
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 56DB93D23D0A1;
        Tue, 20 Jan 2015 09:52:39 +0000 (GMT)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Tue, 20 Jan 2015 09:52:41 +0000
Received: from [192.168.154.96] (192.168.154.96) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.210.2; Tue, 20 Jan
 2015 09:52:40 +0000
Message-ID: <54BE2568.5080105@imgtec.com>
Date:   Tue, 20 Jan 2015 09:52:40 +0000
From:   Markos Chandras <Markos.Chandras@imgtec.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.4.0
MIME-Version: 1.0
To:     "Maciej W. Rozycki" <macro@linux-mips.org>
CC:     <linux-mips@linux-mips.org>,
        Matthew Fortune <Matthew.Fortune@imgtec.com>
Subject: Re: [PATCH RFC v2 12/70] MIPS: asm: asmmacro: Replace add instructions
 with "addui"
References: <1421405389-15512-1-git-send-email-markos.chandras@imgtec.com> <1421405389-15512-13-git-send-email-markos.chandras@imgtec.com> <alpine.LFD.2.11.1501190651440.28301@eddie.linux-mips.org> <54BD3355.9010104@imgtec.com> <alpine.LFD.2.11.1501191901370.28301@eddie.linux-mips.org> <alpine.LFD.2.11.1501191917060.28301@eddie.linux-mips.org>
In-Reply-To: <alpine.LFD.2.11.1501191917060.28301@eddie.linux-mips.org>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.154.96]
Return-Path: <Markos.Chandras@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45359
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Markos.Chandras@imgtec.com
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

On 01/19/2015 07:25 PM, Maciej W. Rozycki wrote:
> On Mon, 19 Jan 2015, Maciej W. Rozycki wrote:
> 
>>> sorry i might be missing something but why do you think this is an
>>> important bug fix that should go into 3.19? the way i read the code it
>>> seems that it can't go wrong at the moment.
>>
>>  We shouldn't be using trapping instructions for address calculation.  
>> These macros have been wrong since the beginning, the MSA instructions 
>> they correspond to do not trigger an exception on an integer overflow in 
>> address calculation (none of the MIPS instruction does).
> 
>  And BTW, it is a bug in GAS too, that it does not accept ADDI for R6 -- 
> it should treat the instruction as a macro and expand it to an equivalent 
> LI + ADD sequence (using $at or `rd', if available, as a temporary to 
> store the immediate).  Similarly to how microMIPS DADDI is handled for 
> example (where the hardware instruction has an unusually limited range of 
> the immediate argument, however GAS accepts any 16-bit).
> 
>   Maciej
> 
CC'ing Matthew

-- 
markos
